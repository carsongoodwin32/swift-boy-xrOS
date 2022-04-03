// TODO: Figure out a good default for master volume 🤔
// TODO: Get rid of unecessary 'self' references? Or at least be consistent..
// TODO: Startup sound is still a bit off
// TODO: Super Mario menu produces a high pitched sound.. I think this is somehow related to the sweepTime on the FrequencySweepEnvelop
// TODO: Not sure if the custom waveform data needs to be remapped between -1 and 1
// TODO: Remove debugging lines where all amplitudes are hardcoded to 1
// TODO: Think there is something wrong with how amplitudes are set and or the amplitude envelope
// TODO: Refactor other voice functions to match custom wave

import Foundation
import AudioKit
import SoundpipeAudioKit

func bitsToFrequency(bits: UInt16) -> Float {
    return 131072 / (2048 - Float(bits))
}

func frequencyToBits(frequency: Float) -> UInt16 {
    return UInt16(2048 - (131072 / frequency))
}

protocol OscillatorNode: Node {
    var frequency: Float { get set }
    var amplitude: Float { get set }
    func rampFrequency(to: Float, duration: Float)
    func rampAmplitude(to: Float, duration: Float)
}

class Voice {
    private let oscillator: OscillatorNode
    
    private(set) var panner: Panner
    private(set) var leftChannelOn = true
    private(set) var rightChannelOn = true
        
    var muted: Bool = false
    var stopped: Bool = false
    var amplitude: Float = 0
    
    var frequency: Float {
        get {
            oscillator.frequency
        }
        set {
            oscillator.rampFrequency(to: newValue, duration: 0.01)
        }
    }
    
    var pan: Float {
        get {
            panner.pan
        }
        set {
            panner.$pan.ramp(to: newValue, duration: 0.01)
        }
    }
    
    var triggered: Bool = false {
        didSet {
            if triggered && triggered != oldValue {
                onTriggered()
            }
        }
    }
    
    init(oscillator: OscillatorNode) {
        self.oscillator = oscillator
        self.oscillator.start()
        self.oscillator.amplitude = 0
        self.oscillator.frequency = 0
        self.panner = Panner(oscillator)
    }
    
    func onTriggered() { }
    
    func setChannels(left: Bool, right: Bool) {
        if left && right {
            pan = 0
        } else if left {
            pan = -1
        } else if right {
            pan = 1
        }
        
        leftChannelOn = left
        rightChannelOn = right
    }
    
    func update() {
        if !leftChannelOn && !rightChannelOn {
            oscillator.rampAmplitude(to: 0, duration: 0.01)
            return
        }
        
        if muted {
            oscillator.rampAmplitude(to: 0, duration: 0.01)
            return
        }
        
        if stopped {
            oscillator.rampAmplitude(to: 0, duration: 0.01)
            return
        }
        
        oscillator.rampAmplitude(to: amplitude, duration: 0.01)
    }
}

class Synthesizer {
    let voices: [Voice]
    let engine: AudioEngine
    let mixer: Mixer
    
    public var volume: Float {
        get {
            engine.mainMixerNode?.volume ?? 0
        }
        set {
            engine.mainMixerNode?.volume  = newValue
        }
    }
    
    var enabled = false {
        didSet {
            if enabled && !engine.avEngine.isRunning {
                try? self.engine.start()
            }
            
            if !enabled && engine.avEngine.isRunning {
                self.engine.stop()
            }
        }
    }
    
    init(volume: Float = 0.5, voices: [Voice]) {
        self.voices = voices
        self.mixer = Mixer(voices.map({ $0.panner }))
        self.engine = AudioEngine()
        self.engine.output = mixer
        self.engine.mainMixerNode?.volume = volume
    }
}

enum EnvelopeStatus {
    case active
    case deactivated
    case notApplicable
}

protocol Envelope {
    var voice: Voice? { get set }
    func advance(seconds: Float) -> EnvelopeStatus
    func reset() -> Void
}

class AmplitudeEnvelope: Envelope {
    private var elapsedTime: Float = 0
    
    var voice: Voice?
    
    var startStep: Int = 0 {
        didSet {
            if startStep != oldValue {
                reset()
            }
        }
    }
    
    var increasing = false {
        didSet {
            if increasing != oldValue {
                reset()
            }
        }
    }
    
    var stepDuration: Float = 0 {
        didSet {
            if stepDuration != oldValue {
                reset()
            }
        }
    }
    
    init(_ voice: Voice? = nil) {
        self.voice = voice
    }
    
    @discardableResult func advance(seconds: Float) -> EnvelopeStatus {
        if stepDuration == 0 {
            return .notApplicable
        }
        
        elapsedTime += seconds
          
        let deltaSteps = Int(elapsedTime / stepDuration) * (increasing ? 1 : -1)
        let currentStep = (startStep + deltaSteps).clamp(min: 0, max: 0x0F)
        
        voice?.amplitude = Float(currentStep) / 0x0F
        
        return .notApplicable
    }
    
    func reset() {
        elapsedTime = 0
        voice?.amplitude = Float(startStep) / 0x0F
        
        if stepDuration == 0 {
            voice?.muted = true
        } else {
            voice?.muted = false
        }
    }
}

class LengthEnvelope: Envelope {
    private var elapsedTime: Float = 0
    
    var voice: Voice?
    
    var enabled = false {
        didSet {
            if enabled != oldValue {
                reset()
            }
        }
    }
    
    var duration: Float = 0 {
        didSet {
            if duration != oldValue {
                reset()
            }
        }
    }
    
    init(_ voice: Voice? = nil) {
        self.voice = voice
    }
    
    func advance(seconds: Float) -> EnvelopeStatus {
        if !enabled {
            return .notApplicable
        }
        
        if elapsedTime < duration {
            elapsedTime += seconds
            
            return .active
        }
        
        return .deactivated
    }
    
    func reset() {
        elapsedTime = 0
    }
}

class FrequencySweepEnvelope: Envelope {
    private var elapsedTime: Float = 0
    private var adjustedFrequency: Float = 0 {
        didSet {
            if adjustedFrequency != oldValue {
                voice?.frequency = adjustedFrequency
            }
        }
    }
    
    var voice: Voice?
    
    var startFrequency: Float = 0 {
        didSet {
            if startFrequency != oldValue {
                reset()
            }
        }
    }
    
    var sweepIncreasing = false {
        didSet {
            if sweepIncreasing != oldValue {
                reset()
            }
        }
    }
    
    var sweepShifts: UInt8 = 0 {
        didSet {
            if sweepShifts != oldValue {
                reset()
            }
        }
    }
    
    var sweepTime: Float = 0 {
        didSet {
            if  sweepTime != oldValue {
                reset()
            }
        }
    }
    
    init(_ voice: Voice? = nil) {
        self.voice = voice
    }
    
    func advance(seconds: Float) -> EnvelopeStatus {
        if startFrequency == 0 {
            return .notApplicable
        }
        
        if sweepTime == 0 {
            return .notApplicable
        }
        
        if sweepShifts == 0 {
            return .notApplicable
        }
        
        elapsedTime += seconds
        
        let sweeps = Int(elapsedTime / sweepTime)
        let totalShifts = sweeps > 0 ? sweeps * Int(sweepShifts) : 0
        let shiftedValue = sweepIncreasing ? frequencyToBits(frequency: startFrequency) << totalShifts : frequencyToBits(frequency: startFrequency) >> totalShifts
        
        if shiftedValue == 0 {
            return .deactivated
        }
        
        if shiftedValue > 2047 {
            return .deactivated
        }
        
        adjustedFrequency = bitsToFrequency(bits: shiftedValue)
        
        return .active
    }
    
    func reset() {
        elapsedTime = 0
        adjustedFrequency = startFrequency
    }
}

extension PWMOscillator: OscillatorNode {
    func rampFrequency(to: Float, duration: Float) {
        $frequency.ramp(to: to, duration: duration)
    }
    
    func rampAmplitude(to: Float, duration: Float) {
       $amplitude.ramp(to: to, duration: duration)
    }
}

class Pulse: Voice {
    let wave = PWMOscillator()
    let amplitudeEnvelope = AmplitudeEnvelope()
    let lengthEnvelope = LengthEnvelope()
        
    init() {
        super.init(oscillator: wave)

        amplitudeEnvelope.voice = self
        lengthEnvelope.voice = self
    }
    
    override func onTriggered() {
        amplitudeEnvelope.reset()
        lengthEnvelope.reset()
    }
}

class PulseWithSweep: Pulse {
    let frequencySweepEnvelope = FrequencySweepEnvelope()
        
    override init() {
        super.init()
        
        frequencySweepEnvelope.voice = self
    }
    
    override func onTriggered() {
        super.onTriggered()
        
        frequencySweepEnvelope.reset()
    }
}

extension Oscillator: OscillatorNode {
    func rampFrequency(to: Float, duration: Float) {
        $frequency.ramp(to: to, duration: duration)
    }
    
    func rampAmplitude(to: Float, duration: Float) {
       $amplitude.ramp(to: to, duration: duration)
    }
}

class CustomWave: Voice {
    let wave = Oscillator(waveform: Table(.sine))
    let lengthEnvelope = LengthEnvelope()
    
    var data = [Float]() {
        didSet {
            if data != oldValue {
                wave.au.setWavetable(Table(data).content)
            }
        }
    }
        
    init() {
        super.init(oscillator: wave)

        lengthEnvelope.voice = self
    }
    
    override func onTriggered() {
        lengthEnvelope.reset()
    }
}

public class APU {
    private let mmu: MMU
    private let master: Synthesizer
    private let pulseA: PulseWithSweep
    private let pulseB: Pulse
    private let customWave: CustomWave
    private var waveformDataMemo = Memo<[Float]>()
    
    init(_ mmu: MMU) {
        self.mmu = mmu
        self.pulseA = PulseWithSweep()
        self.pulseB = Pulse()
        self.customWave = CustomWave()
        self.master = Synthesizer(voices: [self.pulseA, self.pulseB, self.customWave])
        self.master.volume = 0.125
    }
    
    func playPulseA(seconds: Float) -> Bool {
        var playing = true
        
        let nr14 = self.mmu.nr14.read()
        let nr13 = self.mmu.nr13.read()
        let nr12 = self.mmu.nr12.read()
        let nr11 = self.mmu.nr11.read()
        let nr10 = self.mmu.nr10.read()
        
        self.pulseA.frequencySweepEnvelope.startFrequency = bitsToFrequency(bits: UInt16(nr13) + (UInt16(nr14 & 0b00000111) << 8))
        self.pulseA.frequencySweepEnvelope.sweepShifts = nr10 & 0b00000111
        self.pulseA.frequencySweepEnvelope.sweepIncreasing = nr10.bit(3)
        
        switch ((nr10 & 0b01110000) >> 4) {
        case 0b000: self.pulseA.frequencySweepEnvelope.sweepTime = 0
        case 0b001: self.pulseA.frequencySweepEnvelope.sweepTime = 0.0078
        case 0b010: self.pulseA.frequencySweepEnvelope.sweepTime = 0.0156
        case 0b011: self.pulseA.frequencySweepEnvelope.sweepTime = 0.0234
        case 0b100: self.pulseA.frequencySweepEnvelope.sweepTime = 0.0313
        case 0b101: self.pulseA.frequencySweepEnvelope.sweepTime = 0.0391
        case 0b110: self.pulseA.frequencySweepEnvelope.sweepTime = 0.0469
        case 0b111: self.pulseA.frequencySweepEnvelope.sweepTime = 0.0547
        default: print("Sweep time not handled for PulseA")
        }
        
        let pulseASweepStatus = self.pulseA.frequencySweepEnvelope.advance(seconds: seconds)
        
        if pulseASweepStatus == .deactivated {
            playing = false
        }
        
        self.pulseA.amplitudeEnvelope.startStep = Int((nr12 & 0b11110000) >> 4)
        self.pulseA.amplitudeEnvelope.stepDuration = Float(nr12 & 0b00000111) * 1 / 64
        self.pulseA.amplitudeEnvelope.increasing = nr12.bit(3)
        self.pulseA.amplitudeEnvelope.advance(seconds: seconds)
        
        self.pulseA.lengthEnvelope.enabled = nr14.bit(6)
        self.pulseA.lengthEnvelope.duration = (64 - Float(nr11 & 0b00111111)) * (1 / 256)
        let pulseALengthStatus = self.pulseA.lengthEnvelope.advance(seconds: seconds)
        
        if pulseALengthStatus == .deactivated {
           playing = false
        }
        
        switch (nr11 & 0b11000000) {
        case 0b00000000: self.pulseA.wave.pulseWidth = 0.125;
        case 0b01000000: self.pulseA.wave.pulseWidth = 0.25
        case 0b10000000: self.pulseA.wave.pulseWidth = 0.5
        case 0b11000000: self.pulseA.wave.pulseWidth = 0.75
        default: print("Duty pattern not handled for PulseA")
        }
        
        self.pulseA.triggered = nr14.bit(7)
        self.pulseA.stopped = !playing
        
        return playing
    }
    
    func playPulseB(seconds: Float) -> Bool {
        var playing = true
        
        let nr24 = self.mmu.nr24.read()
        let nr23 = self.mmu.nr23.read()
        let nr22 = self.mmu.nr22.read()
        let nr21 = self.mmu.nr21.read()
        
        self.pulseB.frequency = bitsToFrequency(bits: UInt16(nr23) + (UInt16(nr24 & 0b00000111) << 8))
        
        self.pulseB.amplitudeEnvelope.startStep = Int((nr22 & 0b11110000) >> 4)
        self.pulseB.amplitudeEnvelope.stepDuration = Float(nr22 & 0b00000111) * 1 / 64
        self.pulseB.amplitudeEnvelope.increasing = nr22.bit(3)
        self.pulseB.amplitudeEnvelope.advance(seconds: seconds)
        
        self.pulseB.lengthEnvelope.enabled = nr24.bit(6)
        self.pulseB.lengthEnvelope.duration = (64 - Float(nr21 & 0b00111111)) * (1 / 256)
        let pulseBLengthStatus = self.pulseB.lengthEnvelope.advance(seconds: seconds)
        
        if pulseBLengthStatus == .deactivated {
            playing = false
        }
        
        switch(nr21 & 0b11000000) {
        case 0b00000000: self.pulseB.wave.pulseWidth = 0.125
        case 0b01000000: self.pulseB.wave.pulseWidth = 0.25
        case 0b10000000: self.pulseB.wave.pulseWidth = 0.5
        case 0b11000000: self.pulseB.wave.pulseWidth = 0.75
        default: print("Duty pattern not handled for PulseB")
        }
        
        self.pulseB.triggered = nr24.bit(7)
        self.pulseB.stopped = !playing
        
        return playing
    }
    
    func playWaveform(seconds: Float) -> Bool {
        let nr30 = self.mmu.nr30.read()
        let nr31 = self.mmu.nr31.read()
        let nr32 = self.mmu.nr32.read()
        let nr33 = self.mmu.nr33.read()
        let nr34 = self.mmu.nr34.read()
        
        var playing = nr30.bit(7)
        
        defer {
            self.customWave.stopped = !playing
        }
        
        let lengthEnvelopeDuration = (256 - Float(nr31)) * (1 / 256)
        let outputLevel = (nr32 & 0b01100000) >> 5
        let frequencyInBits = UInt16(nr33) + (UInt16(nr34 & 0b00000111) << 8)
        let lengthEnvelopEnabled = nr34.bit(6)
        let triggered = nr34.bit(7)
        let waveformData = self.waveformDataMemo.get(deps: [self.mmu.waveformRam.version, outputLevel]) {
            let buffer = self.mmu.waveformRam.buffer
            return buffer.flatMap({ [Float($0.nibble(1) >> outputLevel) / 0b1111, Float($0.nibble(0) >> outputLevel) / 0b1111 ] }).map({ $0 * 2 - 1 })
        }
        
        self.customWave.triggered = triggered
        self.customWave.data = waveformData
        self.customWave.amplitude = 1
        self.customWave.frequency = bitsToFrequency(bits: frequencyInBits)
        self.customWave.lengthEnvelope.enabled = lengthEnvelopEnabled
        self.customWave.lengthEnvelope.duration = lengthEnvelopeDuration
        
        if self.customWave.lengthEnvelope.advance(seconds: seconds) == .deactivated {
            playing = false
        }
        
        return playing
    }
    
    func playNoise(seconds: Float) -> Bool {
        return false
    }
    
    public func run(for time: Int16) throws {
        let seconds = Float(time) / 4000000
        
        // Master sound registers
        let nr51 = self.mmu.nr51.read()
        var nr52 = self.mmu.nr52.read()
        
        // Master sound output
        let masterEnabledPrev = self.master.enabled
        let masterEnabledNext = nr52.bit(7)
        
        self.master.enabled = masterEnabledNext
        
        if !masterEnabledNext && masterEnabledPrev {
            // Clear all registers except
            self.mmu.nr10.write(0)
            self.mmu.nr11.write(0)
            self.mmu.nr12.write(0)
            self.mmu.nr13.write(0)
            self.mmu.nr14.write(0)
            self.mmu.nr21.write(0)
            self.mmu.nr22.write(0)
            self.mmu.nr23.write(0)
            self.mmu.nr24.write(0)
            self.mmu.nr30.write(0)
            self.mmu.nr31.write(0)
            self.mmu.nr32.write(0)
            self.mmu.nr33.write(0)
            self.mmu.nr34.write(0)
            self.mmu.nr41.write(0)
            self.mmu.nr42.write(0)
            self.mmu.nr43.write(0)
            self.mmu.nr44.write(0)
            self.mmu.nr50.write(0)
            self.mmu.nr51.write(0)
            self.mmu.nr52.write(0)
        } else if !masterEnabledNext  {
            // Exit early
            return
        }
        
        // Voice specific controls
        nr52[0] = playPulseA(seconds: seconds)
        nr52[1] = playPulseB(seconds: seconds)
        nr52[2] = playWaveform(seconds: seconds)
        //nr52[3] = playNoise(seconds: seconds)
        
        // Left or right channel output for each voice
        self.pulseA.setChannels(left: nr51.bit(4), right: nr51.bit(0))
        self.pulseB.setChannels(left: nr51.bit(5), right: nr51.bit(1))
        
        // Lines below are just for debugging
        self.pulseA.amplitude = 1
        self.pulseB.amplitude = 1
        self.customWave.amplitude = 1
        
        // Update all voices
        self.pulseA.update()
        self.pulseB.update()
        self.customWave.update()
        
        // Write nr52 back into RAM
        self.mmu.nr52.write(nr52)
    }
}

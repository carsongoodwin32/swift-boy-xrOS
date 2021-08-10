let instructions: [OpCode: Instruction] = [
    OpCode.byte(0x00): Instruction.atomic(cycles: 1) { cpu in
        // Only advances the program counter by 1. Performs no other operations that would have an effect.
    },
    OpCode.byte(0x01): Instruction.atomic(cycles: 3) { cpu in
        // Load the 2 bytes of immediate data into register pair BC.
        cpu.bc = try cpu.readNextWord()
    },
    OpCode.byte(0x02): Instruction.atomic(cycles: 3) { cpu in
        // Store the contents of register A in the memory location specified by register pair BC.
        try cpu.mmu.writeByte(address: cpu.bc, byte: cpu.a)
    },
    OpCode.byte(0x03): Instruction.atomic(cycles: 2) { cpu in
        // Increment the contents of register pair BC by 1.
        cpu.bc+=1
    },
    OpCode.byte(0x04): Instruction.atomic(cycles: 1) { cpu in
        // Increment the contents of register B by 1.
        let result = add(cpu.b, 1)
        cpu.b = result.value
        cpu.flags.zero = result.zero
        cpu.flags.subtract = result.subtract
        cpu.flags.halfCarry = result.halfCarry
    },
    OpCode.byte(0x05): Instruction.atomic(cycles: 1) { cpu in
        // Decrement the contents of register B by 1
        let result = sub(cpu.b, 1)
        cpu.b = result.value
        cpu.flags.zero = result.zero
        cpu.flags.subtract = result.subtract
        cpu.flags.halfCarry = result.halfCarry
    },
    OpCode.byte(0x06): Instruction.atomic(cycles: 2) { cpu in
        // Load the 8-bit immediate operand d8 into register B.
        cpu.b = try cpu.readNextByte()
    },
    OpCode.byte(0x07): Instruction.atomic(cycles: 1) { cpu in
        // Rotate the contents of register A to the left. That is, the contents of bit 0 are copied
        // to bit 1, and the previous contents of bit 1 (before the copy operation) are copied to bit 2.
        // The same operation is repeated in sequence for the rest of the register. The contents of bit 7
        // are placed in both the CY flag and bit 0 of register A.
        let carry = cpu.a.bit(7)
        cpu.a = (cpu.a << 1) + (carry ? 1 : 0)
        cpu.flags.carry = carry
    },
    OpCode.byte(0x08): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x08))
    },
    OpCode.byte(0x09): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x09))
    },
    OpCode.byte(0x0A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x0A))
    },
    OpCode.byte(0x0B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x0B))
    },
    OpCode.byte(0x0C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x0C))
    },
    OpCode.byte(0x0D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x0D))
    },
    OpCode.byte(0x0E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x0E))
    },
    OpCode.byte(0x0F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x0F))
    },
    OpCode.byte(0x10): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x10))
    },
    OpCode.byte(0x11): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x11))
    },
    OpCode.byte(0x12): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x12))
    },
    OpCode.byte(0x13): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x13))
    },
    OpCode.byte(0x14): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x14))
    },
    OpCode.byte(0x15): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x15))
    },
    OpCode.byte(0x16): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x16))
    },
    OpCode.byte(0x17): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x17))
    },
    OpCode.byte(0x18): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x18))
    },
    OpCode.byte(0x19): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x19))
    },
    OpCode.byte(0x1A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x1A))
    },
    OpCode.byte(0x1B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x1B))
    },
    OpCode.byte(0x1C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x1C))
    },
    OpCode.byte(0x1D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x1D))
    },
    OpCode.byte(0x1E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x1E))
    },
    OpCode.byte(0x1F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x1F))
    },
    OpCode.byte(0x20): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x20))
    },
    OpCode.byte(0x21): Instruction.atomic(cycles: 3) { cpu in
        // Load the 2 bytes of immediate data into register pair HL.
        cpu.hl = try cpu.readNextWord()
    },
    OpCode.byte(0x22): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x22))
    },
    OpCode.byte(0x23): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x23))
    },
    OpCode.byte(0x24): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x24))
    },
    OpCode.byte(0x25): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x25))
    },
    OpCode.byte(0x26): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x26))
    },
    OpCode.byte(0x27): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x27))
    },
    OpCode.byte(0x28): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x28))
    },
    OpCode.byte(0x29): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x29))
    },
    OpCode.byte(0x2A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x2A))
    },
    OpCode.byte(0x2B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x2B))
    },
    OpCode.byte(0x2C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x2C))
    },
    OpCode.byte(0x2D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x2D))
    },
    OpCode.byte(0x2E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x2E))
    },
    OpCode.byte(0x2F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x2F))
    },
    OpCode.byte(0x30): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x30))
    },
    OpCode.byte(0x31): Instruction.atomic(cycles: 3) { cpu in
        // Load the 2 bytes of immediate data into register pair SP.
        cpu.sp = try cpu.readNextWord()
    },
    OpCode.byte(0x32): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x32))
    },
    OpCode.byte(0x33): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x33))
    },
    OpCode.byte(0x34): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x34))
    },
    OpCode.byte(0x35): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x35))
    },
    OpCode.byte(0x36): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x36))
    },
    OpCode.byte(0x37): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x37))
    },
    OpCode.byte(0x38): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x38))
    },
    OpCode.byte(0x39): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x39))
    },
    OpCode.byte(0x3A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x3A))
    },
    OpCode.byte(0x3B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x3B))
    },
    OpCode.byte(0x3C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x3C))
    },
    OpCode.byte(0x3D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x3D))
    },
    OpCode.byte(0x3E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x3E))
    },
    OpCode.byte(0x3F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x3F))
    },
    OpCode.byte(0x40): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x40))
    },
    OpCode.byte(0x41): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x41))
    },
    OpCode.byte(0x42): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x42))
    },
    OpCode.byte(0x43): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x43))
    },
    OpCode.byte(0x44): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x44))
    },
    OpCode.byte(0x45): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x45))
    },
    OpCode.byte(0x46): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x46))
    },
    OpCode.byte(0x47): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x47))
    },
    OpCode.byte(0x48): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x48))
    },
    OpCode.byte(0x49): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x49))
    },
    OpCode.byte(0x4A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x4A))
    },
    OpCode.byte(0x4B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x4B))
    },
    OpCode.byte(0x4C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x4C))
    },
    OpCode.byte(0x4D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x4D))
    },
    OpCode.byte(0x4E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x4E))
    },
    OpCode.byte(0x4F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x4F))
    },
    OpCode.byte(0x50): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x50))
    },
    OpCode.byte(0x51): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x51))
    },
    OpCode.byte(0x52): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x52))
    },
    OpCode.byte(0x53): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x53))
    },
    OpCode.byte(0x54): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x54))
    },
    OpCode.byte(0x55): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x55))
    },
    OpCode.byte(0x56): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x56))
    },
    OpCode.byte(0x57): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x57))
    },
    OpCode.byte(0x58): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x58))
    },
    OpCode.byte(0x59): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x59))
    },
    OpCode.byte(0x5A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x5A))
    },
    OpCode.byte(0x5B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x5B))
    },
    OpCode.byte(0x5C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x5C))
    },
    OpCode.byte(0x5D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x5D))
    },
    OpCode.byte(0x5E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x5E))
    },
    OpCode.byte(0x5F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x5F))
    },
    OpCode.byte(0x60): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x60))
    },
    OpCode.byte(0x61): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x61))
    },
    OpCode.byte(0x62): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x62))
    },
    OpCode.byte(0x63): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x63))
    },
    OpCode.byte(0x64): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x64))
    },
    OpCode.byte(0x65): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x65))
    },
    OpCode.byte(0x66): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x66))
    },
    OpCode.byte(0x67): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x67))
    },
    OpCode.byte(0x68): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x68))
    },
    OpCode.byte(0x69): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x69))
    },
    OpCode.byte(0x6A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x6A))
    },
    OpCode.byte(0x6B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x6B))
    },
    OpCode.byte(0x6C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x6C))
    },
    OpCode.byte(0x6D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x6D))
    },
    OpCode.byte(0x6E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x6E))
    },
    OpCode.byte(0x6F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x6F))
    },
    OpCode.byte(0x70): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x70))
    },
    OpCode.byte(0x71): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x71))
    },
    OpCode.byte(0x72): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x72))
    },
    OpCode.byte(0x73): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x73))
    },
    OpCode.byte(0x74): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x74))
    },
    OpCode.byte(0x75): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x75))
    },
    OpCode.byte(0x76): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x76))
    },
    OpCode.byte(0x77): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x77))
    },
    OpCode.byte(0x78): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x78))
    },
    OpCode.byte(0x79): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x79))
    },
    OpCode.byte(0x7A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x7A))
    },
    OpCode.byte(0x7B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x7B))
    },
    OpCode.byte(0x7C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x7C))
    },
    OpCode.byte(0x7D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x7D))
    },
    OpCode.byte(0x7E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x7E))
    },
    OpCode.byte(0x7F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x7F))
    },
    OpCode.byte(0x80): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x80))
    },
    OpCode.byte(0x81): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x81))
    },
    OpCode.byte(0x82): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x82))
    },
    OpCode.byte(0x83): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x83))
    },
    OpCode.byte(0x84): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x84))
    },
    OpCode.byte(0x85): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x85))
    },
    OpCode.byte(0x86): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x86))
    },
    OpCode.byte(0x87): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x87))
    },
    OpCode.byte(0x88): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x88))
    },
    OpCode.byte(0x89): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x89))
    },
    OpCode.byte(0x8A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x8A))
    },
    OpCode.byte(0x8B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x8B))
    },
    OpCode.byte(0x8C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x8C))
    },
    OpCode.byte(0x8D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x8D))
    },
    OpCode.byte(0x8E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x8E))
    },
    OpCode.byte(0x8F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x8F))
    },
    OpCode.byte(0x90): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x90))
    },
    OpCode.byte(0x91): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x91))
    },
    OpCode.byte(0x92): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x92))
    },
    OpCode.byte(0x93): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x93))
    },
    OpCode.byte(0x94): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x94))
    },
    OpCode.byte(0x95): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x95))
    },
    OpCode.byte(0x96): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x96))
    },
    OpCode.byte(0x97): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x97))
    },
    OpCode.byte(0x98): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x98))
    },
    OpCode.byte(0x99): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x99))
    },
    OpCode.byte(0x9A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x9A))
    },
    OpCode.byte(0x9B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x9B))
    },
    OpCode.byte(0x9C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x9C))
    },
    OpCode.byte(0x9D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x9D))
    },
    OpCode.byte(0x9E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x9E))
    },
    OpCode.byte(0x9F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0x9F))
    },
    OpCode.byte(0xA0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA0))
    },
    OpCode.byte(0xA1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA1))
    },
    OpCode.byte(0xA2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA2))
    },
    OpCode.byte(0xA3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA3))
    },
    OpCode.byte(0xA4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA4))
    },
    OpCode.byte(0xA5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA5))
    },
    OpCode.byte(0xA6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA6))
    },
    OpCode.byte(0xA7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA7))
    },
    OpCode.byte(0xA8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA8))
    },
    OpCode.byte(0xA9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xA9))
    },
    OpCode.byte(0xAA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xAA))
    },
    OpCode.byte(0xAB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xAB))
    },
    OpCode.byte(0xAC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xAC))
    },
    OpCode.byte(0xAD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xAD))
    },
    OpCode.byte(0xAE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xAE))
    },
    OpCode.byte(0xAF): Instruction.atomic(cycles: 1) { cpu in
        // Take the logical exclusive-OR for each bit of the contents of register A and the contents
        // of register A, and store the results in register A.
        cpu.a^=cpu.a
        cpu.flags.zero = cpu.a == 0
    },
    OpCode.byte(0xB0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB0))
    },
    OpCode.byte(0xB1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB1))
    },
    OpCode.byte(0xB2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB2))
    },
    OpCode.byte(0xB3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB3))
    },
    OpCode.byte(0xB4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB4))
    },
    OpCode.byte(0xB5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB5))
    },
    OpCode.byte(0xB6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB6))
    },
    OpCode.byte(0xB7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB7))
    },
    OpCode.byte(0xB8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB8))
    },
    OpCode.byte(0xB9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xB9))
    },
    OpCode.byte(0xBA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xBA))
    },
    OpCode.byte(0xBB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xBB))
    },
    OpCode.byte(0xBC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xBC))
    },
    OpCode.byte(0xBD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xBD))
    },
    OpCode.byte(0xBE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xBE))
    },
    OpCode.byte(0xBF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xBF))
    },
    OpCode.byte(0xC0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC0))
    },
    OpCode.byte(0xC1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC1))
    },
    OpCode.byte(0xC2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC2))
    },
    OpCode.byte(0xC3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC3))
    },
    OpCode.byte(0xC4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC4))
    },
    OpCode.byte(0xC5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC5))
    },
    OpCode.byte(0xC6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC6))
    },
    OpCode.byte(0xC7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC7))
    },
    OpCode.byte(0xC8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC8))
    },
    OpCode.byte(0xC9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xC9))
    },
    OpCode.byte(0xCA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xCA))
    },
    OpCode.byte(0xCB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xCB))
    },
    OpCode.byte(0xCC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xCC))
    },
    OpCode.byte(0xCD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xCD))
    },
    OpCode.byte(0xCE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xCE))
    },
    OpCode.byte(0xCF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xCF))
    },
    OpCode.byte(0xD0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD0))
    },
    OpCode.byte(0xD1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD1))
    },
    OpCode.byte(0xD2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD2))
    },
    OpCode.byte(0xD3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD3))
    },
    OpCode.byte(0xD4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD4))
    },
    OpCode.byte(0xD5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD5))
    },
    OpCode.byte(0xD6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD6))
    },
    OpCode.byte(0xD7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD7))
    },
    OpCode.byte(0xD8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD8))
    },
    OpCode.byte(0xD9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xD9))
    },
    OpCode.byte(0xDA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xDA))
    },
    OpCode.byte(0xDB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xDB))
    },
    OpCode.byte(0xDC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xDC))
    },
    OpCode.byte(0xDD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xDD))
    },
    OpCode.byte(0xDE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xDE))
    },
    OpCode.byte(0xDF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xDF))
    },
    OpCode.byte(0xE0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE0))
    },
    OpCode.byte(0xE1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE1))
    },
    OpCode.byte(0xE2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE2))
    },
    OpCode.byte(0xE3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE3))
    },
    OpCode.byte(0xE4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE4))
    },
    OpCode.byte(0xE5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE5))
    },
    OpCode.byte(0xE6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE6))
    },
    OpCode.byte(0xE7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE7))
    },
    OpCode.byte(0xE8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE8))
    },
    OpCode.byte(0xE9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xE9))
    },
    OpCode.byte(0xEA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xEA))
    },
    OpCode.byte(0xEB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xEB))
    },
    OpCode.byte(0xEC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xEC))
    },
    OpCode.byte(0xED): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xED))
    },
    OpCode.byte(0xEE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xEE))
    },
    OpCode.byte(0xEF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xEF))
    },
    OpCode.byte(0xF0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF0))
    },
    OpCode.byte(0xF1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF1))
    },
    OpCode.byte(0xF2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF2))
    },
    OpCode.byte(0xF3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF3))
    },
    OpCode.byte(0xF4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF4))
    },
    OpCode.byte(0xF5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF5))
    },
    OpCode.byte(0xF6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF6))
    },
    OpCode.byte(0xF7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF7))
    },
    OpCode.byte(0xF8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF8))
    },
    OpCode.byte(0xF9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xF9))
    },
    OpCode.byte(0xFA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xFA))
    },
    OpCode.byte(0xFB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xFB))
    },
    OpCode.byte(0xFC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xFC))
    },
    OpCode.byte(0xFD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xFD))
    },
    OpCode.byte(0xFE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xFE))
    },
    OpCode.byte(0xFF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.byte(0xFF))
    },
    OpCode.word(0x00): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x00))
    },
    OpCode.word(0x01): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x01))
    },
    OpCode.word(0x02): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x02))
    },
    OpCode.word(0x03): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x03))
    },
    OpCode.word(0x04): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x04))
    },
    OpCode.word(0x05): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x05))
    },
    OpCode.word(0x06): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x06))
    },
    OpCode.word(0x07): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x07))
    },
    OpCode.word(0x08): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x08))
    },
    OpCode.word(0x09): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x09))
    },
    OpCode.word(0x0A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x0A))
    },
    OpCode.word(0x0B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x0B))
    },
    OpCode.word(0x0C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x0C))
    },
    OpCode.word(0x0D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x0D))
    },
    OpCode.word(0x0E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x0E))
    },
    OpCode.word(0x0F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x0F))
    },
    OpCode.word(0x10): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x10))
    },
    OpCode.word(0x11): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x11))
    },
    OpCode.word(0x12): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x12))
    },
    OpCode.word(0x13): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x13))
    },
    OpCode.word(0x14): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x14))
    },
    OpCode.word(0x15): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x15))
    },
    OpCode.word(0x16): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x16))
    },
    OpCode.word(0x17): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x17))
    },
    OpCode.word(0x18): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x18))
    },
    OpCode.word(0x19): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x19))
    },
    OpCode.word(0x1A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x1A))
    },
    OpCode.word(0x1B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x1B))
    },
    OpCode.word(0x1C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x1C))
    },
    OpCode.word(0x1D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x1D))
    },
    OpCode.word(0x1E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x1E))
    },
    OpCode.word(0x1F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x1F))
    },
    OpCode.word(0x20): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x20))
    },
    OpCode.word(0x21): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x21))
    },
    OpCode.word(0x22): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x22))
    },
    OpCode.word(0x23): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x23))
    },
    OpCode.word(0x24): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x24))
    },
    OpCode.word(0x25): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x25))
    },
    OpCode.word(0x26): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x26))
    },
    OpCode.word(0x27): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x27))
    },
    OpCode.word(0x28): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x28))
    },
    OpCode.word(0x29): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x29))
    },
    OpCode.word(0x2A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x2A))
    },
    OpCode.word(0x2B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x2B))
    },
    OpCode.word(0x2C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x2C))
    },
    OpCode.word(0x2D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x2D))
    },
    OpCode.word(0x2E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x2E))
    },
    OpCode.word(0x2F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x2F))
    },
    OpCode.word(0x30): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x30))
    },
    OpCode.word(0x31): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x31))
    },
    OpCode.word(0x32): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x32))
    },
    OpCode.word(0x33): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x33))
    },
    OpCode.word(0x34): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x34))
    },
    OpCode.word(0x35): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x35))
    },
    OpCode.word(0x36): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x36))
    },
    OpCode.word(0x37): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x37))
    },
    OpCode.word(0x38): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x38))
    },
    OpCode.word(0x39): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x39))
    },
    OpCode.word(0x3A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x3A))
    },
    OpCode.word(0x3B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x3B))
    },
    OpCode.word(0x3C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x3C))
    },
    OpCode.word(0x3D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x3D))
    },
    OpCode.word(0x3E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x3E))
    },
    OpCode.word(0x3F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x3F))
    },
    OpCode.word(0x40): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x40))
    },
    OpCode.word(0x41): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x41))
    },
    OpCode.word(0x42): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x42))
    },
    OpCode.word(0x43): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x43))
    },
    OpCode.word(0x44): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x44))
    },
    OpCode.word(0x45): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x45))
    },
    OpCode.word(0x46): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x46))
    },
    OpCode.word(0x47): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x47))
    },
    OpCode.word(0x48): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x48))
    },
    OpCode.word(0x49): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x49))
    },
    OpCode.word(0x4A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x4A))
    },
    OpCode.word(0x4B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x4B))
    },
    OpCode.word(0x4C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x4C))
    },
    OpCode.word(0x4D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x4D))
    },
    OpCode.word(0x4E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x4E))
    },
    OpCode.word(0x4F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x4F))
    },
    OpCode.word(0x50): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x50))
    },
    OpCode.word(0x51): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x51))
    },
    OpCode.word(0x52): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x52))
    },
    OpCode.word(0x53): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x53))
    },
    OpCode.word(0x54): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x54))
    },
    OpCode.word(0x55): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x55))
    },
    OpCode.word(0x56): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x56))
    },
    OpCode.word(0x57): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x57))
    },
    OpCode.word(0x58): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x58))
    },
    OpCode.word(0x59): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x59))
    },
    OpCode.word(0x5A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x5A))
    },
    OpCode.word(0x5B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x5B))
    },
    OpCode.word(0x5C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x5C))
    },
    OpCode.word(0x5D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x5D))
    },
    OpCode.word(0x5E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x5E))
    },
    OpCode.word(0x5F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x5F))
    },
    OpCode.word(0x60): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x60))
    },
    OpCode.word(0x61): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x61))
    },
    OpCode.word(0x62): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x62))
    },
    OpCode.word(0x63): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x63))
    },
    OpCode.word(0x64): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x64))
    },
    OpCode.word(0x65): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x65))
    },
    OpCode.word(0x66): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x66))
    },
    OpCode.word(0x67): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x67))
    },
    OpCode.word(0x68): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x68))
    },
    OpCode.word(0x69): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x69))
    },
    OpCode.word(0x6A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x6A))
    },
    OpCode.word(0x6B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x6B))
    },
    OpCode.word(0x6C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x6C))
    },
    OpCode.word(0x6D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x6D))
    },
    OpCode.word(0x6E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x6E))
    },
    OpCode.word(0x6F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x6F))
    },
    OpCode.word(0x70): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x70))
    },
    OpCode.word(0x71): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x71))
    },
    OpCode.word(0x72): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x72))
    },
    OpCode.word(0x73): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x73))
    },
    OpCode.word(0x74): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x74))
    },
    OpCode.word(0x75): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x75))
    },
    OpCode.word(0x76): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x76))
    },
    OpCode.word(0x77): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x77))
    },
    OpCode.word(0x78): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x78))
    },
    OpCode.word(0x79): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x79))
    },
    OpCode.word(0x7A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x7A))
    },
    OpCode.word(0x7B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x7B))
    },
    OpCode.word(0x7C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x7C))
    },
    OpCode.word(0x7D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x7D))
    },
    OpCode.word(0x7E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x7E))
    },
    OpCode.word(0x7F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x7F))
    },
    OpCode.word(0x80): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x80))
    },
    OpCode.word(0x81): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x81))
    },
    OpCode.word(0x82): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x82))
    },
    OpCode.word(0x83): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x83))
    },
    OpCode.word(0x84): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x84))
    },
    OpCode.word(0x85): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x85))
    },
    OpCode.word(0x86): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x86))
    },
    OpCode.word(0x87): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x87))
    },
    OpCode.word(0x88): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x88))
    },
    OpCode.word(0x89): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x89))
    },
    OpCode.word(0x8A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x8A))
    },
    OpCode.word(0x8B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x8B))
    },
    OpCode.word(0x8C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x8C))
    },
    OpCode.word(0x8D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x8D))
    },
    OpCode.word(0x8E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x8E))
    },
    OpCode.word(0x8F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x8F))
    },
    OpCode.word(0x90): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x90))
    },
    OpCode.word(0x91): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x91))
    },
    OpCode.word(0x92): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x92))
    },
    OpCode.word(0x93): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x93))
    },
    OpCode.word(0x94): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x94))
    },
    OpCode.word(0x95): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x95))
    },
    OpCode.word(0x96): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x96))
    },
    OpCode.word(0x97): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x97))
    },
    OpCode.word(0x98): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x98))
    },
    OpCode.word(0x99): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x99))
    },
    OpCode.word(0x9A): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x9A))
    },
    OpCode.word(0x9B): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x9B))
    },
    OpCode.word(0x9C): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x9C))
    },
    OpCode.word(0x9D): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x9D))
    },
    OpCode.word(0x9E): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x9E))
    },
    OpCode.word(0x9F): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0x9F))
    },
    OpCode.word(0xA0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA0))
    },
    OpCode.word(0xA1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA1))
    },
    OpCode.word(0xA2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA2))
    },
    OpCode.word(0xA3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA3))
    },
    OpCode.word(0xA4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA4))
    },
    OpCode.word(0xA5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA5))
    },
    OpCode.word(0xA6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA6))
    },
    OpCode.word(0xA7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA7))
    },
    OpCode.word(0xA8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA8))
    },
    OpCode.word(0xA9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xA9))
    },
    OpCode.word(0xAA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xAA))
    },
    OpCode.word(0xAB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xAB))
    },
    OpCode.word(0xAC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xAC))
    },
    OpCode.word(0xAD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xAD))
    },
    OpCode.word(0xAE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xAE))
    },
    OpCode.word(0xAF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xAF))
    },
    OpCode.word(0xB0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB0))
    },
    OpCode.word(0xB1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB1))
    },
    OpCode.word(0xB2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB2))
    },
    OpCode.word(0xB3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB3))
    },
    OpCode.word(0xB4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB4))
    },
    OpCode.word(0xB5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB5))
    },
    OpCode.word(0xB6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB6))
    },
    OpCode.word(0xB7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB7))
    },
    OpCode.word(0xB8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB8))
    },
    OpCode.word(0xB9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xB9))
    },
    OpCode.word(0xBA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xBA))
    },
    OpCode.word(0xBB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xBB))
    },
    OpCode.word(0xBC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xBC))
    },
    OpCode.word(0xBD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xBD))
    },
    OpCode.word(0xBE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xBE))
    },
    OpCode.word(0xBF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xBF))
    },
    OpCode.word(0xC0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC0))
    },
    OpCode.word(0xC1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC1))
    },
    OpCode.word(0xC2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC2))
    },
    OpCode.word(0xC3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC3))
    },
    OpCode.word(0xC4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC4))
    },
    OpCode.word(0xC5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC5))
    },
    OpCode.word(0xC6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC6))
    },
    OpCode.word(0xC7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC7))
    },
    OpCode.word(0xC8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC8))
    },
    OpCode.word(0xC9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xC9))
    },
    OpCode.word(0xCA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xCA))
    },
    OpCode.word(0xCB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xCB))
    },
    OpCode.word(0xCC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xCC))
    },
    OpCode.word(0xCD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xCD))
    },
    OpCode.word(0xCE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xCE))
    },
    OpCode.word(0xCF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xCF))
    },
    OpCode.word(0xD0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD0))
    },
    OpCode.word(0xD1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD1))
    },
    OpCode.word(0xD2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD2))
    },
    OpCode.word(0xD3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD3))
    },
    OpCode.word(0xD4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD4))
    },
    OpCode.word(0xD5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD5))
    },
    OpCode.word(0xD6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD6))
    },
    OpCode.word(0xD7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD7))
    },
    OpCode.word(0xD8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD8))
    },
    OpCode.word(0xD9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xD9))
    },
    OpCode.word(0xDA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xDA))
    },
    OpCode.word(0xDB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xDB))
    },
    OpCode.word(0xDC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xDC))
    },
    OpCode.word(0xDD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xDD))
    },
    OpCode.word(0xDE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xDE))
    },
    OpCode.word(0xDF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xDF))
    },
    OpCode.word(0xE0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE0))
    },
    OpCode.word(0xE1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE1))
    },
    OpCode.word(0xE2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE2))
    },
    OpCode.word(0xE3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE3))
    },
    OpCode.word(0xE4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE4))
    },
    OpCode.word(0xE5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE5))
    },
    OpCode.word(0xE6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE6))
    },
    OpCode.word(0xE7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE7))
    },
    OpCode.word(0xE8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE8))
    },
    OpCode.word(0xE9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xE9))
    },
    OpCode.word(0xEA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xEA))
    },
    OpCode.word(0xEB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xEB))
    },
    OpCode.word(0xEC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xEC))
    },
    OpCode.word(0xED): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xED))
    },
    OpCode.word(0xEE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xEE))
    },
    OpCode.word(0xEF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xEF))
    },
    OpCode.word(0xF0): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF0))
    },
    OpCode.word(0xF1): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF1))
    },
    OpCode.word(0xF2): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF2))
    },
    OpCode.word(0xF3): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF3))
    },
    OpCode.word(0xF4): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF4))
    },
    OpCode.word(0xF5): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF5))
    },
    OpCode.word(0xF6): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF6))
    },
    OpCode.word(0xF7): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF7))
    },
    OpCode.word(0xF8): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF8))
    },
    OpCode.word(0xF9): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xF9))
    },
    OpCode.word(0xFA): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xFA))
    },
    OpCode.word(0xFB): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xFB))
    },
    OpCode.word(0xFC): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xFC))
    },
    OpCode.word(0xFD): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xFD))
    },
    OpCode.word(0xFE): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xFE))
    },
    OpCode.word(0xFF): Instruction.atomic(cycles: 2) { cpu in
        // Add comment here
        throw CPUError.instructionNotImplemented(OpCode.word(0xFF))
    }
]






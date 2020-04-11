/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20180427 (64-bit version)(RM)
 * Copyright (c) 2000 - 2018 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of ssdt9.dat, Sat Apr 11 15:34:57 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000183 (387)
 *     Revision         0x01
 *     Checksum         0x28
 *     OEM ID           "Intel"
 *     OEM Table ID     "IntelRMT"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160422 (538313762)
 */
DefinitionBlock ("", "SSDT", 1, "Intel", "IntelRMT", 0x00001000)
{
    External (ADBG, MethodObj)    // 1 Arguments (from opcode)
    External (IRMC, IntObj)    // (from opcode)
    External (P8XH, MethodObj)    // 2 Arguments (from opcode)

    Scope (\_SB)
    {
        Device (INSD)
        {
            Name (_HID, "INT3398")  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0C02"))  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (NBT1, Zero)
            Method (GNSC, 0, NotSerialized)
            {
                Store (IRMC, Local0)
                P8XH (Zero, 0xAA)
                ADBG ("GNSC: ")
                ADBG (ToHexString (Local0))
                Return (IRMC)
            }

            Method (GNSM, 0, Serialized)
            {
                Store (NBT1, Local0)
                P8XH (Zero, 0x71)
                ADBG ("GNSM: ")
                ADBG (ToHexString (Local0))
                Return (Local0)
            }

            Method (SNSM, 1, Serialized)
            {
                Store (Arg0, NBT1)
                Store (NBT1, Local0)
                Switch (ToInteger (Local0))
                {
                    Case (Zero)
                    {
                        ADBG ("case 0: ")
                    }
                    Case (One)
                    {
                        ADBG ("case 1: ")
                    }
                    Case (0x02)
                    {
                        ADBG ("case 2: ")
                    }
                    Case (0x03)
                    {
                        ADBG ("case 3: ")
                    }
                    Case (0x04)
                    {
                        ADBG ("case 4: ")
                    }

                }

                P8XH (Zero, 0x72)
                ADBG ("SNSM: ")
                ADBG (ToHexString (Local0))
            }
        }
    }
}


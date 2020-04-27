// SSDT-EX.dsl
//
// X270 Multibyte EC Patches
//
DefinitionBlock ("", "SSDT", 2, "hack", "BATT", 0)
{
    External(ADBG, MethodObj)
    External(UCMS, MethodObj)
    External(NVSS, MethodObj)
    External(\PNTF, MethodObj)
    External(VBTD, MethodObj)
    External(VCMS, MethodObj)
    External(AWON, MethodObj)
    External(VBRC, MethodObj)
    External(VSLD, MethodObj)
    External(CSUM, MethodObj)
    External(WAKI, PkgObj)
    External(SPS, IntObj)
    External(FNID, IntObj)
    External(ACST, IntObj)
    External(WVIS, IntObj)
    External(NBCF, IntObj)
    External(RRBF, IntObj)
    External(LIDB, FieldUnitObj)
    External(PWRS, FieldUnitObj)
    External(OSC4, FieldUnitObj)
    External(SCRM, FieldUnitObj)
    External(IOEN, FieldUnitObj)
    External(IOST, FieldUnitObj)
    External(ISWK, FieldUnitObj)
    External(VIGD, FieldUnitObj)
    External(CMPR, FieldUnitObj)
    External(WLAC, FieldUnitObj)
    External(BRLV, FieldUnitObj)
    External(CHKC, FieldUnitObj)
    External(CHKE, FieldUnitObj)
    External(\_TZ.THM0, ThermalZoneObj)
    External(\_SB.SLPB, DeviceObj)
    External(\_SB.LID._LID, MethodObj)
    External(_SB.PCI0.LPCB.EC, DeviceObj)
    External(_SB.PCI0.LPCB.EC.BATM, MutexObj)
    External(_SB.PCI0.LPCB.EC.BSWR, IntObj)
    External(_SB.PCI0.LPCB.EC.BSWA, IntObj) 
    External(_SB.PCI0.LPCB.EC.B0I0, IntObj) 
    External(_SB.PCI0.LPCB.EC.B0I1, IntObj)
    External(_SB.PCI0.LPCB.EC.B0I2, IntObj) 
    External(_SB.PCI0.LPCB.EC.B0I3, IntObj)  
    External(_SB.PCI0.LPCB.EC.B1I0, IntObj) 
    External(_SB.PCI0.LPCB.EC.B1I1, IntObj)
    External(_SB.PCI0.LPCB.EC.B1I2, IntObj) 
    External(_SB.PCI0.LPCB.EC.B1I3, IntObj) 
    External(_SB.PCI0.LPCB.EC.HIID, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.HCMU, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.HFNI, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.HFSP, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.ELNK, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.DCWL, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.HSPA, FieldUnitObj)
    External(_SB.PCI0.LPCB.EC.EVNT, MethodObj)
    External(_SB.PCI0.LPCB.EC.FNST, MethodObj)
    External(_SB.PCI0.LPCB.EC.ATMC, MethodObj)
    External(_SB.PCI0.LPCB.EC.BRNS, MethodObj)
    External(_SB.PCI0.LPCB.EC.BATW, MethodObj)
  
    External(_SB.PCI0.LPCB.EC.AC._PSR, MethodObj)
    External(_SB.PCI0.LPCB.EC.HKEY.DHKC, IntObj)
    External(_SB.PCI0.LPCB.EC.HKEY.ANGN, IntObj)
    External(_SB.PCI0.LPCB.EC.HKEY.MHKE, MethodObj)
    External(_SB.PCI0.LPCB.EC.HKEY.MHKQ, MethodObj)
    External(_SB.PCI0.LPCB.EC.HKEY.WGWK, MethodObj)
    External(_SB.PCI0.LPCB.EC.HKEY.DYTC, MethodObj)
    External (_SB_.PCI0.GFX0.CLID, UnknownObj)
    
    Method (B1B2, 2, NotSerialized) { 
        Return(Or(Arg0, ShiftLeft(Arg1, 8))) 
    }
	    
	Method (B1B4, 4, NotSerialized)
	{
	    Store(Arg3, Local0)
	    Or(Arg2, ShiftLeft(Local0, 8), Local0)
	    Or(Arg1, ShiftLeft(Local0, 8), Local0)
	    Or(Arg0, ShiftLeft(Local0, 8), Local0)
	    Return(Local0)
	}
           
    Scope(_SB.PCI0.LPCB.EC)
    {
        OperationRegion (EMR2, EmbeddedControl, 0x00, 0x0100)
        Field (EMR2, ByteAcc, NoLock, Preserve)
        {
            Offset (0x36),             AC10,8,AC11,8, 
            Offset (0x4E),            AK00,8,AK01,8, 
        } 
        
        Field (EMR2, ByteAcc, NoLock, Preserve)
        {
            Offset (0xA0),             RC00,8,RC01,8,             FC00,8,FC01,8,             AE00,8,AE01,8,             RS00,8,RS01,8,             AC00,8,AC01,8,             BV00,8,BV01,8, 
        }
        
        Field (EMR2, ByteAcc, NoLock, Preserve)        {            Offset (0xA0),             SB00,8,SB01,8,             MD00,8,MD01,8,             CC00,8,CC01,8,        }
            
        Field (EMR2, ByteAcc, NoLock, Preserve)        {            Offset (0xA0),             DC00,8,DC01,8,             DV00,8,DV01,8,             OM00,8,OM01,8,             SI00,8,SI01,8,             DT00,8,DT01,8,             SN00,8,SN01,8,        }    
        Field (EMR2, ByteAcc, NoLock, Preserve)        {            Offset (0xA0),             CH00,8,CH01,8,CH02,8,CH03,8        }
        
        Method (RE1B, 1, NotSerialized)
	    {
	        OperationRegion(ECOR, EmbeddedControl, Arg0, 1)
	        Field(ECOR, ByteAcc, NoLock, Preserve) { BYTE, 8 }
	        Return(BYTE)
	    }

	    Method (RECB, 2, Serialized)
	    {
	        ShiftRight(Arg1, 3, Arg1)
	        Name(TEMP, Buffer(Arg1) { })
	        Add(Arg0, Arg1, Arg1)
	        Store(0, Local0)
	        While (LLess(Arg0, Arg1))
	        {
	            Store(RE1B(Arg0), Index(TEMP, Local0))
	            Increment(Arg0)
	            Increment(Local0)
	        }
	        Return(TEMP)
	    }
        
		Method (GBIF, 3, NotSerialized)
		{
		    Acquire (BATM, 0xFFFF)
		    If (Arg2)
		    {
		        Or (Arg0, 0x01, HIID)
		        Store (B1B2(SB00,SB01), Local7)
		        ShiftRight (Local7, 0x0F, Local7)
		        XOr (Local7, 0x01, Index (Arg1, 0x00))
		        Store (Arg0, HIID)
		        If (Local7)
		        {
		            Multiply (B1B2(FC00,FC01), 0x0A, Local1)
		        }
		        Else
		        {
		            Store (B1B2(FC00,FC01), Local1)
		        }

		        Store (Local1, Index (Arg1, 0x02))
		        Or (Arg0, 0x02, HIID)
		        If (Local7)
		        {
		            Multiply (B1B2(DC00,DC01), 0x0A, Local0)
		        }
		        Else
		        {
		            Store (B1B2(DC00,DC01), Local0)
		        }

		        Store (Local0, Index (Arg1, 0x01))
		        Divide (Local1, 0x14, Local2, Index (Arg1, 0x05))
		        If (Local7)
		        {
		            Store (0xC8, Index (Arg1, 0x06))
		        }
		        ElseIf (B1B2(DV00,DV01))
		        {
		            Divide (0x00030D40, B1B2(DV00,DV01), Local2, Index (Arg1, 0x06))
		        }
		        Else
		        {
		            Store (0x00, Index (Arg1, 0x06))
		        }

		        Store (B1B2(DV00,DV01), Index (Arg1, 0x04))
		        Store (B1B2(SN00,SN01), Local0)
		        Name (SERN, Buffer (0x06)
		        {
		            "     "
		        })
		        Store (0x04, Local2)
		        While (Local0)
		        {
		            Divide (Local0, 0x0A, Local1, Local0)
		            Add (Local1, 0x30, Index (SERN, Local2))
		            Decrement (Local2)
		        }

		        Store (SERN, Index (Arg1, 0x0A))
		        Or (Arg0, 0x06, HIID)
		        Store (RECB(0xA0,128), Index (Arg1, 0x09))
		        Or (Arg0, 0x04, HIID)
		        Name (BTYP, Buffer (0x05)
		        {
		             0x00, 0x00, 0x00, 0x00, 0x00                   
		        })
		        Store (B1B4(CH00,CH01,CH02,CH03), BTYP)
		        Store (BTYP, Index (Arg1, 0x0B))
		        Or (Arg0, 0x05, HIID)
		        Store (RECB(0xA0,128), Index (Arg1, 0x0C))
		    }
		    Else
		    {
		        Store (0xFFFFFFFF, Index (Arg1, 0x01))
		        Store (0x00, Index (Arg1, 0x05))
		        Store (0x00, Index (Arg1, 0x06))
		        Store (0xFFFFFFFF, Index (Arg1, 0x02))
		    }

		    Release (BATM)
		    Return (Arg1)
		}

        Method (GBIX, 3, NotSerialized)
        {
            Acquire (BATM, 0xFFFF)
            If (Arg2)
            {
                Or (Arg0, 0x01, HIID)
                Store (B1B2(CC00,CC01), Local7)
                Store (Local7, Index (Arg1, 0x08))
                Store (B1B2(SB00,SB01), Local7)
                ShiftRight (Local7, 0x0F, Local7)
                XOr (Local7, 0x01, Index (Arg1, 0x01))
                Store (Arg0, HIID)
                If (Local7)
                {
                    Multiply (B1B2(FC00,FC01), 0x0A, Local1)
                }
                Else
                {
                    Store (B1B2(FC00,FC01), Local1)
                }

                Store (Local1, Index (Arg1, 0x03))
                Or (Arg0, 0x02, HIID)
                If (Local7)
                {
                    Multiply (B1B2(DC00,DC01), 0x0A, Local0)
                }
                Else
                {
                    Store (B1B2(DC00,DC01), Local0)
                }

                Store (Local0, Index (Arg1, 0x02))
                Divide (Local1, 0x14, Local2, Index (Arg1, 0x06))
                If (Local7)
                {
                    Store (0xC8, Index (Arg1, 0x07))
                }
                ElseIf (B1B2(DV00,DV01))
                {
                    Divide (0x00030D40, B1B2(DV00,DV01), Local2, Index (Arg1, 0x07))
                }
                Else
                {
                    Store (0x00, Index (Arg1, 0x07))
                }

                Store (B1B2(DV00,DV01), Index (Arg1, 0x05))
                Store (B1B2(SN00,SN01), Local0)
                Name (SERN, Buffer (0x06)
                {
                    "     "
                })
                Store (0x04, Local2)
                While (Local0)
                {
                    Divide (Local0, 0x0A, Local1, Local0)
                    Add (Local1, 0x30, Index (SERN, Local2))
                    Decrement (Local2)
                }

                Store (SERN, Index (Arg1, 0x11))
                Or (Arg0, 0x06, HIID)
                Store (RECB(0xA0,128), Index (Arg1, 0x10))
                Or (Arg0, 0x04, HIID)
                Name (BTYP, Buffer (0x05)
                {
                     0x00, 0x00, 0x00, 0x00, 0x00                   
                })
                Store (B1B4(CH00,CH01,CH02,CH03), BTYP)
                Store (BTYP, Index (Arg1, 0x12))
                Or (Arg0, 0x05, HIID)
                Store (RECB(0xA0,128), Index (Arg1, 0x13))
            }
            Else
            {
                Store (0xFFFFFFFF, Index (Arg1, 0x02))
                Store (0x00, Index (Arg1, 0x06))
                Store (0x00, Index (Arg1, 0x07))
                Store (0xFFFFFFFF, Index (Arg1, 0x03))
            }

            Release (BATM)
            Return (Arg1)
        }
                        
		Method (GBST, 4, NotSerialized)
		{
		    Acquire (BATM, 0xFFFF)
		    If (And (Arg1, 0x20))
		    {
		        Store (0x02, Local0)
		    }
		    ElseIf (And (Arg1, 0x40))
		    {
		        Store (0x01, Local0)
		    }
		    Else
		    {
		        Store (0x00, Local0)
		    }

		    If (And (Arg1, 0x07)) {}
		    Else
		    {
		        Or (Local0, 0x04, Local0)
		    }

		    If (LEqual (And (Arg1, 0x07), 0x07))
		    {
		        Store (0x04, Local0)
		        Store (0x00, Local1)
		        Store (0x00, Local2)
		        Store (0x00, Local3)
		    }
		    Else
		    {
		        Store (Arg0, HIID)
		        Store (B1B2(BV00,BV01), Local3)
		        If (Arg2)
		        {
		            Multiply (B1B2(RC00,RC01), 0x0A, Local2)
		        }
		        Else
		        {
		            Store (B1B2(RC00,RC01), Local2)
		        }

		        Store (B1B2(AC00,AC01), Local1)
		        If (LGreaterEqual (Local1, 0x8000))
		        {
		            If (And (Local0, 0x01))
		            {
		                Subtract (0x00010000, Local1, Local1)
		            }
		            Else
		            {
		                Store (0x00, Local1)
		            }
		        }
		        ElseIf (LNot (And (Local0, 0x02)))
		        {
		            Store (0x00, Local1)
		        }

		        If (Arg2)
		        {
		            Multiply (Local3, Local1, Local1)
		            Divide (Local1, 0x03E8, Local7, Local1)
		        }
		    }

		    Store (ShiftLeft (0x01, ShiftRight (Arg0, 0x04)), Local5)
		    Or (BSWA, BSWR, BSWA)
		    If (LEqual (And (BSWA, Local5), 0x00))
		    {
		        Store (Local0, Index (Arg3, 0x00))
		        Store (Local1, Index (Arg3, 0x01))
		        Store (Local2, Index (Arg3, 0x02))
		        Store (Local3, Index (Arg3, 0x03))
		        If (LEqual (Arg0, 0x00))
		        {
		            Store (Local0, B0I0)
		            Store (Local1, B0I1)
		            Store (Local2, B0I2)
		            Store (Local3, B0I3)
		        }
		        Else
		        {
		            Store (Local0, B1I0)
		            Store (Local1, B1I1)
		            Store (Local2, B1I2)
		            Store (Local3, B1I3)
		        }
		    }
		    Else
		    {
		        If (\_SB.PCI0.LPCB.EC.AC._PSR ())
		        {
		            If (LEqual (Arg0, 0x00))
		            {
		                Store (B0I0, Index (Arg3, 0x00))
		                Store (B0I1, Index (Arg3, 0x01))
		                Store (B0I2, Index (Arg3, 0x02))
		                Store (B0I3, Index (Arg3, 0x03))
		            }
		            Else
		            {
		                Store (B1I0, Index (Arg3, 0x00))
		                Store (B1I1, Index (Arg3, 0x01))
		                Store (B1I2, Index (Arg3, 0x02))
		                Store (B1I3, Index (Arg3, 0x03))
		            }
		        }
		        Else
		        {
		            Store (Local0, Index (Arg3, 0x00))
		            Store (Local1, Index (Arg3, 0x01))
		            Store (Local2, Index (Arg3, 0x02))
		            Store (Local3, Index (Arg3, 0x03))
		        }

		        If (LAnd (LEqual (And (Local0, 0x04), 0x00), LAnd (LGreater (Local2, 0x00), LGreater (Local3, 0x00))))
		        {
		            And (BSWA, Not (Local5), BSWA)
		            Store (Local0, Index (Arg3, 0x00))
		            Store (Local1, Index (Arg3, 0x01))
		            Store (Local2, Index (Arg3, 0x02))
		            Store (Local3, Index (Arg3, 0x03))
		        }
		    }

		    Release (BATM)
		    Return (Arg3)
		}
    }
	
    	Method (OWAK, 1, NotSerialized)
    {
        ADBG ("OWAK")
        If (LOr (LEqual (Arg0, 0x00), LGreaterEqual (Arg0, 0x05)))
        {
            Return (WAKI)
        }

        Store (0x00, \SPS)
        Store (0x00, \_SB.PCI0.LPCB.EC.HCMU)
        \_SB.PCI0.LPCB.EC.EVNT (0x01)
        \_SB.PCI0.LPCB.EC.HKEY.MHKE (0x01)
        \_SB.PCI0.LPCB.EC.FNST ()
        \UCMS (0x0D)
        Store (0x00, \LIDB)
        If (LEqual (Arg0, 0x01))
        {
            Store (\_SB.PCI0.LPCB.EC.HFNI, \FNID)
        }

        If (LEqual (Arg0, 0x03))
        {
            \NVSS (0x00)
            Store (\_SB.PCI0.LPCB.EC.AC._PSR (), \PWRS)
            If (\OSC4)
            {
                \PNTF (0x81)
            }

            If (LNotEqual (\ACST, \_SB.PCI0.LPCB.EC.AC._PSR ()))
            {
                \_SB.PCI0.LPCB.EC.ATMC ()
            }

            If (\SCRM)
            {
                Store (0x07, \_SB.PCI0.LPCB.EC.HFSP)
            }

            Store (0x00, \IOEN)
            Store (0x00, \IOST)
            If (LEqual (\ISWK, 0x01))
            {
                If (\_SB.PCI0.LPCB.EC.HKEY.DHKC)
                {
                    \_SB.PCI0.LPCB.EC.HKEY.MHKQ (0x6070)
                }
            }

            If (\VIGD)
            {
                Store (\_SB.LID._LID (), \_SB.PCI0.GFX0.CLID)
                If (\WVIS)
                {
                    \VBTD ()
                }
            }
            ElseIf (\WVIS)
            {
                Store (\_SB.LID._LID (), \_SB.PCI0.GFX0.CLID)
                \VBTD ()
            }

            \VCMS (0x01, \_SB.LID._LID ())
            \AWON (0x00)
            If (\CMPR)
            {
                Notify (\_SB.SLPB, 0x02)
                Store (0x00, \CMPR)
            }

            If (LEqual (\WLAC, 0x02)) {}
            ElseIf (LAnd (\_SB.PCI0.LPCB.EC.ELNK, LEqual (\WLAC, 0x01)))
            {
                Store (0x00, \_SB.PCI0.LPCB.EC.DCWL)
            }
            Else
            {
                Store (0x01, \_SB.PCI0.LPCB.EC.DCWL)
            }
        }

        If (LEqual (Arg0, 0x04))
        {
            \NVSS (0x00)
            Store (0x00, \_SB.PCI0.LPCB.EC.HSPA)
            Store (\_SB.PCI0.LPCB.EC.AC._PSR (), \PWRS)
            If (\OSC4)
            {
                \PNTF (0x81)
            }

            \_SB.PCI0.LPCB.EC.ATMC ()
            If (\SCRM)
            {
                Store (0x07, \_SB.PCI0.LPCB.EC.HFSP)
            }

            If (LNot (\NBCF))
            {
                If (\VIGD)
                {
                    \_SB.PCI0.LPCB.EC.BRNS ()
                }
                Else
                {
                    \VBRC (\BRLV)
                }
            }

            Store (0x00, \IOEN)
            Store (0x00, \IOST)
            If (LEqual (\ISWK, 0x02))
            {
                If (\_SB.PCI0.LPCB.EC.HKEY.DHKC)
                {
                    \_SB.PCI0.LPCB.EC.HKEY.MHKQ (0x6080)
                }
            }

            If (LEqual (\WLAC, 0x02)) {}
            ElseIf (LAnd (\_SB.PCI0.LPCB.EC.ELNK, LEqual (\WLAC, 0x01)))
            {
                Store (0x00, \_SB.PCI0.LPCB.EC.DCWL)
            }
            Else
            {
                Store (0x01, \_SB.PCI0.LPCB.EC.DCWL)
            }
        }

        \_SB.PCI0.LPCB.EC.BATW (Arg0)
        \_SB.PCI0.LPCB.EC.HKEY.WGWK (Arg0)
        Notify (\_TZ.THM0, 0x80)
        \VSLD (\_SB.LID._LID ())
        If (\VIGD)
        {
            Store (\_SB.LID._LID (), \_SB.PCI0.GFX0.CLID)
        }
        ElseIf (\WVIS)
        {
            Store (\_SB.LID._LID (), \_SB.PCI0.GFX0.CLID)
        }

        If (LLess (Arg0, 0x04))
        {
            If (LOr (And (\RRBF, 0x02), And (B1B2(\_SB.PCI0.LPCB.EC.AC10,\_SB.PCI0.LPCB.EC.AC11), 0x02)))
            {
                ShiftLeft (Arg0, 0x08, Local0)
                Store (Or (0x2013, Local0), Local0)
                \_SB.PCI0.LPCB.EC.HKEY.MHKQ (Local0)
            }
        }

        If (LEqual (Arg0, 0x04))
        {
            Store (0x00, Local0)
            Store (\CSUM (0x00), Local1)
            If (LNotEqual (Local1, \CHKC))
            {
                Store (0x01, Local0)
                Store (Local1, \CHKC)
            }

            Store (\CSUM (0x01), Local1)
            If (LNotEqual (Local1, \CHKE))
            {
                Store (0x01, Local0)
                Store (Local1, \CHKE)
            }

            If (Local0)
            {
                Notify (\_SB, 0x00)
            }
        }

        If (LOr (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
        {
            ADBG ("_WAK0")
            Store (0x00, \_SB.PCI0.LPCB.EC.HKEY.ANGN)
            If (LOr (LEqual (\_SB.LID._LID (), 0x01), LEqual (\_SB.PCI0.LPCB.EC.AC._PSR (), 0x01)))
            {
                \_SB.PCI0.LPCB.EC.HKEY.DYTC (0x000F4001)
            }
            Else
            {
                \_SB.PCI0.LPCB.EC.HKEY.DYTC (0x000F0001)
            }

            \_SB.PCI0.LPCB.EC.HKEY.DYTC (0x000F0001)
            ADBG ("_WAK1")
        }

        Store (Zero, \RRBF)
        ADBG ("OWAK END")
        Return (WAKI)
    }
    
    Scope (\_GPE)
	{
	    Method (_L17, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
	    {
	        Store (B1B2(\_SB.PCI0.LPCB.EC.AC10,\_SB.PCI0.LPCB.EC.AC11), Local0)
	        Store (Local0, \RRBF)
	        Sleep (0x0A)
	        If (And (Local0, 0x02)) {}
	        If (And (Local0, 0x04))
	        {
	            Notify (\_SB.LID, 0x02)
	        }

	        If (And (Local0, 0x08))
	        {
	            Notify (\_SB.SLPB, 0x02)
	        }

	        If (And (Local0, 0x10))
	        {
	            Notify (\_SB.SLPB, 0x02)
	        }

	        If (And (Local0, 0x40)) {}
	        If (And (Local0, 0x80))
	        {
	            Notify (\_SB.SLPB, 0x02)
	        }
	    }
	}
}
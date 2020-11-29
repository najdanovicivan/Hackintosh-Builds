DefinitionBlock ("", "SSDT", 2, "ACDT", "RTCfix", 0)
{
    External(_SB.PCI0.LPCB.RTC, DeviceObj)
    Scope (_SB.PCI0.LPCB.RTC)
    {
        Method (_STA, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                Return (Zero)
            }
            Else
            {
                Return (0x0F)
            }
        }
    }
}
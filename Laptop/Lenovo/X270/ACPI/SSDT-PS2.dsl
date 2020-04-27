//
// Keyboad Mapping For X270
//
DefinitionBlock ("", "SSDT", 2, "X270", "PS2", 0)
{
    // Change _SB.PCI0.LPC.KBD if your PS2 keyboard is at a different ACPI path
    External(_SB.PCI0.LPCB.KBD, DeviceObj)
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    
    //Map FN Keys
    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q6A, 0, NotSerialized)  //F4 Microphone Mute
        {
            Notify (KBD, 0x033E)
        }

        Method (_Q15, 0, NotSerialized)  //F5 Brightness Down
        {
            Notify (KBD, 0x0405)
        }

        Method (_Q14, 0, NotSerialized)  //F6 Brightness Up
        {
            Notify (KBD, 0x0406)
        }

        Method (_Q16, 0, NotSerialized)  //F7 Projector
        {
            Notify (KBD, 0x046E)
        }

        Method (_Q64, 0, NotSerialized)  //F8 Wifi
        {
            Notify (KBD, 0x0342)
        }

        Method (_Q66, 0, NotSerialized)  //F9 Settings
        {
            Notify (KBD, 0x0367)
        }

        Method (_Q60, 0, NotSerialized)  //F10 Bluetooth
        {
            Notify (KBD, 0x0368)
        }

        Method (_Q61, 0, NotSerialized)  //F11 KBD 
        {
            Notify (KBD, 0x0369)
        }

        Method (_Q62, 0, NotSerialized)  //F2 Star
        {
            Notify (KBD, 0x036A)
        }
    }
    
    //Keyboard and Clickpad Config
    Scope(_SB.PCI0.LPCB.KBD)
    {
        // Select specific configuration in VoodooPS2Trackpad.kext
        Method(_DSM, 4)
        {
            If (!Arg2) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                "RM,oem-id", "LENOVO",
                "RM,oem-table-id", "Thinkpad_ClickPad",
            })
        }
        // Overrides (the example data here is default in the Info.plist)
        Name(RMCF, Package()
        {
            "Synaptics TouchPad", Package()
            {
                "BogusDeltaThreshX", 800,
                "BogusDeltaThreshY", 800,
                "Clicking", ">y",
                "DragLockTempMask", 0x40004,
                "DynamicEWMode", ">n",
                "FakeMiddleButton", ">n",
                "HWResetOnStart", ">y",
                //"ForcePassThrough", ">y",
                //"SkipPassThrough", ">y",
                "PalmNoAction When Typing", ">y",
                "ScrollResolution", 800,
                "SmoothInput", ">y",
                "UnsmoothInput", ">y",
                "Thinkpad", ">y",
                "EdgeBottom", 0,
                "FingerZ", 30,
                "MaxTapTime", 100000000,
                "MouseMultiplierX", 2,
                "MouseMultiplierY", 2,
                "MouseScrollMultiplierX", 2,
                "MouseScrollMultiplierY", 2,
                //"TrackpointScrollYMultiplier", 1, //Change this value to 0xFFFF in order to inverse the vertical scroll direction of the Trackpoint when holding the middle mouse button.
                //"TrackpointScrollXMultiplier", 1, //Change this value to 0xFFFF in order to inverse the horizontal scroll direction of the Trackpoint when holding the middle mouse button.
            },
            "Keyboard", Package ()
            {
                "Custom PS2 Map", 
                Package ()
                {
                    Package (){}, 
                    "e037=64" //PrtSc=F13
                }
            }
        })
    }
}
//EOF

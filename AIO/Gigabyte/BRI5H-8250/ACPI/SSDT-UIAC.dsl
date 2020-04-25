DefinitionBlock ("", "SSDT", 2, "ACDT", "_UIAC", 0)
{
    Device(UIAC)
    {
        Name(_HID, "UIA00000")

        Name(RMCF, Package()
        {
            // XHC (8086_9d2f)
            "XHC", Package()
            {
                "port-count", Buffer() { 0x10, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "HS03", Package() //Back Top
                      {
                          "name", Buffer() { "HS03" },
                          "UsbConnector", 3,
                          "port", Buffer() { 0x03, 0x00, 0x00, 0x00 },
                      },
                      "HS04", Package() //Back Bottom
                      {
                          "name", Buffer() { "HS04" },
                          "UsbConnector", 3,
                          "port", Buffer() { 0x04, 0x00, 0x00, 0x00 },
                      },
                      "HS07", Package() //Bluetooth
                      {
                          "name", Buffer() { "HS07" },
                          "UsbConnector", 255,
                          "port", Buffer() { 0x07, 0x00, 0x00, 0x00 },
                      },
                      "SS03", Package() //Back Top
                      {
                          "name", Buffer() { "SS03" },
                          "UsbConnector", 3,
                          "port", Buffer() { 0x0F, 0x00, 0x00, 0x00 },
                      },
                      "SS04", Package() //Back Bottom
                      {
                          "name", Buffer() { "SS04" },
                          "UsbConnector", 3,
                          "port", Buffer() { 0x10, 0x00, 0x00, 0x00 },
                      },
                },
            },
            // PXSX (1b21_2142)
            "PXSX", Package()
            {
                "port-count", Buffer() { 0x04, 0x00, 0x00, 0x00 },
                "ports", Package()
                {
                      "HS01", Package() //Front Top Type C 
                      {
                          "name", Buffer() { "HS01" },
                          "UsbConnector", 9,
                          "port", Buffer() { 0x01, 0x00, 0x00, 0x00 },
                      },
                      "HS02", Package() //Front Bottom 
                      {
                          "name", Buffer() { "HS02" },
                          "UsbConnector", 3,
                          "port", Buffer() { 0x02, 0x00, 0x00, 0x00 },
                      },
                      "SS01", Package() //Front Top Type C
                      {
                          "name", Buffer() { "SS01" },
                          "UsbConnector", 9,
                          "port", Buffer() { 0x03, 0x00, 0x00, 0x00 },
                      },
                      "SS02", Package() //Front Bottom
                      {
                          "name", Buffer() { "SS02" },
                          "UsbConnector", 3,
                          "port", Buffer() { 0x04, 0x00, 0x00, 0x00 },
                      },
                },
            },
        })
    }
}

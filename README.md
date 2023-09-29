# xrct
- versal ports for xrct.
- The original system targeted the KU060 device.
- The IO standard is changed to 1V5 LVCMOS and LVDS1V5 in the xdc file
- Built using Vivado 2022.1

# Structure
This one repo contains all eight permuations of the projects:
  - SEM Enabled
    - LVCMOS
      - registered
      - unregistered
    - LVDS
      - unregistered
  - SEM Disabled
    - LVCMOS
      - registered
      - unregistered
    - LVDS
      - unregistered

within each sub project the directory consists of <br>
PROJ
  - hdl
  - xdc
  - xsa

<i> The original KU060 sources are kept in the hdl/xdc directories for reference during troubleshooting <br>
Additionally - there are python scripts added in the hdl/xdc directories that more or less document the conversion strategy that was used </i>

# Build Instructions
1. Clone this repo to an area on the disk with a 10character path length or less.  (If you don't then PDI gen will fail due to compilation errors) <a href> https://support.xilinx.com/s/question/0D52E00006hpR4ASAU/pdi-generation-fails-in-vivado-20202-during-bootgen-for-versal-vck190?language=en_US </a>
2. Launch Vivado 2022.1
3. Use the TCL console to navigate to the project that will be built
4. source the make_prj.tcl script (This will generate the .xpr in the /ws folder)
   The project is built for GUI mode in Vivado.
6. Select the Generate Device Image option in the Flow Navigator "Program and Debug" section.

# Known issues
1.  <span style="background-color:#ddd;">All the KU060 timing constraints are commented out.  We should add constraints here to inform the router that the IO signals are synchronous with the clock input. </span>
2.  When XILSEM is enabled the PDI won't generate
- <a href>https://support.xilinx.com/s/article/000034918?language=en_US</a>
    1. Install tactical patch from 34918<br>
      1. download from the support link<br>
      2. unzip to <VIVADO_INSTALL_PATH>/Vivado/<ver>/patches/ar34918<br>
      3. Add XILINX_PATH env var and point it to <VIVADO_INSTALL_PATH/Vivado/<ver>/patches/ar34918<br>
      4. restart Vivado<br>
- <a href>https://support.xilinx.com/s/article/000035351?language=en_US</a>

Garret is able to produce PDI in 2022.1 Linux, could be a Windows/Linux compatibility issue.


# Vivado differences from KU060
1.  BITSTREAM.* properties in the xdc are no longer valid for the Versal PL
```
#set_property BITSTREAM.CONFIG.PERSIST YES           [current_design]
#set_property CONFIG_MODE              S_SELECTMAP32 [current_design]
#set_property BITSTREAM.CONFIG.USERID 12345678       [current_design]
set_property BITSTREAM.CONFIG.USR_ACCESS deadbeef   [current_design]
#set_property BITSTREAM.CONFIG.CONFIGFALLBACK    ENABLE      [current_design
```



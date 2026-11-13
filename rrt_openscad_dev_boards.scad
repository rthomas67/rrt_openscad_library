// TODO: Move this to a shared object library to reuse
wemosD1MiniCircuitBoardWidth=34.3;
wemosD1MiniCircuitBoardHeight=25.6;
wemosD1MiniCircuitBoardThickness=1.15;
wemosD1MiniComponentClearanceTop=4;
wemosD1MiniHoleDia=2;
wemosD1MiniHoleWidthWiseInset=3.1; // edge of board to center of hole
wemosD1MiniHoleHeightWiseInset=2.2; // edge of board to center of hole
wemosD1MiniUsbcHeightWiseCenter=13.2; // bottom edge of board to center of usb-c receptacle
wemosD1MiniUsbcLength=7.4; // end to end (aligned w/ x-axis)
wemosD1MiniUsbcThickness=3.25; // outer diameter of sides (aligned with z-axis)
wemosD1MiniUsbcWidth=9; // outer diameter of sides (aligned with z-axis)

wemosD1MiniPinHeaderPinCount=8;
wemosD1MiniPinHeaderWidthWiseInset=7.5;  // to center of first pin
wemosD1MiniPinHeaderBaseThickness=2; // z-axis 
DEFAULT_PIN_TO_PIN_SPACING=2.54;

//!wemosD1MiniModel();
module wemosD1MiniModel() {
    // circuit board
    color([0,0.5,0.5]) {
        difference() {
            cube([wemosD1MiniCircuitBoardWidth,wemosD1MiniCircuitBoardHeight,wemosD1MiniCircuitBoardThickness]);
            // hole1
            translate([wemosD1MiniHoleWidthWiseInset,wemosD1MiniHoleHeightWiseInset,-overlap])
                cylinder(d=wemosD1MiniHoleDia, h=wemosD1MiniCircuitBoardThickness+overlap*2);
            // hole2
            translate([wemosD1MiniHoleWidthWiseInset,wemosD1MiniCircuitBoardHeight-wemosD1MiniHoleHeightWiseInset,-overlap])
                cylinder(d=wemosD1MiniHoleDia, h=wemosD1MiniCircuitBoardThickness+overlap*2);
        }
    }
    // usbc receptacle
    color([0.847,0.855,0.871])  // chrome silver
        translate([wemosD1MiniCircuitBoardWidth-wemosD1MiniUsbcLength,wemosD1MiniUsbcHeightWiseCenter,wemosD1MiniUsbcThickness/2+wemosD1MiniCircuitBoardThickness])
            rotate([0,90,0])
                hull() {
                    translate([0,-wemosD1MiniUsbcWidth/2+wemosD1MiniUsbcThickness/2,0])
                        cylinder(d=wemosD1MiniUsbcThickness, h=wemosD1MiniUsbcLength);
                    translate([0,wemosD1MiniUsbcWidth/2-wemosD1MiniUsbcThickness/2,0])
                        cylinder(d=wemosD1MiniUsbcThickness, h=wemosD1MiniUsbcLength);
                }
    // pin headers
    translate([wemosD1MiniPinHeaderWidthWiseInset,DEFAULT_PIN_TO_PIN_SPACING/2,0])
        rotate([180,0,0])
            pinHeader(pinCount=wemosD1MiniPinHeaderPinCount);
    translate([wemosD1MiniPinHeaderWidthWiseInset,wemosD1MiniCircuitBoardHeight-DEFAULT_PIN_TO_PIN_SPACING/2,0])
        rotate([180,0,0])
            pinHeader(pinCount=wemosD1MiniPinHeaderPinCount);

}

// TODO: Move this to a shared object library to reuse
// extends from origin in +x direction with pins centered on x axis
//!pinHeader();
module pinHeader(pinCount=8, pinToPinSpacing=DEFAULT_PIN_TO_PIN_SPACING, baseThickness=2.6, pinLength=11.2, pinDia=0.8, pinExposedLength=5.8) {
    for (p=[0:1:pinCount-1]) {
        translate([pinToPinSpacing*p,0,0]) {
                
            // pin
            color([0.847,0.855,0.871])  // chrome silver
                translate([0,0,-pinLength+pinExposedLength+baseThickness])
                    rotate([0,0,45])
                        cylinder(d=pinDia, h=pinLength, $fn=4);
            // plastic base
            color([0.2,0.2,0.2])
                intersection() {
                    cylinder(d=pinToPinSpacing*1.2, h=baseThickness);
                    translate([-pinToPinSpacing/2,-pinToPinSpacing/2,0])
                        cube([pinToPinSpacing,pinToPinSpacing,baseThickness]);
                }
        }
    }
}

// TODO: Move this to a shared object library to reuse
waveshareEPaperCircuitBoardWidth=48.2;
waveshareEPaperCircuitBoardHeight=33.3;
waveshareEPaperCircuitBoardThickness=1.6;
waveshareEPaperDisplayWidth=37.4;
waveshareEPaperDisplayHeight=waveshareEPaperCircuitBoardHeight;
waveshareEPaperDisplayThickness=0.75;
waveshareEPaperDisplayRightMargin=6;  // non-display area on right of display
waveshareEPaperDisplayLabelSideInset=5;

screwHeadDia=5;
standoffHeight=6;

// !waveshareEPaper154Model();
module waveshareEPaper154Model() {
    // circuit board
    color([0,0.5,0.5]) {
        cube([waveshareEPaperCircuitBoardWidth,waveshareEPaperCircuitBoardHeight,waveshareEPaperCircuitBoardThickness]);
    }
    // screw heads and standoffs
    cornerHolePositions = [
        [screwHeadDia/2, screwHeadDia/2, 0],
        [waveshareEPaperCircuitBoardWidth-screwHeadDia/2, screwHeadDia/2, 0],
        [screwHeadDia/2, waveshareEPaperCircuitBoardHeight-screwHeadDia/2, 0],
        [waveshareEPaperCircuitBoardWidth-screwHeadDia/2, waveshareEPaperCircuitBoardHeight-screwHeadDia/2, 0]
    ];
    // screw heads
    for (chp=[0:1:3]) {
        color([0.847,0.855,0.871])  // chrome silver
            translate(cornerHolePositions[chp]) translate([0,0,waveshareEPaperCircuitBoardThickness+screwHeadDia/15])
                scale([1,1,0.7])
                    sphere(d=screwHeadDia);
    }
    // standoffs
    for (chp=[0:1:3]) {
        color([0.769,0.62,0.357])  // brass
            translate(cornerHolePositions[chp]) translate([0,0,-standoffHeight])
                cylinder(d=screwHeadDia, h=standoffHeight, $fn=6);
    }
    // cube for ePaper screen
    color([0.8,0.8,0.8])
        translate([waveshareEPaperDisplayLabelSideInset,0,waveshareEPaperCircuitBoardThickness])
            cube([waveshareEPaperDisplayWidth-waveshareEPaperDisplayRightMargin,waveshareEPaperDisplayHeight,waveshareEPaperDisplayThickness]);
    color([1,1,1])
        translate([waveshareEPaperDisplayLabelSideInset+waveshareEPaperDisplayWidth-waveshareEPaperDisplayRightMargin,
                0,waveshareEPaperCircuitBoardThickness])
            cube([waveshareEPaperDisplayRightMargin,waveshareEPaperDisplayHeight,waveshareEPaperDisplayThickness]);
    // cube on side for cable/plug clearance

}

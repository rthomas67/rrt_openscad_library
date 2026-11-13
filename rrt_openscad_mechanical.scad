overlap=0.01;
$fn=50;

module countersunkScrewHole(shaftDia=3, shaftLength=10, countersinkDepth=4, headDia=6) {
    union() {
        cylinder(d=shaftDia, h=shaftLength);
        translate([0,0,shaftLength-countersinkDepth])
            cylinder(d1=shaftDia, d2=headDia, h=countersinkDepth);
        // full top cutout for angled surface (countersink depth again as full cyl above head)
        translate([0,0,shaftLength-overlap])
            cylinder(d=headDia, h=max(shaftLength,5));
    }
}
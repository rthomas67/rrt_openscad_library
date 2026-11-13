overlap=0.01;
$fn=50;

module cylinderRing(outerDia, innerDia, ringHeight) {
    difference() {
        cylinder(d=outerDia, h=ringHeight);
        translate([0,0,-overlap])
            cylinder(d=innerDia, h=ringHeight+overlap*2);
    }
}

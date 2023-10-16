overlap=0.01;
$fn=50;

/* 
 * Produces a flat arc segment with the flat edge on the x-axis
 * cuts off the sides at a particular width if widthLimit is > 0
 * cuts off the negative-x side if rightHalf==true
 */
module flatArcSegment(arcHeight, arcRadius, widthLimit, rightHalf) {
    translate([0,-arcRadius+arcHeight]) // move flat edge back to origin
        difference() {
            circle(r=arcRadius, $fn=100);
            // cut off bottom/arc
            translate([-arcRadius-overlap,
                    -arcRadius-overlap-arcHeight,
                    -overlap])
                square([arcRadius*2+overlap*2,
                    arcRadius*2+overlap*2]);
            if (widthLimit > 0) {
                // cut off at tips (limit for larger arc radius value in a smaller area)
                // right end
                translate([widthLimit/2,
                    -arcRadius-overlap])
                    square([arcRadius+overlap,
                        arcRadius*2+overlap*2]);
                // left end cutoff
                translate([-arcRadius-overlap-widthLimit/2,
                    -arcRadius-overlap,-overlap])
                    square([arcRadius+overlap,
                        arcRadius*2+overlap*2]);
            }
            if (rightHalf) {
                // cut off at x-axis (right half)
                translate([-arcRadius-overlap,
                    -arcRadius-overlap])
                    square([arcRadius+overlap,
                        arcRadius*2+overlap*2]);
            }            
        }
}
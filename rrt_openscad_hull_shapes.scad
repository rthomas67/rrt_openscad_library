// rrt_openscad_hull_shapes.scad

/*
 * Creates a cube using cylinders at the corners
 * Resulting cube is positioned in +x/+y/+z just like a normal cube.
 */
module hullCubeFromCylinderCorners(cubeDimensions, cornerDia, fn=20) {
    cubeX=cubeDimensions[0];
    cubeY=cubeDimensions[1];
    cubeZ=cubeDimensions[2];
    hull() {
        // origin
        translate([cornerDia/2,cornerDia/2,0])
            cylinder(d=cornerDia, h=cubeZ, $fn=fn);
        // +x
        translate([cubeX-cornerDia/2,cornerDia/2,0])
            cylinder(d=cornerDia, h=cubeZ, $fn=fn);
        // +x, +y    
        translate([cubeX-cornerDia/2,cubeY-cornerDia/2,0])
            cylinder(d=cornerDia, h=cubeZ, $fn=fn);
        // +y
        translate([cornerDia/2,cubeY-cornerDia/2,0])
            cylinder(d=cornerDia, h=cubeZ, $fn=fn);
    }
}

/*
 * Creates a cube using spheres at the corners.
 * cubeDimensions arg is an array of numbers in [x,y,z] order
 */ 
module hullCubeFromSphereCorners(cubeDimensions, cornerDia, fn=20) {
    reducedX=cubeDimensions[0]-cornerDia;
    reducedY=cubeDimensions[1]-cornerDia;
    reducedZ=cubeDimensions[2]-cornerDia;
    // Move everything fully into +x, +y, +z AFTER construction at the correct size
    translate([cornerDia/2,cornerDia/2,cornerDia/2]) {
        hull() {
            // Bottom of box

            // at origin
            rotateLowFacetCount(fn) sphere(d=cornerDia, $fn=fn);
            // +x
            translate([reducedX,0,0])
                rotateLowFacetCount(fn) sphere(d=cornerDia, $fn=fn);
            // +y
            translate([0,reducedY,0])
                rotateLowFacetCount(fn) sphere(d=cornerDia, $fn=fn);
            // +x +y
            translate([reducedX,reducedY,0])
                rotateLowFacetCount(fn) sphere(d=cornerDia, $fn=fn);

            // Top of box
            // at origin +z
            translate([0,0,reducedZ])
                rotateLowFacetCount(fn) sphere(d=cornerDia, $fn=fn);
            // +x +z
            translate([reducedX,0,reducedZ])
                rotateLowFacetCount(fn) sphere(d=cornerDia, $fn=fn);
            // +y +z
            translate([0,reducedY,reducedZ])
                rotateLowFacetCount(fn) sphere(d=cornerDia, $fn=fn);
            // +x +y +z
            translate([reducedX,reducedY,reducedZ])
                rotateLowFacetCount(fn) sphere(d=cornerDia, $fn=fn);

        }
    }
}

module rotateLowFacetCount(fn) {

    if (fn<4) {
        facetRotation=180/fn;
        echo(facetRotation);
        rotate([facetRotation,facetRotation,facetRotation])
            children();
    } else {
        children();
    }

}
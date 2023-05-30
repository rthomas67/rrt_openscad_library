// rrt_openscad_hull_shapes.scad

/*
 * Creates a cube using spheres at the corners.
 * cubeDimensions arg is an array of numbers in [x,y,z] order
 */ 
module hullCubeFromSphereCorners(cubeDimensions, cornerDia, fn) {
    reducedX=cubeDimensions[0]-cornerDia;
    reducedY=cubeDimensions[1]-cornerDia;
    reducedZ=cubeDimensions[2]-cornerDia;
    // Move everything fully into +x, +y, +z AFTER construction at the correct size
    translate([cornerDia/2,cornerDia/2,cornerDia/2]) {
        hull() {
            // Bottom of box

            // at origin
            sphere(d=cornerDia, $fn=fn);
            // +x
            translate([reducedX,0,0])
                sphere(d=cornerDia, $fn=fn);
            // +y
            translate([0,reducedY,0])
                sphere(d=cornerDia, $fn=fn);
            // +x +y
            translate([reducedX,reducedY,0])
                sphere(d=cornerDia, $fn=fn);

            // Top of box
            // at origin +z
            translate([0,0,reducedZ])
                sphere(d=cornerDia, $fn=fn);
            // +x +z
            translate([reducedX,0,reducedZ])
                sphere(d=cornerDia, $fn=fn);
            // +y +z
            translate([0,reducedY,reducedZ])
                sphere(d=cornerDia, $fn=fn);
            // +x +y +z
            translate([reducedX,reducedY,reducedZ])
                sphere(d=cornerDia, $fn=fn);

        }
    }
}
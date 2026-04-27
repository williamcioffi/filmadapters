// possible case dimensions
case_dims_35mk2 = [60.8, 89.4];
case_dims_3x4mk2 = [106.5, 133.2];

// select desired case dimensions
case_dims = case_dims_35mk2; 

// better resolution
$fa = 1;
$fs = 0.4;

// outside shape
outerx = case_dims[0];
outery = case_dims[1];
outerz = 3.8;


// radius for the curved corners 
curveradius = 4;

// define modules

module rounded_rect_prism(x, y, z, r1) {
    hull() {
        translate([x/2 - r1, y/2 - r1, 0])
            cylinder(z, r1, r1, center = true);
        translate([-x/2 + r1, y/2 - r1, 0])
            cylinder(z, r1, r1, center = true);
        translate([-x/2 + r1, -y/2 + r1, 0])
            cylinder(z, r1, r1, center = true);
        translate([x/2 - r1, -y/2 + r1, 0])
            cylinder(z, r1, r1, center = true);
    }
}


rounded_rect_prism(outerx, outery, outerz, curveradius);
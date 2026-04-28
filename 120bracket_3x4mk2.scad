// get scurve code
include <scurve-channel.scad>

// possible case dimensions
case_dims_3x4mk2 = [106.5, 133.2];

// select desired case dimensions
case_dims = case_dims_3x4mk2; 

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


module base() {
rounded_rect_prism(outerx, outery, outerz, curveradius);
}

// testing the actual film holding mechanism


outerfilmwidth = 62;
innerfilmwidth = 62 - 2.5*2;
length = 125;
z2 = 5;

scurechannelbracketheight = 20;

scurvelen = 122;
lenbuff = 2;

// left plate with channel
difference() {
    translate([lenbuff, 0, 0]) cube([scurvelen - lenbuff, scurechannelbracketheight, z2]);
                      
    translate([0, 2, z2/2]) scurvechannel();
}

// right plate with channel
difference() {
    translate([lenbuff, 0, outerfilmwidth - channeldepth + z2/2]) cube([scurvelen - lenbuff, scurechannelbracketheight, z2]);
    
    translate([0, 2, outerfilmwidth - channeldepth - smalloverlap + z2/2]) scurvechannel();
}

//structure

difference() {
    //top
color([1, 0, 0, .25])    translate([lenbuff, scurechannelbracketheight - 5, 0]) cube([scurvelen - lenbuff, 5, outerfilmwidth + z2/2]);

//    //make a window
    translate([flatlen + lenbuff + 5 - flatlen/2, scurechannelbracketheight - 5 - smalloverlap, z2]) cube([flatlen, lenbuff + 5 + smalloverlap*2, innerfilmwidth]);
}

translate([lenbuff, 0, 0]) cube([15, 5, outerfilmwidth + z2/2]);

translate([scurvelen - 12, 0, 0]) cube([12, 5, outerfilmwidth + z2/2]);



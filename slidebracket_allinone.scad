// increase fragment size for prettier cylinders
// $fn = 25;

// better resolution
$fa = 1;
$fs = 0.4;

// overlap
smalloverlap = 2;

// outside shape
outerx = 60.8;
outery = 89.4;
outerz = 3.8;

// raised edge (fits into piece above)
innerx = 42.6;
innery = 78.6;
innerz = 3.2;

// width of the raised edge
windowwidth = 1.8;

// inner dimensions of the raised edge
innerwindowx = innerx - windowwidth*2;
innerwindowy = innery - windowwidth*2;

// a height big enough to make a cut out with difference
cutoutz = 15;

// dimensions of the cutout for the slide
outer_slidexy = 52;
inner_slide_lip = 5;

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

module bottom() {
    difference() {
        // base plate
        rounded_rect_prism(outerx, outery, outerz + smalloverlap, curveradius);
        // window for slide light
        cube([outer_slidexy - 2*inner_slide_lip, outer_slidexy - 2*inner_slide_lip, cutoutz], center = true);
    }
}

module connecting_lip() {
    difference() {
        rounded_rect_prism(innerx, innery, innerz + smalloverlap, curveradius);
        rounded_rect_prism(innerwindowx, innerwindowy, cutoutz, curveradius);
    }
}

module top() {
    difference() {
        // base plate
        union() {
            rounded_rect_prism(outerx, outery, outerz, curveradius);
            translate([0, 0, innerz - smalloverlap/2]) connecting_lip();
        }
        // cut out for fingies
        rounded_rect_prism(innerwindowx, innerwindowy, cutoutz, curveradius);
        // cut out for slide
        cube([outer_slidexy, outer_slidexy, cutoutz], center = true);
    }
}

// build it

translate([0, 0, outerz - smalloverlap]) top();
translate([0, 0, smalloverlap/2]) bottom();

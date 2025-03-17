// increase fragment size for prettier cylinders
$fn = 25;

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
slidexy = 52;

// radius for the curved corners 
curveradius = 1.5;

// define modules

module outerpart() {
  hull() {
  translate([outerx/2 - curveradius, outery/2 - curveradius, 0])
    cylinder(outerz, curveradius, curveradius, center = true);
  translate([-outerx/2 + curveradius, outery/2 - curveradius, 0])
    cylinder(outerz, curveradius, curveradius, center = true);
  translate([-outerx/2 + curveradius, -outery/2 + curveradius, 0])
    cylinder(outerz, curveradius, curveradius, center = true);
  translate([outerx/2 - curveradius, -outery/2 + curveradius, 0])
    cylinder(outerz, curveradius, curveradius, center = true);      
  }
}

module innerpart() {
  hull() {
  translate([innerx/2 - curveradius, innery/2 - curveradius, innerz])
    cylinder(outerz, curveradius, curveradius, center = true);
  translate([-innerx/2 + curveradius, innery/2 - curveradius, innerz])
    cylinder(outerz, curveradius, curveradius, center = true);
  translate([-innerx/2 + curveradius, -innery/2 + curveradius, innerz])
    cylinder(outerz, curveradius, curveradius, center = true);
  translate([innerx/2 - curveradius, -innery/2 + curveradius, innerz])
    cylinder(outerz, curveradius, curveradius, center = true);      
  }
}

module innerwindow() {
  hull() {
  translate([innerwindowx/2 - curveradius, innerwindowy/2 - curveradius, 0])
    cylinder(cutoutz, curveradius, curveradius, center = true);
  translate([-innerwindowx/2 + curveradius, innerwindowy/2 - curveradius, 0])
    cylinder(cutoutz, curveradius, curveradius, center = true);
  translate([-innerwindowx/2 + curveradius, -innerwindowy/2 + curveradius, 0])
    cylinder(cutoutz, curveradius, curveradius, center = true);
  translate([innerwindowx/2 - curveradius, -innerwindowy/2 + curveradius, 0])
    cylinder(cutoutz, curveradius, curveradius, center = true);      
  }
}

module slidewindow() {
  cube(size = [slidexy, slidexy, cutoutz], center = true);
}


// make base shape
module base() {
  outerpart();
  innerpart();
}

// cut out innerwindow and slidewindow
difference() {
  difference() {
    base();
    innerwindow();
  }
  slidewindow();
}

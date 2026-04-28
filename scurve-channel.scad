// s curve channel
// Bezier curve code from Benjamin Wand
// https://github.com/benjaminwand/cookie-cutters
// CC-BY-4.0 https://creativecommons.org/licenses/by/4.0/

// variables
fs = 1.2;  // roughly the size of straight parts of curves
w1 = 0.2;   // cookie cutter, thicker side
w2 = 0.2;   // cookie cutter, thinner side
h = 2.5 + 0.2;     // cookie cutter height


// functions and modules
function fn(a, b) = round(sqrt(pow(a[0]-b[0],2) + pow(a[1]-b[1], 2))/fs);

function with_slope(p, x_diff, s) // point, difference in x, slope
    = [p[0] + x_diff, p[1] + x_diff * s];    

module shape() cylinder(h, w1/2, w2/2, $fn=12);
    
module b_curve(pts)             // pts is an array of points
    let (idx=fn(pts[0], pts[len(pts)-1]), n = 1/idx){       
        for (i= [0:idx-1]) 
        hull(){ 
           translate(b_pts(pts, n, i)) shape();
           translate(b_pts(pts, n, i+1)) shape();          
        }
    }
    
function b_pts(pts, n, idx) =       // gets called by b_curve() ...
    len(pts)>2 ?                    // ... and b_curve_rainbow() 
        b_pts([for(i=[0:len(pts)-2])pts[i]], n, idx) * n*idx 
            + b_pts([for(i=[1:len(pts)-1])pts[i]], n, idx) * (1-n*idx)
        : pts[0] * n*idx 
            + pts[1] * (1-n*idx);

module scurvechannel() {
    p1 = [0, 0];
    p2 = [0, 8.5];
    p2b = [10, 8];
    p2c = [25, 2];
    p3 = [30, 0];
    p3b = [35, 0];

    p3c = [35+45, 0];
    p4 = [35+50, 0];
    p4b = [35+50+5, 1];
    p5 = [35+50+22, 12];

    b_curve([p1, p2, p2b, p2c, p3, p3b]);
    b_curve([p3b, p3c]);
    b_curve([p3c, p4, p4b, p5]);
}
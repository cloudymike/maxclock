//Module to create a knurl pocket suitable for Heat-set inserts
//Global vars
$fa = 1;
$fs = 0.2;
knurl_radius = 1.75;
knurl_wall = 1.6;


module m2knurl_ring(knurl_depth = 5)
{

  ringR=knurl_radius+knurl_wall;
    difference() {   
        cylinder(h=knurl_depth, r1=2*ringR, r2=ringR, center=true);
        m2knurl_pocket(knurl_depth = 5);
    }
    
}

module m2knurl_pocket(knurl_depth = 5)
{
 union() {
    cylinder(h=knurl_depth+0.001, r=knurl_radius,center=true);
    translate([0,0,0.4*knurl_depth])
        cylinder(h=0.25 * knurl_depth, r1=knurl_radius, r2=1.2*knurl_radius, center=true);
 }
}

m2knurl_ring();
translate([10,0,0]) m2knurl_pocket();

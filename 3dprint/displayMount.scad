include <BOSL/constants.scad>
use <BOSL/metric_screws.scad>
// fn will be overridden by test script
$fn=100;

//metric_nut(size=6, hole=true, pitch=1, flange=3, details=true);

thickness=2;


totalWidth=368;
halfWidth=totalWidth/2;
height=94;


displayX=131.5;
displayY=31.85;


wallZ=5;
cutZ=wallZ;

//for development
//plateX=displayX+8;
//plateY=displayY+8;

//For fitting on real plate
//plateX=halfWidth;
//plateY=height;
plateX=displayX+wallZ;
plateY=displayY+wallZ;

//displayOffset=height/2-displayY/2-50;
displayOffset=0;

windowThickness=0.4;

OX=0.2;

screwSize=6;
screwHeadHeight=get_metric_bolt_head_height(screwSize);

module displayFront()
{
  difference()
  {
    union()
    {
      translate([0,0,thickness/2])cube([plateX,plateY,thickness],center=true);
      translate([0,displayOffset,cutZ/2])cube([displayX+wallZ*2, displayY+wallZ*4,cutZ],center=true);
   }
    translate([0,displayOffset,cutZ/2+windowThickness])cube([displayX, displayY,cutZ],center=true);
  }

// Bolts for fastening display
  translate([0,displayOffset+displayY/2+screwSize,screwHeadHeight/2])
    rotate([180,0,0])
      metric_bolt(headtype="countersunk",size=screwSize, l=20, details=true, $fn=32);
  translate([0,displayOffset-(displayY/2+screwSize),screwHeadHeight/2])
    rotate([180,0,0])
      metric_bolt(headtype="countersunk",size=screwSize, l=20, details=true, $fn=32);
  
  translate([displayX/3,displayOffset+displayY/2+screwSize,screwHeadHeight/2])
    rotate([180,0,0])
      metric_bolt(headtype="countersunk",size=screwSize, l=20, details=true, $fn=32);
  translate([displayX/3,displayOffset-(displayY/2+screwSize),screwHeadHeight/2])
    rotate([180,0,0])
      metric_bolt(headtype="countersunk",size=screwSize, l=20, details=true, $fn=32);
  
  translate([-displayX/3,displayOffset+displayY/2+screwSize,screwHeadHeight/2])
    rotate([180,0,0])
      metric_bolt(headtype="countersunk",size=screwSize, l=20, details=true, $fn=32);
  translate([-displayX/3,displayOffset-(displayY/2+screwSize),screwHeadHeight/2])
    rotate([180,0,0])
      metric_bolt(headtype="countersunk",size=screwSize, l=20, details=true, $fn=32);
  
}

module holdBar(){
  barThickness=2*thickness;
  difference()
  {
    cube([screwSize*2,displayY+4*screwSize,barThickness],center=true);
    translate([0,-(displayY/2+screwSize),0])
      cylinder(d=1.2*screwSize,h=barThickness+0.1,center=true);
    translate([0,(displayY/2+screwSize),0])
      cylinder(d=1.2*screwSize,h=barThickness+0.1,center=true);
  }
}

difference()
{
displayFront();
//translate([plateX/4+8,0,0])cube([plateX/2, 2*plateY, 25],center=true);
//translate([-plateX/4-8,0,0])cube([plateX/2, 2*plateY, 25],center=true);
}
//translate([0,displayOffset,20])holdBar();
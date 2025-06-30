use <basePlate.scad>
use <boardAssemble.scad>
use <displayMount.scad>

totalWidth=368;
halfWidth=totalWidth/2;
height=94;
backHeight=60;
lip=20;
overhang=15;
roofLean=20; //degrees
maxDepth=100;
thickness=2;

frontExtra=17.6;
usbY=-20;
displayY=12;

displayCutX=131.5+4;
displayCutY=31.85+4;

difference()
{
  rightCover();
  translate([-halfWidth/2+15,usbY,0])cube([15,50,10],center=true);
  translate([0,displayY,0])cube([displayCutX,displayCutY,10],center=true);
}


translate([-halfWidth/2+thickness,usbY,frontExtra-thickness/2])
  rotate([0,0,90])
    boardAssemble();

translate([0,displayY,-thickness/2])
  rotate([0,0,0])
    displayFront();
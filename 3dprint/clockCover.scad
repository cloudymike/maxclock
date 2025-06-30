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

usbY=-height/2+5;
displayY=12;

displayCutX=131.5+4;
displayCutY=31.85+4;

difference()
{
  leftCover();
  translate([0,usbY+12,0])cube([50,15,10],center=true);
  translate([0,displayY,0])cube([displayCutX,displayCutY,10],center=true);
}


translate([0,usbY,frontExtra-thickness/2])
  rotate([0,0,180])
    boardAssemble();

translate([0,displayY,-thickness/2])
  rotate([0,0,0])
    displayFront();
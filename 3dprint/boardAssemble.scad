use <boardMount.scad>
use <boardFront.scad>


module boardAssemble()
{
  frontPlate();
  mountPlate();
}


difference()
{
boardAssemble();
  translate([0,0,50+10])cube([60,60,100],center=true);
  translate([-18.5,0,0])cube([30,60,100],center=true);
}
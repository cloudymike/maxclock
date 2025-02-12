

displayX=132;
displayY=32.5;
displayZ=15;
wall=4;

difference()
{
  cube([displayX+2*wall, displayY+2*wall, 5],center=true);
  translate([0,0,0.4])cube([displayX, displayY, 5],center=true);
  //translate([3*displayX/8,0,0.2])cube([displayX/4, displayY, 5],center=true);
  //translate([displayX/8,0,0.4])cube([displayX/4, displayY, 5],center=true);
  //translate([-displayX/8,0,0.8])cube([displayX/4, displayY, 5],center=true);
  //translate([-3*displayX/8,0,1.6])cube([displayX/4, displayY, 5],center=true);
}


use <knurlpocket.scad>

thickness=2;

plateX=106;
plateZ=thickness;

boardX=89;
boardY=52;

centerHoleSize=3;
centerHoleX=6.08+centerHoleSize/2;
centerHoleY=boardY/2;

cornerHoleSize=2;
cornerHoleX=5;
cornerHoleY=8;

mountHeight=5;
boardThickness=2;
pegBaseExtra=2;

module rib()
{
  height=1;
  translate([0,0,height/2])cube([boardX,height,height],center=true);
}

module boardPlate()
{
  translate([0,0,plateZ/2])cube([boardX,boardY,plateZ],center=true);
}

module centerPeg()
{
  translate([0,0,mountHeight+boardThickness])cylinder(d1=centerHoleSize,d2=centerHoleSize/2,h=boardThickness*2,center=true,$fn=64);
  translate([0,0,mountHeight/2])cylinder(d2=centerHoleSize+4,d1=(centerHoleSize+4)*2,h=mountHeight,center=true,$fn=64);
}

//Actual mount plate without orienting transformations
module mountPlateNT()
{
  boardPlate();
  translate([centerHoleX-boardX/2,0,plateZ])centerPeg();
  translate([boardX/2-centerHoleX,0,plateZ])centerPeg();
  translate([boardX/2-cornerHoleX,boardY/2-cornerHoleY,plateZ+mountHeight/2])
    m2knurl_ring(mountHeight);
  translate([-boardX/2+cornerHoleX,boardY/2-cornerHoleY,plateZ+mountHeight/2])
    m2knurl_ring(mountHeight);
  translate([boardX/2-cornerHoleX,-boardY/2+cornerHoleY,plateZ+mountHeight/2])
    m2knurl_ring(mountHeight);
  translate([-boardX/2+cornerHoleX,-boardY/2+cornerHoleY,plateZ+mountHeight/2])
    m2knurl_ring(mountHeight);
  
  translate([0,0,plateZ])rib();
  translate([0,14,plateZ])rib();
  translate([0,-14,plateZ])rib();
}

//Orient to fit pieces together
module mountPlate()
{
  translate([0,thickness/2,boardX/2]) rotate([0,90,-90])
    mountPlateNT();
}
mountPlate();
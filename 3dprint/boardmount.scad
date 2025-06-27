use <knurlpocket.scad>
plateX=106;
plateZ=1;

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
  translate([0,0,(mountHeight+boardThickness)/2])cylinder(d=centerHoleSize,h=mountHeight+boardThickness,center=true,$fn=64);
  translate([0,0,mountHeight/2])cylinder(d=centerHoleSize+4,h=mountHeight,center=true,$fn=64);
}

module mountPlate()
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

mountPlate();


totalWidth=368;
plateWidth=totalWidth/2;
height=90;
backHeight=60;
lip=10;
overhang=5;
roofLean=20; //degrees
maxDepth=90;
thickness=2;

module sideWall()
{
  translate([0,-height/2,0])
  rotate([0,-90,0])
  linear_extrude(thickness,center=true)
  polygon(points=[[0,0],
                  [0,height],
                  [maxDepth,backHeight],
                  [maxDepth,0]]);
}


module basePlate()
{
  
  cube([plateWidth, height, thickness],center=true);
  translate([0,-(height+lip)/2,(overhang)/2])cube([plateWidth,lip,overhang+thickness],center=true);  
}




module baseCover()
{
  basePlate();
  translate([(plateWidth-thickness)/2,0,0])sideWall();
  translate([-(plateWidth-thickness)/2,0,0])sideWall();
}

//testing
difference()
{
  baseCover();
  translate([-20,0,0])cube([plateWidth,height+2*lip, maxDepth*2],center=true);
}
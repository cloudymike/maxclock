

totalWidth=368;
halfWidth=totalWidth/2;
height=94;
backHeight=60;
lip=20;
overhang=15;
roofLean=20; //degrees
maxDepth=100;
thickness=2;

m5_length=16;
m5_countersink_depth=2.9;
m5_countersink_top_diameter=10.0;
m5_diameter=5.5;

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

module insideWall()
{
  difference()
  {
    sideWall();
    translate([0,0,3*maxDepth/4])cube([2*thickness,height,maxDepth/2],center=true);
  }
}


module basePlate(plateWidth)
{
  
  cube([plateWidth, height, thickness],center=true);
  difference()
  {
    translate([0,-(height+lip)/2,(overhang)/2])cube([plateWidth,lip,overhang+thickness],center=true); 
    
    // Do NOT move the screw holes when the size of the plate is adjusted.
    translate([halfWidth/4,-height/2-lip+m5_countersink_top_diameter/2+1,-(thickness)/2]) screwHole();
    translate([-halfWidth/4,-height/2-lip+m5_countersink_top_diameter/2+1,-(thickness)/2]) screwHole();
  } 
}


module countersink(top_radius, hole_radius, sink_depth)
{
      rotate_extrude($fn=200) 
      polygon([[0,0],[top_radius,0],[hole_radius,sink_depth],[0,sink_depth]]);
}

module screwHole()
{
      cylinder(d=m5_countersink_top_diameter,h=1,center=true, $fn=64);
      translate([0,0,0.5])countersink(m5_countersink_top_diameter/2,2.5,m5_countersink_depth);
      cylinder(d=m5_diameter,h=10*overhang,center=true, $fn=64);
}

module baseCover(plateWidth)
{
  basePlate(plateWidth);
  translate([(plateWidth-thickness)/2,0,0])sideWall();
  translate([-(plateWidth-thickness)/2,0,0])insideWall();
}

module leftCover()
{
  plateWidth=halfWidth;
  baseCover(plateWidth);
}

module rightCover()
{
  plateWidth=halfWidth-1.5;
  mirror([1,0,0])baseCover(plateWidth);
}


module testPrint()
{
//testing
  difference()
  {
    rightCover();
    //translate([8,0,0])cube([plateWidth,height+2*lip, maxDepth*2],center=true);
    //translate([147,0,0])cube([plateWidth,height+2*lip, maxDepth*2],center=true);
    translate([0,30,0])cube([halfWidth,height+2*lip, maxDepth*2],center=true);
    translate([0,-height/2-15,0])cube([halfWidth,lip, maxDepth*2],center=true);
    translate([0,0,70])cube([200,200,80],center=true);
  }
}

rightCover();
use <basePlate.scad>

thickness=get_thickness();
cableWidth=10;
cableHeight=5;
difference()
{
  rightCover();
  translate([-get_totalWidth()/4+cableWidth/2,get_height()/2-cableHeight/2,0])
    cube([cableWidth,cableHeight,thickness*2],center=true);
}
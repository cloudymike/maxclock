
// Outside variables
thickness=2;
boardY=52;
mountHeight=5;

//Variables for all modules
frontX=boardY;
frontY=20;
frontZ=thickness;
frontExtra=17.6-thickness;

LDRd=5.0;
LDRpipe=14;
LDRoffset=11;
usbX=13.4;
usbY=5.7;
gap=0.2;

usbBoardThickness=1.8;
usbBoardIndent=1;


//Actual front plate without orienting transformations
module frontPlateNT()
{
  difference()
  {
    union(){
      // Front panel centered for holes etc
      cube([frontX,frontY,frontZ],center=true);
      //Extra bottom panel to each board mount
      translate([0,frontY/2+mountHeight/2+thickness/2,0])cube([frontX,mountHeight+thickness,frontZ],center=true);
      //LDR pipe
      translate([LDRoffset,0,LDRpipe/2])cylinder(d=LDRd+gap+2,h=LDRpipe,center=true,$fn=64);
    }
    // Cut the top, yes this is a hack  
    translate([0,-frontY/2,0])cube([frontX,8,frontZ+0.1],center=true);  
    //USB opening
    cube([usbX+gap,usbY+gap,frontZ+0.1],center=true);    
    // USB board notch
    translate([0,(usbY+gap+usbBoardThickness)/2,(thickness-usbBoardThickness)/2])
        cube([usbX+gap,usbBoardThickness,usbBoardIndent],center=true);    

    // LDR pipe hole
    translate([LDRoffset,0,0.2+LDRpipe/2])cylinder(d=LDRd+gap,h=frontZ+LDRpipe,center=true,$fn=64);
  }
  //Extra front board
  translate([0,frontY/2+mountHeight+thickness/2,(frontExtra+thickness)/2])cube([frontX,thickness,frontExtra],center=true);

  // spacers
  translate([20,frontY/2-mountHeight,(frontExtra+thickness)/2])cube([1,frontY,frontExtra],center=true);
  translate([-20,frontY/2-mountHeight,(frontExtra+thickness)/2])cube([1,frontY,frontExtra],center=true);
}

//Orient to fit pieces together
module frontPlate()
{
  translate([0,-frontY/2-mountHeight-thickness/2,-frontExtra-thickness/2])
    frontPlateNT();
}


frontPlateNT();
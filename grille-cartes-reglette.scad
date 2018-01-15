c=20;   //côté carré
m=4;    //marge inter-carré
mp=7;  //marge plateau

module quadrillage(imax,jmax){
for(i = [1 : imax],j = [1 : jmax])
    translate([(i-1)*(c+m),(j-1)*(c+m)])
    cube(c);
    }

module plateau(imax=4,jmax=4){
    px=imax*(c+m)-m+2*mp;
    py=jmax*(c+m)-m+2*mp;
    echo("dimensions plateau :",px,py); 
    projection()
    difference(){
        cube([px,py,3]);
        translate([mp,mp,-1])
        quadrillage(imax=imax,jmax=jmax);
    }
    projection()
        translate([0,py+3,0])
        cube([px,py,3]);
}

plateau(imax=4,jmax=4);
translate([111+3,0,0])
plateau(imax=12,jmax=1);




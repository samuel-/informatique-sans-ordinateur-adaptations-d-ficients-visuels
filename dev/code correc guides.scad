c=20;   //côté carré
m=4;    //marge
mm=13;  //marge ac code correcteur
mp=5;  //marge plateau
imax=4; // nb colonnes
jmax=4; // nb lignes
lguide1=3; // largeur du guide impair
lguide2=12; // largeur du guide pair
eguide=3; // épaisseur guide
i=0;
j=0;
//projection(cut = true) 

module quadrillage(f=0){
for(i = [1 : imax],j = [1 : jmax])
    //echo(c);    
    translate([(i-1)*(c+m),(j-1)*(c+m)])
    if (f==0) cube(c);
        else translate([c/2,c/2,0]) cylinder(c,d=c);
for(i = [1 : imax])
    translate([(i-1)*(c+m),jmax*(c+m)+mm])
    if (f==0) cube(c);
        else translate([c/2,c/2,0]) cylinder(c,d=c);
for(j = [1 : jmax])
    translate([imax*(c+m)+mm,(j-1)*(c+m)])
    if (f==0) cube(c);
        else translate([c/2,c/2,0]) cylinder(c,d=c);
}

module guidev() {
    
}

module guides(){
    for(i = [1 : imax]) {
        if (i % 2 == 0)
            translate([(i-1)*(c+m)+c/2-lguide2/2, -mp,  eguide - 1])
            cube([lguide2, py, e]);
        else
            translate([(i-1)*(c+m)+c/2-lguide1/2, -mp,  eguide - 1])
            cube([lguide1, py, e]);;
    }
    for(j = [1 : jmax]) {
         if (j % 2 == 0)
            translate([-mp,(j-1)*(c+m)+c/2-lguide2/2,  eguide - 1])
           cube([px, lguide2, e]);
         else
            translate([-mp,(j-1)*(c+m)+c/2-lguide1/2,  eguide - 1])
           cube([px, lguide1, e]);
    }
}

//plateau
module plateau(f=0,g=1){
    px=imax*(c+m)+(c+mm)+2*mp;
    py=jmax*(c+m)+(c+mm)+2*mp;
    echo("dimensions plateau :",px,py);
    e = min(c,m,mm,mp)-1.5;
    if(g==0)
    difference(){
        union(){
            cube([px,py,e]);
            translate([mp,mp,-1]) guides(e=e, c=c, px=px, py=py,m=m,mm=mm,mp=mp,imax=imax,jmax=jmax);
        }
        translate([mp,mp,-1]) quadrillage(f=f,c=c,m=m,mm=mm,mp=mp,imax=imax,jmax=jmax);
    }
    else if(g==1)
    projection()
    difference(){
        cube([px,py,e]);
        translate([mp,mp,-1]) quadrillage(f=f,c=c,m=m,mm=mm,mp=mp,imax=imax,jmax=jmax);
    }
    else if(g==2)
    projection()
    difference(){
        translate([mp,mp,-1]) guides(e=e, c=c, px=px, py=py,m=m,mm=mm,mp=mp,imax=imax,jmax=jmax);
        translate([mp,mp,-1]) quadrillage(f=f,c=c,m=m,mm=mm,mp=mp,imax=imax,jmax=jmax);
    }
}

module SeparateChildrenX(space){
    for ( i= [0:1:$children-1])   // step needed in case $children < 2  
        translate([i*space,0,0]) children(i);
}
module SeparateChildrenY(space){
    for ( i= [0:1:$children-1])   // step needed in case $children < 2  
        translate([0,i*space,0]) children(i);
}



SeparateChildrenY(250){
    SeparateChildrenX(250){
        plateau(c=20,f=0);
        plateau(c=30,f=0);
        plateau(c=35,f=0);
    //    plateau(c=40,m=7,mm=12,f=0);
    }
    SeparateChildrenX(250){
    //    plateau(c=35.5,f=1);
    //    plateau(c=35.5,m=5,mm=10,f=1);
    //    plateau(c=35.5,imax=5,jmax=5,f=1);
    }
}
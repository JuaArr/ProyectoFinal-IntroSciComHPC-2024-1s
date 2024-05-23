


tm=2;
tmr=0.1;
r=3; //radio

//puntos

Point(1)={0,0,0,tm};
Point(2)={40,0,0,tm};
Point(3)={40,20,0,tm};
Point(4)={0,20,0,tm};

Point(5)={20,10,0};
Point(6)={20+r,10,0,tmr};
Point(7)={20-r,10,0,tmr};

//lineas

Line(1)={1,2};
Line(2)={2,3};
Line(3)={3,4};
Line(4)={4,1};

//circle

Circle(5)={6,5,7};
Circle(6)={7,5,6};

//contornos

Curve Loop(1)={1,2,3,4};
Curve Loop(2)={5,6};

Plane Surface(1)={1,2};


//puntos fisicos

Physical Line("Borde Inferior")={1};
Physical Line("Carga")={3};

Physical Surface("Mi superficie")={1};

Mesh 2;

Mesh.SurfaceFaces=1;
Mesh.Points=1;

Save "malla.msh";
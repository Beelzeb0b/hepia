-- Estimation de valeur de PI
-- Cedric Dos Reis - 26.09.2017
-- Algorithmique

with Text_IO;                     use Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;

procedure estimation_pi is
	PI : Float := ada.numerics.pi;
	nbIteration : integer := 10000;
	somme : Float := 0.0;

-- instanciation d'un paquetage g�n�rique de fonctions
   package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
   use Math;
begin
	
	Put(PI,10,10,0);
	Put(" = Pi");
	New_line;


	-- formule 1
	for I in 1..nbIteration loop
   	somme := somme + 1.0/Float(I)**4;
	end loop;
	Put((90.0*somme)**(1.0/4.0),10,10,0);
	Put(" = Formule 1");
	New_line;

	
	
	-- formule 2
	somme := 0.0;
	for I in 1..nbIteration loop
		somme := somme + ((-1.0)**(i+1)) / (Float(i)**2);
	end loop;
	Put((somme*12.0)**(1.0/2.0),10,10,0);
	Put(" = Formule 2");
	New_line;

	
	
	
	-- formule 3
	somme := 1.0;
	for I in 1..nbIteration loop
   	--somme := somme * ( (2.0*Float(i)) / (2.0*Float(i) - 1.0) ) * ( (2.0*Float(i)) / (2.0*Float(i)-1.0) );
		somme := somme * ( Float(i*2) / Float(i*2-1) ) * ( Float(i*2) / Float(i*2+1));
	end loop;

	Put(somme * 2.0,10,10,0);
	Put(" = Formule 3");


	
end Estimation_PI;
	

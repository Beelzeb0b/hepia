-- Estimation de valeur de PI
-- Cedric Dos Reis - 26.09.2017
-- Algorithmique

with Text_IO;                     use Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;

procedure estimation_pi_montecarlo is
	PI : Float := ada.numerics.pi;
	nbIteration : integer := 10;
	cmpt : Integer := 0;
	Gen : Generator;
	x : Float := 0.0;
	y : Float := 0.0;
	adj : Float :=0.0;
	caca : Float := 0.0;

-- instanciation d'un paquetage g�n�rique de fonctions
   package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
   use Math;
begin
	Reset(Gen);
		
	
	--for I in 1..nbIteration loop
		x := (Random(Gen)-1.0) * 2.0;
		y := Random(Gen);
		adj := (x**2.0 + y**2.0)**1.0/2.0;
		
		
		--if adj < 1.0 then
		--	cmpt := cmpt +1; 
		--end if;	
		
	--end loop;

		put(x,0,10,0);
		New_line;
		put(y,0,10,0);	
		New_Line;
		--put(adj,0,10,0);

end estimation_pi_montecarlo;

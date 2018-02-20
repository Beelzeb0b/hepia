-- Code de Reed Solomon
-- Programme de test du paquet "Gestion_Polynomes"
-- Cedric Dos Reis - 05.12.2017
-- Algorithmique

with Text_IO;                     use Text_IO;
WITH Ada.Command_Line;				USE Ada.Command_Line; 
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;
with Gestion_Fractions; use Gestion_Fractions;
with Gestion_Polynomes; use Gestion_Polynomes;

procedure Calcul_Polynomes is
	p0 : T_Polynome(0);
	p1, p2 : T_Polynome(1);
	p3 : T_Polynome(3);
	f0,f1, f2, f3, f4, f5, f6, f7 : T_Fraction;
begin
	f0 := (0,1);
	f1 := (1,1);
	f2 := (2,1);
	f3 := (3,1);
	f4 := (4,1);
	f5 := (5,1);
	f6 := (6,1);
	f7 := (7,1);

	p0.Coeff(0) := f1;

	p1.Coeff(0) := f1;
	p1.Coeff(1) := f2;
	
	p2.Coeff(0) := f3;
	p2.Coeff(1) := f2;

	p3.Coeff(0) := f1;
	p3.Coeff(1) := f3;
	p3.Coeff(2) := f0;
	p3.Coeff(3) := f4;

	Put(p1); put(" +"); Put(p3); put(" ="); Put(p3+p1); New_Line; New_Line;
	Put(p2); put(" -"); Put(p2); put(" ="); Put(p2-p2); New_Line; New_Line;
	Put(p3); put(" *"); Put(p2); put(" ="); Put(p3*p2); New_Line; New_Line;
	Put(p2); put(" *"); Put(f3); put(" ="); Put(p2*f3); New_Line; New_Line;
	Put("Evalue "); Put(p3); Put(" à"); put(f2); Put(" :"); Put(Eval(p3, f2)); New_Line; New_Line;
	Put("Division de "); put(p3); put(" par "); put(p1); put(" = "); put(p3/p1);New_Line; New_Line;
	Put("Reste de "); put(p3); put(" diviser par "); put(p1); put(" = "); put(Reste(p3,p1));New_Line; New_Line;
exception
	when Div_Par_Zero => Put("Division par zero !");
end Calcul_Polynomes;

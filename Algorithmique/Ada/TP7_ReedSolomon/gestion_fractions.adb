-- Code de Reed Solomon
-- Package body : Gestion Fraction
-- Cedric Dos Reis - 03.12.2017
-- Algorithmique

with Text_IO;                     use Text_IO;
WITH Ada.Command_Line;				USE Ada.Command_Line; 
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;

package body Gestion_Fractions is
	-- Lit la fraction entrée
	procedure Get(f: out T_Fraction) is
   begin
      get(f.Num);
      get(f.Den);
      Reduire(f);
   end;
	
	-- Affiche la fraction
	procedure Put(f : in T_Fraction) is
	begin
		Put(Integer'Image(f.num));
		Put(Integer'Image(f.den));
	end Put;

	-- Tranforme la fraction reçu en fraction irreductible
	procedure Reduire(f : in out T_Fraction) is
		pgcd : Integer := 1;
	begin
		-- verifie si la fraction n'est pas nul
		-- sinon reduit normalement la fraction
		if f.num /= 0 then
			pgcd := PGCDof(f.num, f.den);
			f.num := f.num / pgcd;
			f.den := f.den / pgcd;
		end if;
	end Reduire;

	---------- FONCTIONS ----------
	-- Somme de deux fraction, retourne une fraction irreductible
	function "+"(f1, f2 : T_Fraction) return T_Fraction is
		result : T_Fraction;
	begin
		Verifie(f1);
		Verifie(f2);
		result.num := f1.num * f2.den + f1.den * f2.num;
		result.den := f1.den * f2.den;
		Reduire(result);
		return result;
	end "+";

	-- Soustraction de deux fractions, retourne une fraction irreductible
	function "-"(f1, f2 : T_Fraction) return T_Fraction is
		result : T_Fraction;
	begin
		Verifie(f1);
		Verifie(f2);
		result.num := f1.num * f2.den - f1.den * f2.num;
		result.den := f1.den * f2.den;
		Reduire(result);
		return result;
	end "-";

	-- Multiplication de deux frcations, retourne une fraction irreductible
	function "*"(f1, f2 : T_Fraction) return T_Fraction is
		result : T_Fraction;
	begin
		Verifie(f1);
		Verifie(f2);
		result.num := f1.num * f2.num;
		result.den := f1.den * f2.den;
		Reduire(result);
		return result;
	end "*";

	-- Multiplication d'une fraction par un entier, retourne une fraction irreductible
	function "*"(f : T_Fraction; n: integer) return T_Fraction is
		result : T_Fraction;
	begin
		Verifie(f);
		result.num := f.num * n;
		result.den := f.den;
		Reduire(result);
		return result;
	end "*";
	
	-- Multiplication d'un entier par une fraction, retourne une fraction irreductible
	function "*"(n: Integer; f : T_Fraction) return T_Fraction is
	begin
		return f*n;
	end "*";

	-- Division de deux fractions, retourne une fraction irreductible
	function "/"(f1, f2 : T_Fraction) return T_Fraction is
		result : T_Fraction;
	begin
		Verifie(f1);
		Verifie(f2);
		result.num := f1.num * f2.den;
		result.den := f1.den * f2.num;
		Reduire(result);
		return result;		
	end "/";
	

	-- Division d'une fraction par un entier, retourne une fraction irreductible
	function "/"(f : T_Fraction; n : integer ) return T_Fraction is
		f2: T_Fraction;
	begin
		f2 := (n,1);
		return f/f2;
	end "/";

	-- Division d'un entier  par une fraction, retourne une fraction irreductible
	function "/"(n : Integer; f : T_Fraction ) return T_Fraction is
		f2: T_Fraction;
	begin
		f2 := (n,1);
		return f2/f;
	end "/";

	-- Met la fraction à une puissance entière, retourne une fraction irreductible
	function "**"(f : T_Fraction; n : integer ) return T_Fraction is
		result : T_Fraction;
	begin
		Verifie(f);
		result.num := f.num ** n;
		result.den := f.den ** n;
		Reduire(result);
		return result;
	end "**";

	-- Calcule (recursivement) le Plus Grand Commun Diviseur de deux nombres
	function PGCDof(n1, n2 : Integer) return Integer is
		a, b : Integer;
	begin 
		a := abs n1;
		b := abs n2;
		if b = 0 then
			return a; -- fin de recursivité
		elsif  a > b then 
			return PGCDof(b, a mod b);
		else
			return PGCDof(a, b mod a);
		end if;
	end PGCDof;

	-- Vérifie si la fraction n'a pas de division par 0
	procedure Verifie(f : T_Fraction) is
	begin
		if f.den = 0 then
			raise DIV_PAR_ZERO;
		end if;
	end Verifie;
end Gestion_Fractions;

-- Code de Reed Solomon
-- Package : Gestion Fraction
-- Cedric Dos Reis - 03.12.2017
-- Algorithmique

package Gestion_Fractions is
	DIV_PAR_ZERO : exception;
	
	type T_Fraction is record
		num : Integer := 0;
		den : Integer := 1;
	end record;
	
	procedure Get(f: out T_Fraction);
	procedure Put(f : T_Fraction);
	procedure Reduire(f : in out T_Fraction);

	function "+"(f1, f2 : T_Fraction) return T_Fraction;
	function "-"(f1, f2 : T_Fraction) return T_Fraction;
	function "*"(f1, f2 : T_Fraction) return T_Fraction;
	function "*"(f : T_Fraction; n: Integer) return T_Fraction;
	function "*"(n: Integer; f : T_Fraction) return T_Fraction;
	function "/"(f1, f2 : T_Fraction) return T_Fraction;
	function "/"(f : T_Fraction; n : Integer) return T_Fraction;
	function "/"(n : Integer; f : T_Fraction) return T_Fraction;
	function "**"(f : T_Fraction; n : Integer ) return T_Fraction;
	function PGCDof(n1, n2: Integer) return Integer;
	
	private
	procedure Verifie(f : T_Fraction);
end Gestion_Fractions;

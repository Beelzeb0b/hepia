-- Code de Reed Solomon
-- Package : Gestion Polynomes
-- Cedric Dos Reis - 03.12.2017
-- Algorithmique

with Gestion_Fractions; use Gestion_Fractions;

package Gestion_Polynomes is
	subtype T_Degre is Natural range 0..10000;
	type T_Coeff is array (T_Degre range<>) of T_Fraction;
	type T_Polynome(Degre : T_Degre := 0) is record
		Coeff : T_Coeff(0..Degre);
	end record;

	procedure Get(p : out T_Polynome);
	procedure Put(p : in  T_Polynome);

	function "+"(p1, p2 : T_Polynome) return T_Polynome;
	function "-"(p1, p2 : T_Polynome) return T_Polynome;
	function "*"(p1, p2 : T_Polynome) return T_Polynome;
	function "*"(p: T_Polynome; f : T_Fraction) return T_Polynome;
	function "*"(f : T_Fraction; p: T_Polynome) return T_Polynome;
	function "/"(dividende, diviseur : T_Polynome) return T_Polynome;
	function Reste(dividende, diviseur : T_Polynome) return T_Polynome;
	function Eval(p : T_Polynome; f : T_Fraction) return T_Fraction;
	function Alloc_Polyn(p : T_Polynome; n : T_Degre) return T_Polynome;
	function Reduit_Polyn(p : T_polynome) return T_Polynome;

end Gestion_Polynomes;

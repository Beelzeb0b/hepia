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
	-- Lit la fraction entr�e
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

	-- Tranforme la fraction re�u en fraction irreductible
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

	-- Met la fraction � une puissance enti�re, retourne une fraction irreductible
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
			return a; -- fin de recursivit�
		elsif  a > b then 
			return PGCDof(b, a mod b);
		else
			return PGCDof(a, b mod a);
		end if;
	end PGCDof;

	-- V�rifie si la fraction n'a pas de division par 0
	procedure Verifie(f : T_Fraction) is
	begin
		if f.den = 0 then
			raise DIV_PAR_ZERO;
		end if;
	end Verifie;
end Gestion_Fractions;



-- Code de Reed Solomon
-- Programme de test du paquet "Gestion_Fractions"
-- Cedric Dos Reis - 03.12.2017
-- Algorithmique

with Text_IO;                     use Text_IO;
WITH Ada.Command_Line;				USE Ada.Command_Line; 
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;
with Gestion_Fractions; use Gestion_Fractions;

Procedure Calcul_Fractions is
	f1, f2 :T_Fraction;
	n1 : Integer := Integer'Value(Argument(1));
	n2 : Integer;
	chaine : String := Argument(2);
	chaine2 : string := Argument(3);
begin
	case Argument_Count is 
      -- 3 arguments -> PGCD
		when 3 => 
			n2 := PGCDof(Integer'Value(Argument(1)), Integer'Value(Argument(2)));
			put(Integer'Image(n2));
      -- 4 arguments -> un entier, une fraction et un operateur
		when 4 =>
      -- L'entier est avant la fraction
		case chaine(1) is 
			when '/' => 
				f2 := (Integer'Value(Argument(3)), Integer'Value(Argument(4)));
				Put(n1 / f2);
			when 'x' => 
				f2 := (Integer'Value(Argument(3)), Integer'Value(Argument(4)));
				Put(n1 * f2);
			when others =>
				null;
		end case;
      -- La fraction est avant l'entier
		case chaine2(1) is 
			when '/' => 
				f1 := (Integer'Value(Argument(1)), Integer'Value(Argument(2)));
				Put(f1 / Integer'Value(Argument(4)));
			when 'x' => 
				f1 := (Integer'Value(Argument(1)), Integer'Value(Argument(2)));
				Put(f1 * Integer'Value(Argument(4)));
			when 'p' => 
				f1 := (Integer'Value(Argument(1)), Integer'Value(Argument(2)));
				Put(f1 ** Integer'Value(Argument(4)) );
			when others =>
				null;
		end case;
      -- 5 arguments -> 2 fractions et 1 operateur
		when 5 =>
		case chaine2(1)is 
			when '+' => 
				f1 := (Integer'Value(Argument(1)), Integer'Value(Argument(2)));
				f2 := (Integer'Value(Argument(4)), Integer'Value(Argument(5)));
				Put(f1 + f2);
			when '-' => 
				f1 := (Integer'Value(Argument(1)), Integer'Value(Argument(2)));
				f2 := (Integer'Value(Argument(4)), Integer'Value(Argument(5)));
				Put(f1 - f2);
			when '/' => 
				f1 := (Integer'Value(Argument(1)), Integer'Value(Argument(2)));
				f2 := (Integer'Value(Argument(4)), Integer'Value(Argument(5)));
				Put(f1 / f2);
			when 'x' => 
				f1 := (Integer'Value(Argument(1)), Integer'Value(Argument(2)));
				f2 := (Integer'Value(Argument(4)), Integer'Value(Argument(5)));
				Put(f1 * f2);
			when others =>
				null;
		end case;
			when others =>
				null;
	end case;
exception
	-- divison par 0
	when DIV_PAR_ZERO => Put_line("Division par 0.");
end Calcul_Fractions;


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



-- Code de Reed Solomon
-- Package body : Gestion Polynomes
-- Cedric Dos Reis - 03.12.2017
-- Algorithmique

with Text_IO; use Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Gestion_Fractions; use Gestion_Fractions;

package body Gestion_Polynomes is
	---------- PROCEDURES ----------
	procedure Get(p : out T_Polynome) is
	begin
		for i in 0..p.Degre loop
         Get(p.Coeff(i).Num);
         Get(p.Coeff(i).Den);
      end loop;
	end Get;
	
	-- affiche un polynome
	procedure Put(p : in T_Polynome) is
	begin
		for I in 0..p.Degre loop
			Put(p.Coeff(i));
		end loop;
	end Put;

	---------- FONCTIONS ----------
	-- Addition de deux polynomes
	function "+"(p1, p2 : T_Polynome) return T_Polynome is
		result : T_Polynome(Integer'Max(p1.Degre, p2.Degre));
	begin
		if p1.Degre < p2.Degre then
			return p2+p1;
		elsif p1.Degre > p2.Degre then
			-- Additionne les coefficient de meme degre
			for i in 0..p2.Degre loop
				result.Coeff(i) := p1.Coeff(i) + p2.Coeff(i);
			end loop;
			-- Ajoute le reste du polynome au resultat
			for j in p2.Degre+1..p1.Degre loop
				result.Coeff(j) := p1.Coeff(j);
			end loop;
		else
			for i in 0..p1.Degre loop
				result.Coeff(i) := p1.Coeff(i) + p2.Coeff(i);
			end loop;
		end if;
		return Reduit_Polyn(result);
	end "+";
	
	-- Soustraction de deux polynomes
	function "-"(p1, p2 : T_Polynome) return T_Polynome is
		result : T_Polynome(Integer'Max(p1.Degre, p2.Degre));
	begin
		-- le polynome p1 doit etre avoir un degre egale ou sup�rieur au degr� de p2
		if p1.Degre < p2.Degre then
			return p2-p1;
		elsif p1.Degre > p2.Degre then
			-- soustrait les coefficient dont le degre est identique
			for I in 0..p2.Degre loop
				result.Coeff(I) := p1.Coeff(I) - p2.Coeff(I);
			end loop;
			
			-- Ajoute au polynome les coefficients qui n'ont pas de pair
			for J in p2.Degre+1..p1.Degre loop
				result.Coeff(J) := p1.Coeff(J);
			end loop;
		else
			-- polynomes de meme degr�
			for i in 0..p1.Degre loop
				result.Coeff(i) := p1.Coeff(i) - p2.Coeff(i);
			end loop;
		end if;
		return Reduit_Polyn(result);
	end "-";
	
	-- Multiplication de deux polynomes
	function "*"(p1, p2 : T_Polynome) return T_Polynome is
		produit : T_Polynome(p1.Degre+p2.Degre);
	begin
		produit.Coeff := (others => (0,1));
		for I in 0..p1.Degre loop
			for J in 0..p2.Degre loop
				produit.Coeff(I+J) := produit.Coeff(I+J) +  (p1.Coeff(I) * p2.Coeff(J));
			end loop;
		end loop;
		return produit;
	end "*";
	
	-- Multiplication d'un polynome par une fraction
	function "*"(p: T_Polynome; f : T_Fraction) return T_Polynome is
		produit : T_Polynome(p.Degre);
	begin
		for i in 0..p.Degre loop
			produit.Coeff(i) := p.Coeff(i) * f;
		end loop;
		return Reduit_Polyn(produit);
	end "*";
	
	-- Multiplication d'une fraction par un polynome
	function "*"(f : T_Fraction; p: T_Polynome) return T_Polynome is
	begin
		return p*f;
	end "*";

	-- Division de deux polynomes, retourne le quotient
	function "/"(dividende, diviseur : T_Polynome) return T_Polynome is
		quotient : T_Polynome(abs (dividende.Degre - diviseur.Degre));
		newDividende : T_Polynome;
	begin
		-- Impossible de diviser le dividende si le diviseur � un degr� plus grand
		if dividende.Degre >= diviseur.Degre then
			-- divise le coeff de degre sup du dividende par le coeff de degre superieur du diviseur
			quotient.Coeff(dividende.Degre - diviseur.Degre) := dividende.Coeff(dividende.Degre) / diviseur.Coeff(diviseur.Degre);
			-- Calcul le nouveau dividende au format reduit
			newDividende := Reduit_Polyn(dividende - (diviseur * quotient));
			-- recomence la division avec le nouveau dividende
			return quotient + (newDividende / diviseur); -- recursif
		else
			return Reduit_Polyn(quotient);-- retourne un polynome dont tous les coefficient sont � 0/1
		end if;
	end "/";

	-- Calcule le reste de la division de deux polynomes
	function Reste(dividende, diviseur : T_Polynome) return T_Polynome  is
		reste, quotient: T_Polynome;
	begin
		-- calcul le quotient de la division de deux polynomes
		quotient := dividende / diviseur; 
		reste := Reduit_Polyn(dividende - (quotient * diviseur));
		return reste;
	end Reste;

	-- Evalue un polynome sur une fraction
	function Eval(p : T_Polynome; f : T_Fraction) return T_Fraction is
		result : T_Fraction;
	begin
		result := p.Coeff(0);
		-- la boucle commence � 1 car le premier co�fficient de degr� 0 n'est pas evalu�
		for i in 1..p.Degre loop
			result := result + (p.Coeff(i) * (f**i));
		end loop;
		return result;
	end Eval;

	-- Retourne le polynome de degre n dont les coeff sont tous � 0/1
	function Alloc_Polyn(p : T_Polynome; n :  T_Degre) return T_Polynome is
		result : T_Polynome(n);
	begin
		return result;
	end Alloc_Polyn;

	-- Reduit le polynome jusqu'au premier coefficient diff�rent de 0
	-- EXEMPLE : 0x�+2x�+0x+1 -> 2x�+0x+1
	function Reduit_Polyn(p : T_polynome) return  T_Polynome is
		reduit : T_polynome(Integer'Max(0, p.Degre-1));
	begin
		if p.Degre /= 0 and then p.Coeff(p.Degre).num = 0 then
			-- Transfere les coefficient du polynome dans un nouveau polynome de degre-1
			for I in 0..reduit.Degre loop
				reduit.Coeff(I) := p.Coeff(I);
			end loop;
			if reduit.Degre = 0 then
				return reduit; -- ce polynome est reduit au max 
			else
				return Reduit_Polyn(reduit); 
			end if;
		else
			return p; --le polynome re�u n'a pas besoin d'etre reduit
		end if;
	end Reduit_Polyn;
end Gestion_Polynomes;



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
	Put("Evalue "); Put(p3); Put(" �"); put(f2); Put(" :"); Put(Eval(p3, f2)); New_Line; New_Line;
	Put("Division de "); put(p3); put(" par "); put(p1); put(" = "); put(p3/p1);New_Line; New_Line;
	Put("Reste de "); put(p3); put(" diviser par "); put(p1); put(" = "); put(Reste(p3,p1));New_Line; New_Line;
exception
	when Div_Par_Zero => Put("Division par zero !");
end Calcul_Polynomes;

-- Code de Reed Solomon
-- Cedric Dos Reis - 11.12.2017
-- Algorithmique

with Text_IO;                     use Text_IO;
WITH Ada.Command_Line;				USE Ada.Command_Line; 
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;
with Gestion_Fractions; use Gestion_Fractions;
with Gestion_Polynomes; use Gestion_Polynomes;

Procedure Reed_Solomon is

	data, total, parity : Integer := 0;
	
	subtype T_Octet is Natural range 0..255;
	type T_Point is record
		x : Integer := 0;
		y : T_Octet := 0;
	end record;
	type T_Points is array(Integer range<>) of T_Point ;
	
	function Produit return T_Polynome is
		polynome : T_Polynome;
	begin
		return polynome;
	end Produit;
	
	function Interpolate(points : T_Points) return T_Polynome is 
		polynome : T_Polynome;
	begin
		return polynome;
	end Interpolate;
begin 
	-- REMARQUE : �nonc� pas tr�s compr�hensible
	
	--polynome := Interpolate(points);
	--Put(polynome);

end Reed_Solomon;
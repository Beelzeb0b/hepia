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
		-- le polynome p1 doit etre avoir un degre egale ou supérieur au degré de p2
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
			-- polynomes de meme degré
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
		-- Impossible de diviser le dividende si le diviseur à un degré plus grand
		if dividende.Degre >= diviseur.Degre then
			-- divise le coeff de degre sup du dividende par le coeff de degre superieur du diviseur
			quotient.Coeff(dividende.Degre - diviseur.Degre) := dividende.Coeff(dividende.Degre) / diviseur.Coeff(diviseur.Degre);
			-- Calcul le nouveau dividende au format reduit
			newDividende := Reduit_Polyn(dividende - (diviseur * quotient));
			-- recomence la division avec le nouveau dividende
			return quotient + (newDividende / diviseur); -- recursif
		else
			return Reduit_Polyn(quotient);-- retourne un polynome dont tous les coefficient sont à 0/1
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
		-- la boucle commence à 1 car le premier coéfficient de degré 0 n'est pas evalué
		for i in 1..p.Degre loop
			result := result + (p.Coeff(i) * (f**i));
		end loop;
		return result;
	end Eval;

	-- Retourne le polynome de degre n dont les coeff sont tous à 0/1
	function Alloc_Polyn(p : T_Polynome; n :  T_Degre) return T_Polynome is
		result : T_Polynome(n);
	begin
		return result;
	end Alloc_Polyn;

	-- Reduit le polynome jusqu'au premier coefficient différent de 0
	-- EXEMPLE : 0x³+2x²+0x+1 -> 2x²+0x+1
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
			return p; --le polynome reçu n'a pas besoin d'etre reduit
		end if;
	end Reduit_Polyn;
end Gestion_Polynomes;

-- Fichier     : gestion_fractions.ads
-- Auteur      : Ivan PEREZ
-- Version     : 1.0
-- Description : Déclarations des fonctions et procédures du paquetage gestion_fractions
package Gestion_Fractions is
   
   -- Type permettant de stocker une fraction sous forme de numérateur et de dénominateur
   type T_Fraction is record
     Num : integer:= 0;
	  Den : Positive:= 1;
   end record;
   
   procedure Get(F: out T_Fraction);
   procedure Put(F : in T_Fraction);
   function Absolute(N: integer) return positive;
   function PGCD(a, b: integer) return positive;
   procedure Reduire(F: in out T_Fraction);

   function "+"(F1,F2 : T_Fraction) return T_Fraction;
   function "+"(N: Integer; F2 : T_Fraction) return T_Fraction;
   function "+"(F2 : T_Fraction; N: Integer) return T_Fraction;

   function "-"(F1,F2 : T_Fraction) return T_Fraction;
   function "-"(N:integer;F: T_Fraction) return T_Fraction;
   function "-"(F: T_Fraction; N:integer) return T_Fraction;

   function "*"(F1,F2 : T_Fraction) return T_Fraction;
   function "*"(F1 : T_Fraction; N: integer) return T_Fraction;
   function "*"(N: integer; F1 : T_Fraction) return T_Fraction;

   function "**"(F: T_Fraction; N: Integer) return T_Fraction;

   function "/"(F1,F2 : T_Fraction) return T_Fraction;
   function "/"(N:Integer;F : T_Fraction) return T_Fraction;
   function "/"(F : T_Fraction; N: integer) return T_Fraction;
   
   DIV_PAR_ZERO : exception;
   
end Gestion_Fractions;

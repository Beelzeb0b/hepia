-- fichier     : gestion_polynomes.ads
-- Auteur      : Ivan PEREZ
-- Version     : 1.0
-- Description : Déclarations des fonctions et procédures du paquetage gestion_polynomes

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Gestion_Fractions; use Gestion_Fractions;
package Gestion_Polynomes is
   
   -- Type permettant de stocker le degré d'un polynome
   subtype T_Degre is Natural range 0..1000;
   -- Tableau de fractions pour stocker les coefficiants fractionnaires des polynomes
   type T_Coeff is array(T_Degre range <>)of T_Fraction ;
   
   -- le type polynome a coefficiants fractionnaires
   type T_Polynome(Degre : T_Degre := 0) is record
      Coeff : T_Coeff(0..Degre);
   end record;
   
   procedure Get(F: out T_Polynome);
   procedure Put(F : in T_Polynome);
   
   function Reste(P1,P2 : T_Polynome) return T_Polynome;
   function CalcDegre(P: T_Polynome) return Integer;
   function Reduire(P: T_Polynome) return T_Polynome;
   function "+"(P1,P2 : T_Polynome) return T_Polynome;
   function "-"(P1,P2 : T_Polynome) return T_Polynome;
   function "/"(P1,P2: T_Polynome) return T_Polynome;
   function "*"(P : T_Polynome; F: T_Fraction) return T_Polynome;
   function "*"(F: T_Fraction; P : T_Polynome) return T_Polynome;
   function "*"(P1,P2 : T_Polynome) return T_Polynome;
   function Alloc_Polyn(Degre: T_Degre) return T_Polynome;
   function Eval (P1: T_Polynome; F1: T_Fraction) return T_Fraction;
   
end Gestion_Polynomes;

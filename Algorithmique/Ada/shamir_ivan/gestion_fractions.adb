-- Fichier     : gestion_fractions.adb
-- Auteur      : Ivan PEREZ
-- Version     : 1.0
-- Description : Paquetage permettant d'implémenter et de gérer le type fractions.

with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Gestion_Fractions is
   
   -- Procédure de récupération de fraction par l'utilisateur
   procedure Get(F: out T_Fraction) is
   begin
      get(F.Num);
      get(F.Den);
      Reduire(F);
   end;
   -- Procédure d'affichage de fraction
   procedure Put(F : in T_Fraction) is
   begin
      put(integer'image(F.Num) & "/" & integer'image(F.Den));
   end;

   -- Renvoie la valeur absolue de l'entier donné en paramètres
   function Absolute(N: integer) return positive is
   NAbs: positive;
   begin
      if N < 0 then
         NAbs:= 0 - n;
      end if;
      return NAbs;
   end;

   -- retourne le PGCD des 2 entiers donnés en paramètres
   function PGCD(a, b: integer) return positive is
   begin
      if b = 0 then
         return a;
      else 
         return PGCD(b, a mod b); 
      end if;
   end;
   
   -- Réduit la fraction donnée en paramètres
   procedure Reduire(F: in out T_Fraction) is
      PGCDF : Positive := PGCD(F.Num, F.Den);
   begin
      if PGCDF /= 0 then
         F.Num:= F.Num/PGCDF;
         F.Den:= F.Den/PGCDF;
      end if;
   end;
   
   -- Opérateur + effectuant l'addition de 2 fractions
   function "+"(F1,F2 : T_Fraction) return T_Fraction is
      fraction : T_Fraction;
   begin
      fraction.Num:= (F1.Num * F2.Den) + (F2.Num * F1.Den);
      fraction.Den:= F1.Den * F2.Den;
      Reduire(fraction);
      return fraction;
   end;

   -- Opérateur + effectuant l'addition d'un entier et d'une fraction
   function "+"(N: Integer; F2 : T_Fraction) return T_Fraction is
      fraction : T_Fraction;
   begin
      fraction.Num:= (N * F2.Den) + (F2.Num * N);
      fraction.Den:= N * F2.Den;
      Reduire(fraction);
      return fraction;
   end;

   -- Opérateur + effectuant l'addition d'une fraction et d'un entier
   function "+"( F2 : T_Fraction; N: Integer) return T_Fraction is
      fraction : T_Fraction;
   begin
      fraction.Num:= (N * F2.Den) + (F2.Num * N);
      fraction.Den:= N * F2.Den;
      Reduire(fraction);
      return fraction;
   end;
   
   -- opérateur - effectuant la soustraction de 2 fractions
   function "-"(F1,F2 : T_Fraction) return T_Fraction is
      fraction : T_Fraction;
   begin
      fraction.Num:= (F1.Num * F2.Den) - (F2.Num * F1.Den);
      fraction.Den:= F1.Den * F2.Den;
      Reduire(fraction);
      return fraction;
   end;

    -- Opérateur - effectuant la soustraction d'un entier et d'une fraction
   function "-"(N: Integer;F : T_Fraction) return T_Fraction is
      fraction : T_Fraction;
   begin
      fraction.Num:= (N*F.Den) - F.Num;
      fraction.Den:= F.Den;
      Reduire(fraction);
      return fraction;
   end;

   -- Opérateur - effectuant la soustraction d'une fraction et d'un entier
   function "-"(F : T_Fraction; N: Integer) return T_Fraction is
      fraction : T_Fraction;
   begin
      fraction.Num:= F.Num - (N*F.Den);
      fraction.Den:= F.Den;
      Reduire(fraction);
      return fraction;
   end;

   -- opérateur * effectuant la multiplication de 2 fractions
   function "*"(F1,F2 : T_Fraction) return T_Fraction is
      Fraction: T_Fraction;
   begin
      fraction.num:= F1.num * F2.num;
      fraction.den:= F1.den * F2.den;
      Reduire(Fraction);
      return Fraction;
   end;
   
   -- Opérateur  effectuant la multiplication d'une fraction et d'un entier
   function "*"(F1 : T_Fraction; N: integer) return T_Fraction is
   begin
      return T_Fraction'(F1.Num*N,F1.Den);
   end;

   -- Opérateur * effectuant la multiplication d'un entier et d'une fraction
   function "*"(N: integer; F1 : T_Fraction) return T_Fraction is
   begin
      return T_Fraction'(F1.Num*N,F1.Den);
   end;

   -- Opérateur ** retournant la fraction donnée en paramètre élevée
   -- à la puissance N donnée en paramètre
   function "**"(F: T_Fraction; N: Integer) return T_Fraction is
      FOut: T_Fraction;
   begin
      for i in 1..N - 1 loop
         FOut:= FOut + (F * N);
      end loop; 
      Reduire(FOut);    
      return FOut;
   end;

   -- Opérateur / effectuant la division de 2 fractions
   function "/"(F1,F2 : T_Fraction) return T_Fraction is
      F1Temp, F2Temp: T_Fraction;
   begin
      F1Temp:= F1;
      F2Temp:= F2;
      if F2Temp.Num = 0 then
         raise DIV_PAR_ZERO;
      end if;
      -- Si le Numérateur de F2 est négatif, on le rend positif puis on inverse le signe de F1
      -- afin d'éviter d'avoir un dénominateur négatif
      If F2Temp.Num < 0 then
         F2Temp.Num:= F2Temp.Num * (-1);
         F1Temp.Num := F1Temp.Num * (-1);
      end if;
      return T_Fraction'(F1Temp.Num*F2Temp.Den,F1Temp.Den*F2Temp.num);
   end;
   -- opérateur / effectuant la division d'un entier par une fraction 
   function "/"(N: integer; F : T_Fraction) return T_Fraction is
   begin
      if F.Num = 0 then
         raise DIV_PAR_ZERO;
      end if;
      return T_Fraction'(F.Den*N,F.Num*N);
   end;
   -- Opérateur / effectuant la division d'une fraction par un entier
   function "/"(F : T_Fraction; N: integer) return T_Fraction is
   begin
      if N = 0 then
         raise DIV_PAR_ZERO;
      end if;
      return T_Fraction'(F.Num*N,F.Den*N);
   end;
   
   -- Exception division par 0
   DIV_0 : exception;
end Gestion_Fractions;

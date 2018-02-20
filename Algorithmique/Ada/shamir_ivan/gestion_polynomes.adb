-- Fichier     : gestion_polynomes.adb
-- Auteur      : Ivan PEREZ
-- Version     : 1.0
-- Description : Paquetage permettant d'implémenter et de gérer le type polynome.

with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Gestion_Fractions; use Gestion_Fractions;
package body Gestion_Polynomes is
   
   -- fonction retournant le plus grand des 2 entiers donnés en paramètres
   function Max(N,M : integer) return integer is
   begin
      if N>M then
	     return N;
	  else 
	     return M;
      end if;
   end;
   
   -- procédure de récupération d'un polynome par l'utilisateur
   procedure Get(F: out T_Polynome) is
   begin
      for i in 0..F.Degre loop
         Get(F.Coeff(i).Num);
         Get(F.Coeff(i).Den);
      end loop;
   end;
   
   --procédure d'affichage d'un polynome
   procedure Put(F : in T_Polynome)is
   begin
      for i in 0..F.Degre loop
         Put(F.Coeff(i));
      end loop;
   end;
   
   -- procédure permettant de calculer le degré d'un polynome après l'avoir réduit
   function CalcDegre(P: T_Polynome) return Integer is
      Degre: integer:= 0;
   begin
      for i in 0..P.Degre loop
         if P.Coeff(i).Num /= 0 then
            Degre:= 0;
         else
            Degre:= Degre + 1;
         end if;
      end loop;
      Degre:= P.Degre - Degre;
      if Degre < 0 then
         return 0;
      else  
         return Degre;
      end if;
   end;

   -- fonction permettant de réduire le degré d'un polynome dans le cas ou il aurait ses derniers coefficiants a 0
   function Reduire(P: T_Polynome) return T_Polynome is
      PReduit: T_Polynome(CalcDegre(P));
   begin
      for i in 0..PReduit.Degre loop
         PReduit.Coeff(i):= P.Coeff(i);
      end loop;
      return PReduit;
   end;
  
   --opérateur + effectuant l'addition de 2 polynomes
   function "+"(P1,P2 : T_Polynome) return T_Polynome is
      pMax: T_Polynome(max(P1.Degre, P2.Degre));
   begin
      for i in 0..PMax.Degre loop
         if i > P1.Degre then
            PMax.Coeff(i):= P2.Coeff(i);
         elsif i > P2.Degre then
            PMax.Coeff(i):= P1.Coeff(i);
         else
            PMax.Coeff(i):= P1.Coeff(i) + P2.Coeff(i);
         end if;
      end loop;
	   return PMax;
   end;
   
   -- opérateur / effectuant la division de 2 polynomes
   function "-"(P1,P2 : T_Polynome) return T_Polynome is
      pMax: T_Polynome(max(P1.Degre, P2.Degre));
   begin
      for i in 0..PMax.Degre loop
         if i > P1.Degre then
            PMax.Coeff(i):= P2.Coeff(i);
         elsif i > P2.Degre then
            PMax.Coeff(i):= P1.Coeff(i);
         else
            PMax.Coeff(i):= P1.Coeff(i) - P2.Coeff(i);
         end if;
      end loop;
	   return PMax;
   end;
   
   -- opérateur * effectuant la multiplication de 2 polynomes
   function "*"(P1,P2 : T_Polynome) return T_Polynome is
      POut: T_Polynome(P1.Degre + P2.Degre);
   begin
      for i in 0..P1.Degre loop
         for j in 0..P2.Degre loop
            POut.Coeff(i+j):= POut.Coeff(i+j) + (P1.Coeff(i) * P2.Coeff(j));   
         end loop;
      end loop;
	   return POut;
   end;
   
   -- opérateur / effectuant la division polynomiale de 2 polynomes et retournant le résultat 
   function "/"(P1,P2 : T_Polynome) return T_Polynome is
      PProduit: T_Polynome(P1.Degre);
      PReste: T_Polynome(P1.Degre);
      PResultat: T_Polynome(P1.Degre);
      DegreReste: Integer;
   begin
      DegreReste:= P1.Degre;
      PReste:= P1;
      -- Si le Degré du Reste est plus petit que le degré du diviseur ET que le degré 
      -- du diviseur est plus grand que 0 alors on a fini la division
      while (DegreReste >= P2.Degre) loop
         PResultat.Coeff(DegreReste - P2.Degre):= PReste.Coeff(DegreReste) / P2.Coeff(CalcDegre(PReste) - DegreReste);
         Reduire(PResultat.Coeff(DegreReste - P2.Degre));
         PProduit:= Reduire(PResultat * P2);
         PReste:= P1 - PProduit;     
         -- Si le degré du diviseur est égal à 0 alors il faut un autre moyen de sortir de la boucle    
         if (DegreReste = 0) and (P2.Degre = 0) then
            DegreReste:= -1;
         else
            DegreReste:= CalcDegre(PReste);   
         end if;
      end loop;
      Return PResultat;
   end;
   
   -- function effectuant la division polynomiale de 2 polynomes et retournant le reste
   function Reste(P1,P2 : T_Polynome) return T_Polynome is
      PProduit: T_Polynome(P1.Degre);
      PReste: T_Polynome(P1.Degre);
      PResultat: T_Polynome(P1.Degre);
      DegreReste: Integer;
   begin
      DegreReste:= P1.Degre;
      PReste:= P1;
      -- Si le Degré du Reste est plus petit que le degré du diviseur ET que le degré 
      -- du diviseur est plus grand que 0 alors on a fini la division
      while (DegreReste >= P2.Degre) loop
         PResultat.Coeff(DegreReste - P2.Degre):= PReste.Coeff(DegreReste) / P2.Coeff(CalcDegre(PReste) - DegreReste);
         PProduit:= Reduire(PResultat * P2);
         PReste:= P1 - PProduit;
         -- Si le degré du diviseur est égal à 0 alors il faut un autre moyen de sortir de la boucle    
         if (DegreReste = 0) and (P2.Degre = 0) then
            DegreReste:= -1;
         else
            DegreReste:= CalcDegre(PReste);   
         end if;
      end loop;
      Return PReste;
   end;   

   -- opérateur * multipliant une fraction par un polynome
   function "*"(P : T_Polynome; F: T_Fraction) return T_Polynome is
      POut: T_Polynome(P.Degre);
   begin
      for i in 0..POut.Degre loop
         POut.Coeff(i):= F * P.Coeff(i);
      end loop;   
	   return POut;
   end;

   -- opérateur * multipliant un polynome par une fraction   
   function "*"(F: T_Fraction; P : T_Polynome) return T_Polynome is
      POut: T_Polynome(P.Degre);
   begin
      for i in 0..POut.Degre loop
         POut.Coeff(i):= F * P.Coeff(i);
      end loop;   
	   return POut;
   end;

   -- Function permettant d'allouer un polynome égal a x^Degre 
   function Alloc_Polyn(Degre: T_Degre) return T_Polynome is
      pol: T_Polynome(Degre);
   begin
      pol.Coeff(Degre).num:= 1;
      pol.Coeff(Degre).den:= 1;
      Return Pol;
   end;

   -- Fonction permettant d'évaluer un polynome en 1 point selon la méthode de horner
   function Eval (P1: T_Polynome; F1: T_Fraction) return T_Fraction is
      B: T_Fraction;
      P2, P3: T_Polynome;
   begin
      P2:= Reduire(P1);
      if P2.Degre >= 1 then
         B:= P2.Coeff(P2.Degre);
         P2.Coeff(P2.Degre):= (0,1);
         P3:= Reduire(P2);
         P3.Coeff(P3.Degre):= P3.Coeff(P3.Degre) + F1 * B;
         Return Eval(P3, F1);
      else
         Return P1.Coeff(P1.Degre);
      end if;
   end;
   
end Gestion_Polynomes;

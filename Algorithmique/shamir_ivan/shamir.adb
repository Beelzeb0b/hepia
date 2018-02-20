-- Fichier     : shamir.adb
-- Auteur      : Ivan PEREZ
-- Version     : 1.0
-- Description : Mise en pratique du partage de la clé secrète de shamir
--               avec des polynomes à coefficiants fractionnaires

with gestion_polynomes; use gestion_polynomes;
with gestion_fractions; use gestion_fractions;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with text_IO; use Text_IO;
with Ada.Command_line; use Ada.Command_Line;
with Ada.Numerics.Float_Random; use Ada.Numerics.Float_Random;
with Ada.Command_line; use Ada.Command_Line;

procedure shamir is

   -- Type permettant de stocker les coordonnées d'un point 2D
   type T_Point2D is record
      X,Y: T_Fraction;
   end record;

   -- Tableau de type T_Point2D
   type T_Points is array (Positive range <>) of T_Point2D ;
   S: T_Fraction;
   N: Positive;
   PSecret: T_Polynome;
   Cle: T_Point2D;
   Gen: generator;
   ValMax: Integer:= 2000;
   Choix: Natural:= 0;
   Compteur: Positive:= 1;
   CLes2: T_Points(1..2);
   Pol: T_Polynome;
   J: Integer:= 0;
   Fini: Boolean:= False;
   
   -- Fonction retournant un polynome de degré N-1, dont tous les degrés sauf la constante (degré 0)
   -- sont aléatoire et la constante est égale à la clé secrète
   function polynome_secret(N: integer; S: T_Fraction) return T_Polynome is
      P: T_Polynome(N-1);
   begin
      P.Coeff(0):= S;
      for I in 1..P.Degre loop
         P.Coeff(I).Num:= integer((Random(Gen) * Float(ValMax + 1)) - 0.5);
      end loop;
      return P;
   end polynome_secret;

   -- Fonction générant des clés partielles du polynome secret   
   function cle_partielle(PSecret: T_Polynome;Compteur: Natural) return T_Point2D is
      PX: T_Fraction:= (Compteur,1);
   begin
      -- On évalue en le résultat en y du point x
      return T_Point2D'(PX,eval(PSecret,PX));
   end;

   -- Fonction retournant le diviseur du produit de points pour la fonction interpolate
   function ProduitDiv(Points: T_Points; F: T_Fraction) return T_Polynome is
      Pol: T_Polynome;
      P0: T_Polynome;
   begin
      if Points'Length >= 1 then
         Pol:= Alloc_Polyn(0);
         P0:=  Alloc_Polyn(0) * F;
         Pol.Coeff(0):= Points(Points'First).X;
         P0:= P0 - Pol;
         return P0 * ProduitDiv(Points(Points'First + 1..Points'Last), F);
      end if;
      return T_Polynome'(0, (0 => (1,1))); 
   end;
   -- Fonction retournant le produit de plusieurs points pour la fonction interpolate
   function Produit(Points: T_Points) return T_Polynome is
      Pol: T_Polynome;
      PX: T_Polynome;
   begin
      if Points'Length >= 1 then
         Pol:= Alloc_Polyn(0);
         -- On alloue un polynome x
         PX:=  Alloc_Polyn(1);
         -- On stocke la valeur X du point à traiter
         Pol.Coeff(0):= Points(Points'First).X;
         -- Puis on la soustrait au polynome x
         PX:= PX - Pol;
         -- On multiplie PX par l'appel récursif postérieur à cette instruction
         return PX * Produit(Points(Points'First + 1..Points'Last));
      end if;
      -- Retourne un polynome de dégré 0 et valant 1/1 pour la dernière étape de récursivité
      return T_Polynome'(0, (0 => (1,1))); 
   end;
   
   -- fonction retournant le polynome d'interpolation de lagrange en fonction d'un tableau de points
   function Interpolate(Points: T_Points) return T_Polynome is
    PointsCourants: T_Points(1..Points'Last - 1);
    Compteur: Integer:= 1;
    Pol: T_Polynome(Points'Length);
    -- XCourant : le point en X a donner a ProduitDiv pour calculer le diviseur Ex : (XCourant - a1) * (XCourant - a2)... 
    XCourant: T_Fraction;
   begin
      for I in 1..Points'Last loop
         Compteur:= 1;
         for J in 1..Points'Last loop
            
            if J /= I then
               PointsCourants(Compteur):= Points(J);
               Compteur:= Compteur + 1;
            -- Si J = I alors c'est le point à ne pas traiter pour le produit
            else
               -- On stocke X du points a ne pas traiter
               XCourant:= Points(J).X;
            end if;
         end loop;
         Pol:= Pol + Points(I).Y * (Produit(PointsCourants) / ProduitDiv(PointsCourants, XCourant));
      end loop;  
      return Reduire(Pol);
   end;   
begin
   -- S'il n'y a pas d'arguments on lance la partie interactive
   if Argument_Count = 0 then
      Fini:= False;
      reset(Gen);
      put("Nombre minimum de clés partielles nécéssaires à la résolution :");
      get(N);
      -- On génère la clé secrète et le polynome secrèt
      S.Num := integer((Random(Gen) * Float(ValMax + 1)) - 0.5);
      put(polynome_secret(N,S));
      PSecret:= polynome_secret(N,S);

      -- Boucle principale du programme
      while Fini = false loop
      new_line;
      Put("Action (0. Nouvelle clé / 1. Entrer les clés / 2. Quitter): ");
      Get(Choix);
      case Choix is
         -- On génére une clé partielle
         when 0 =>
            Cle:= cle_partielle(PSecret,Compteur);
            put(cle.X);
            put(cle.Y);
            Compteur:= Compteur +1;
         -- On entre les clés partielles
         when 1 => null;
            declare
               Cles: T_Points(1..N);
            begin
               for I in 1..N loop
                  Put("entrez une clé :");
                  Get(Cle.X);
                  Get(Cle.Y);
                  Cles(I):= Cle;
               end loop;
                  -- On calcule le polynome d'interpolation avec les clés rentrées
                  Pol:= Interpolate(Cles);
                  if Pol = PSecret then
                     Put("La clé secrète est : ");
                     Put(S);           
                     Fini:= True;          
                  else
                     Put("Les clés partielles ne sont pas justes");
                  end if;
            end;
         -- Si l'utilisateur souhaite quitter le programme
         when 2 =>
            Fini:= True;
         when others => Put("Choix indéfini!");
      end case;
      
      end loop;
   -- Sinon on lance le mode par ligne de commande
   else
      declare
         Cles: T_Points(1..Argument_Count / 2);
      begin
         J:= 1;
         for I in 1..Argument_Count / 2 loop
            J:= I*2 - 1;
            Cles(I).X:= (Integer'Value(Argument(J)), 1);
            Cles(I).Y:= (Integer'Value(Argument(J + 1)), 1);
         end loop;
         Put(Interpolate(Cles));
      end;
   end if;
exception
   when DIV_PAR_ZERO => put("Division par zero!");
   when CONSTRAINT_ERROR => put("pas de dénominateur zero!");
end shamir;

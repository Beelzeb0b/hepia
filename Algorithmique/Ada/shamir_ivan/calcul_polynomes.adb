-- Fichier     : calcul_polynomes.adb
-- Auteur      : Ivan PEREZ
-- Version     : 1.0
-- Description : Programme de test du paquetage gestion_polynomes

with Gestion_Fractions; use Gestion_Fractions;
with Gestion_Polynomes; use Gestion_Polynomes;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_line; use Ada.Command_Line;


procedure calcul_polynomes is
   Compteur: Integer:= 1;
   J: Integer:= 1;
   Pol1: T_Polynome(2);
   Pol2: T_Polynome(0);
   operator: character;
   SwitchPol: Boolean:= False;
   -- Fonction permettant de savoir si N est un entier
   function EstUnNombre(N : in String) return Boolean is
      Temp : Integer;
   begin
      Temp := Integer'Value (N);
      return True;
   exception
      when others =>
         return False;
   end EstUnNombre;

begin
   -- S'il y a des arguments
   if Argument_Count /= 0 then
      SwitchPol:= False;
	   for I in 1..Argument_Count / 2 loop
         J:= I*2-1;
         Put(J);
         -- Si un opérateur est trouvé
         if EstUnNombre(Argument(J)) = False then
            -- On réinitialise le compteur de degré et on stocke l'opérateur
            Compteur:= 1;
            Operator:= Argument(J)(1);
            SwitchPol:= True;
            -- On met déjà les coefficiants suivant sinon un décalage est créé à cause du J:= I*2-1
            Pol2.Coeff(compteur - 1).Num:= Integer'Value(Argument(J+1));
            Pol2.Coeff(compteur - 1).Den:= Integer'Value(Argument(J+2));
         else
            if SwitchPol = False then
               Pol1.Coeff(Compteur - 1).Num:= Integer'Value(Argument(J));
               Pol1.Coeff(Compteur - 1).Den:= Integer'Value(Argument(J+1));
            -- J est décalé à cause de l'opérateur
            else
               Pol2.Coeff(Compteur - 1).Num:= Integer'Value(Argument(J+1));
               Pol2.Coeff(Compteur - 1).Den:= Integer'Value(Argument(J+2));  
            end if;
         end if; 
         -- On incrémente le compteur
         Compteur:= Compteur + 1;   
      end loop;

      Case operator is
         when '+' =>
            Put(Reduire(Pol1 + Pol2));
         when '-' =>
            Put(Reduire(Pol1 - Pol2));
         when 'x' =>
            Put(Reduire(Pol1 * Pol2));
         when '/' =>
            Put(Reduire(Reduire(Pol1) / Reduire(Pol2)));
         when 'r' =>
            Put(Reduire(Reste(Pol1, Pol2)));
         when 'e' =>
            Put(Eval(Pol1, Pol2.Coeff(0)));
         when others =>
            null;
      end case;
   end if;
exception
		when Div_Par_Zero => Put("Division par zero!");
      


end calcul_polynomes;

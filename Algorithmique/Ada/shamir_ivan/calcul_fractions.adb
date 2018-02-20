-- Fichier     : calcul_fractions.adb
-- Auteur      : Ivan PEREZ
-- Version     : 1.0
-- Description : Programme de test du paquetage gestion_fractions

with gestion_fractions; use gestion_fractions;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_line; use Ada.Command_Line;
with ada.float_Text_IO; use ada.float_Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
procedure calcul_fraction is
	F1, F2 :T_Fraction;
	N1 : Integer := Integer'Value(Argument(1));
	N2 : Integer;
	Chaine : String := Argument(2);
	chaine2 : string := Argument(3);
begin
	case Argument_Count is 
      -- Si il n'y a que 3 arguments, alors c'est un PGCD
		when 3 => 
			N2 := PGCD(Integer'Value(Argument(1)), Integer'Value(Argument(2)));
			put(N2);
      -- Si il y a 4 arguments c'est l'opération d'un entier et d'une fraction
		when 4 =>
      -- L'entier est avant la fraction
		case chaine(1)is 
			when '/' => 
				F2.Num := Integer'Value(Argument(3));
				F2.Den := Integer'Value(Argument(4));
				Put(N1 / F2);
			when 'x' => 
				F2.Num := Integer'Value(Argument(3));
				F2.Den := Integer'Value(Argument(4));
				Put(N1 * F2);
			when others =>
				null;
		end case;
      -- La fraction est avant l'entier
		case chaine2(1)is 
			when '/' => 
				F1.Num := Integer'Value(Argument(1));
				F1.Den := Integer'Value(Argument(2));
				Put(F1 / Integer'Value(Argument(4)));
			when 'x' => 
				F1.Num := Integer'Value(Argument(1));
				F1.Den := Integer'Value(Argument(2));
				Put(F1 * Integer'Value(Argument(4)));
			when 'p' => 
				F1.Num := Integer'Value(Argument(1));
				F1.Den := Integer'Value(Argument(2));
				Put(F1 ** Integer'Value(Argument(4)) );
			when others =>
				null;
		end case;
      -- S'il y a 5 paramètres c'est lopération d'une fraction et d'une fraction
		when 5 =>
		case chaine2(1)is 
			when '+' => 
				F1.Num := Integer'Value(Argument(1));
				F1.Den := Integer'Value(Argument(2));
				F2.Num := Integer'Value(Argument(4));
				F2.Den := Integer'Value(Argument(5));
				Put(F1 + F2);
			when '-' => 
				F1.Num := Integer'Value(Argument(1));
				F1.Den := Integer'Value(Argument(2));
				F2.Num := Integer'Value(Argument(4));
				F2.Den := Integer'Value(Argument(5));
				Put(F1 - F2);					
			when '/' => 
				F1.Num := Integer'Value(Argument(1));
				F1.Den := Integer'Value(Argument(2));
				F2.Num := Integer'Value(Argument(4));
				F2.Den := Integer'Value(Argument(5));
				Put(F1 / F2);
			when 'x' => 
				F1.Num := Integer'Value(Argument(1));
				F1.Den := Integer'Value(Argument(2));
				F2.Num := Integer'Value(Argument(4));
				F2.Den := Integer'Value(Argument(5));
				Put(F1 * F2);
			when others =>
				null;
		end case;
			when others =>
				null;
	end case;
			

exception
		when Div_Par_Zero => Put("Division par zero!");
      
end calcul_fraction;


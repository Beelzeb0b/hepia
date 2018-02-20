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


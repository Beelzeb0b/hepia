-- Echeqier - Couverture de la reine
-- Cedric Dos Reis - 10.10.2017
-- Algorithmique

-- Attention : Donner l'arguement qui définit la taille du plateau lors de l'exécution


with Text_IO;                     use Text_IO;
WITH Ada.Command_Line;				USE Ada.Command_Line; 
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;

procedure Huits_Reines is
	gridSize : Integer := Integer'Value(Argument(1));
	type T_Case is (o,R);
	type T_Grid is array(integer range <>,integer range <>) of T_Case;

	myGrid : T_Grid(1..gridSize, 1..gridSize) := (others => (others => o));
	-- affichage de la grille
	procedure DisplayGrid(grid : T_Grid) is
	begin
		for I in grid'range(1) loop
			Put(Integer'Image(I));
			for C in grid'range(2) loop
				case grid(I,C) is
					when o => Put(" .");
					when R => Put(" R");
				end case;
			end loop;	
			New_line;
		end loop;
		New_line;
	end DisplayGrid;
	
	-- verifie si une reine deja placée est en prise avec la case (xQ, yQ)
	function VerifiePrise(grid: in out T_Grid; xQ : Integer; yQ : Integer) return Boolean is 
		result : boolean := false;
	begin
		for I in reverse grid'range(1) loop
			for C in grid'range(2) loop
				if ((I = xQ) 
						or else (C = yQ) 
						or else (abs(I - xQ) = abs(C - yQ))) 
				then
					if grid(I,C) = R then
						result := true;
					end if;
				end if;
			end loop;
		end loop;

		return result;

	end VerifiePrise;	

	-- place recursivement les reine sur le plateau en utilisant le "backtracking"
	function PlacerReine(grid: in out T_Grid; iLine : Integer) return Boolean is
		result : boolean := false;
	begin
		
		if iLine <= gridSize then -- condition de fin de recursivité
			for col in grid'range(2) loop

				-- verifie si une reine peut être placé dans la case (iLine, Col)
				if VerifiePrise(grid, iLine, col) = false then 
					grid(iLine,col) := R; -- place une reine
					--DisplayGrid(myGrid);
					result := PlacerReine(grid, iLine + 1);
					
					-- la solution actuelle ne fonctionne pas -> retour sur trace
					if result = false then
						grid(iLine,col) := o;					
					end if;
				end if;
			end loop;
		else
			-- touvé
			result := true; 
		end if;
			
		return result;

	end PlacerReine;

	-- trouve les solution possibles
	-- place recursivement les reine sur le plateau en utilisant le "backtracking"
	function PlacerReineV2(grid: in out T_Grid; iLine : Integer) return Boolean is
		result : boolean := false;
	begin
		
		if iLine <= gridSize then -- condition de fin de recursivité
			for col in grid'range(2) loop
				-- verifie si une reine peut être placé dans la case (iLine, Col)
				if VerifiePrise(grid, iLine, col) = false then 
					grid(iLine,col) := R; -- place une reine
					--DisplayGrid(myGrid);
					result := PlacerReineV2(grid, iLine + 1);
					
					-- la solution actuelle ne fonctionne pas -> retour sur trace
					if result = false then
						grid(iLine,col) := o;
					end if;
				end if;
			end loop;
		else
			-- touvé
			put("TROUVÉ !") ;
			new_line;
			DisplayGrid(myGrid); 	
		end if;
		return result;
	end PlacerReineV2;

begin
	
	myGrid := (others => (others => T_Case'First));

	if PlacerReineV2(myGrid, 1) = true then
		--put("TROUVÉ !") ;
		--new_line;
		--DisplayGrid(myGrid); 	
		null;
	end if;
	
	
end Huits_Reines;

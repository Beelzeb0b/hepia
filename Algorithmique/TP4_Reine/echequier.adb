-- Echeqier - Couverture de la reine
-- Cedric Dos Reis - 10.10.2017
-- Algorithmique


with Text_IO;                     use Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;

procedure echeqier is
	gridSize : Integer := 8;
	type T_Case is (o,x,R);
	type T_Grid is array(integer range <>,character range <>) of T_Case;

	myGrid : T_Grid(1..8, 'a'..'h');
	QueenX : Integer;
	QueenY : Character;
	-- affichage de la grille
	procedure DisplayGrid(grid : T_Grid) is
	begin
		for I in reverse grid'range(1) loop
			Put(Integer'Image(I));
			for C in grid'range(2) loop
				case grid(I,C) is
					when o => Put(" .");
					when x => Put(" *");
					when R => Put(" R");
				end case;
			end loop;	
			New_line;
		end loop;
	end DisplayGrid;
	
	-- recherche les cases sur lesquels la reine peut se deplace en fonction de sa coordonée dans l'echequier
	procedure Calcul(grid: in out T_Grid; xQ : Integer; yQ : Character) is 
	begin
		for I in reverse grid'range(1) loop
			for C in grid'range(2) loop
				if ((I = xQ) 
						or else (C = yQ) 
						or else (abs(I - xQ) = abs(character'Pos(C) - character'Pos(yQ)))) 
				then
					grid(I,C) := x;
				end if;
			end loop;
		end loop;
		grid(xQ,yQ) := R;
	end Calcul;	


begin
	
	myGrid := (others => (others => T_Case'First));

	DisplayGrid(myGrid);

	Put("X coor (1..8):");
	Get(QueenX);
	New_line;
	Put("Y coor (a..h):");
	Get(QueenY);
	myGrid(QueenX, QueenY) := R;
		
	Calcul(myGrid, QueenX, QueenY);
	DisplayGrid(myGrid);
	
end echeqier;

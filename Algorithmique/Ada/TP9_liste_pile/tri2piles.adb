-- Cedric Dos Reis - 16.01.2018
-- Programme : Tri à deux piles
-- Algorithmique
-- Ce programme permet de des entiers relatifs grace à deux piles. Dans la premiere pile, les valeur sont empiler dans l'ordre croissant. Dans la deuxieme pile, les valeurs sont empiler dans l'ordre décroissant

with Text_IO;                     use Text_IO;
WITH Ada.Command_Line;				USE Ada.Command_Line; 
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;
with Gestion_Pile; 

procedure Tri2piles is
	package G_Pile is new Gestion_Pile(integer);
	use G_Pile;
	p_droite, p_gauche : T_Pile;
	info , infoAEmpiler: integer;

	procedure Put(pile : in out T_Pile) is
		infoAAfficher : integer;
	begin
		while not Vide(pile) loop
			Depiler(pile, infoAAfficher);
			put_line(Integer'Image(infoAAfficher));
		end loop;
	end Put;
begin
	for i in 1..Argument_Count loop -- Parcours les valeurs reçus en parametres
		infoAEmpiler := Integer'Value(Argument(i));
		-- si la pile de gauche est vide, empile la premiere valeur
		if Vide(p_gauche) then
			Empiler(p_gauche, infoAEmpiler);
		else
			-- si la valeur à empiler est plus grande que le sommet de la pile gauche
			if Sommet(p_gauche) < infoAEmpiler then
				-- depiler la pile gauche jusqu'a ce que son sommet soit plus grand que la valeur a empiler
				while not Vide(p_gauche) and then Sommet(p_gauche) < infoAEmpiler loop
					Depiler(p_gauche, info);
					Empiler(p_droite, info);
				end loop;
				Empiler(p_gauche, infoAEmpiler);
			-- si la valeur a empiler est plus petite que le sommet de la pile gauche
			elsif Sommet(p_gauche) > infoAEmpiler then
				-- depile la pile droite jusqu'a ce que son sommet soit plus petit que la valeur à empiler
				while not Vide(p_droite) and then Sommet(p_droite) > infoAEmpiler loop
					Depiler(p_droite, info);
					Empiler(p_gauche, info);
				end loop; 
				Empiler(p_gauche, InfoAEmpiler);
			-- si la valeur à empiler est egal au sommet de la pile gauche
			else
				Empiler(p_gauche, infoAEmpiler);
			end if;
		end if;
	end loop;
	-- Vide la pile de droite
	while not Vide(p_droite) loop
		Depiler(p_droite, info);
		Empiler(p_gauche, info);
	end loop;

	-- Affiche la pile avec sons contenu trié
	Put(p_gauche);
exception
	when PILE_VIDE => Put("Pile vide");
end tri2piles;

-- Cedric Dos Reis - 15.01.2018
-- Package Body: Gestion Pile
-- Algorithmique

with Text_IO;                     use Text_IO;
WITH Ada.Command_Line;				USE Ada.Command_Line; 
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;
with Ada.Unchecked_Deallocation;

procedure Joseph is
	type T_Element;
	type T_Liste is access T_Element;
	type T_Element is record
		Info : integer;
		Suivant : T_Liste := null;
	end record;

	procedure Liberer is new Ada.Unchecked_Deallocation(T_Element, T_Liste);

	-- retroune l'element en fin de liste simple
	function Fin(liste : T_Liste) return T_Liste is
		crt : T_Liste := liste;
	begin
		--recherche le dernier element da le liste
		while crt.Suivant /= null loop
			crt := crt.Suivant;
		end loop;
		return crt;
	end Fin;

	--Insere la valeur reçu à la fin de la liste
	procedure Inserer(liste : in out T_Liste; info : in integer) is
		crt : T_Liste := liste;
	begin
		if liste = null then
			liste := new T_Element'(info, null);
		else
			crt := Fin(liste); -- recupere l'element de fin de la liste
			-- aoute la valeur en fin de list
			crt.Suivant := new T_Element'(info, null);
		end if;
	end Inserer;

	procedure Extraire(liste : in out T_Liste;  k : integer) is
		tmp, crt, aSuppr : T_Liste := liste;
		
	begin
		while crt /= null loop
			for i in 1..k-1 loop
				crt := crt.Suivant;
			end loop;
			-- si il n'y plus qu'un seul element dans la liste
			if crt.suivant = crt then 
				Put(Integer'Image(crt.Info));
				Liberer(crt); -- vide la liste
				liste := null;
			else
				-- sinon supprime normalement
				aSuppr := crt.Suivant;
				Put(Integer'Image(aSuppr.Info));
				crt.suivant := aSuppr.Suivant;
			end if;
		end loop;
	end Extraire;

	-- Transforme la liste simple en liste circulaire
	procedure Circulaire(liste : in out T_Liste) is
		crt : T_Liste:= liste;
	begin
		crt := Fin(liste); -- recupere l'element de fin de la liste
		-- l'element suivant du dernier element de la liste pointe vers le premier
		crt.Suivant := liste;
		liste := crt; -- defint le dernier element de la liste comme pointeur d'accès
	end Circulaire;

	-- Affiche le contenu de la liste simple
	procedure Put(liste: T_Liste) is
		crt : T_Liste:= liste;
	begin
		--Put("Debut :");
		while crt /= null loop
			Put(Integer'Image(crt.Info));
			crt := crt.Suivant;
		end loop;
	end Put;
	
	liste_circ : T_Liste;
	n : Positive := Integer'Value(Argument(1));
	k : Positive := Integer'Value(Argument(2));
begin
	if Argument_Count = 2 then
		-- insere les valeur dans la liste
		for I in 1..n loop
			Inserer(liste_circ, I);
		end loop;
		--Put(liste_circ); New_line;
		Circulaire(liste_circ); -- transforme en liste circulaire
		--Put(liste_circ); New_line;New_line;
		Extraire(liste_circ, k); 
	else 
		Put_line("Erreur de données");
	end if;

end Joseph;

-- Cedric Dos Reis - 17.01.2018
-- Package : Gestion Liste
-- Algorithmique
-- Ce paquet contient l'implémentation des procedures et fonction pour la gestion d'une liste

with Ada.Unchecked_Deallocation;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

package body Gestion_Liste is
	procedure Liberer is new Ada.Unchecked_Deallocation(T_Element, T_Liste);
	
	-- Insert le mot dans la liste ou incremente son bombre d'occurence s'il est deja dedans
	procedure Insert(liste: in out T_Liste; mot: in Unbounded_String; occurence: Positive) is
		crt : T_Liste := liste;
	begin
		-- ajoute le mot au debut de la liste si la liste est vide ou si le mot à ajouter est plus petit que celui en tete
		if liste = null or else liste.Mot > mot then
			liste := new T_Element'(mot, occurence, liste);
		else
			-- parcours la liste jusqu'a trouver un mot plus petit ou jusqu'a la fin
			while crt.suivant /= null and then crt.Suivant.Mot <= mot loop
				crt := crt.Suivant;
			end loop;
			if crt.Mot = mot then -- si les mots sont pareils, incrémente le nombre d'occurence
				crt.Occurence := crt.Occurence + occurence;
			else
				-- ajoute un nouvel element a la liste
				crt.Suivant := new T_Element'(mot, occurence, crt.Suivant);
			end if;
		end if;
	end Insert;

	-- Supprime le mot de la liste si il s'y trouve
	procedure Delete(liste: in out T_Liste; mot: Unbounded_String) is
		crt, aSuppr : T_Liste := liste;
	begin
		if liste = null then 
			raise LISTE_VIDE; -- liste vide
		elsif liste.Mot = mot then 
			-- le mot à supprimer est en tete de liste
			crt := liste;
			liste := liste.Suivant;
			Liberer(crt);
		else
			--parcour la liste jusqu'a trouver un mot plus grand que le mot à supprimer
			while crt.Suivant /= null and then crt.Suivant.Mot < mot loop
				crt := crt.Suivant;
			end loop;
			-- verifie si les mots sont pareil
			if crt.Suivant.Mot = mot then
				-- supprime l'element de la liste
				aSuppr := crt.Suivant;
				crt.Suivant := crt.Suivant.Suivant;
				Liberer(aSuppr);
			else
				-- element inexistant dans la liste
				raise ELEMENT_INEXISTANT;
			end if;
		end if;
	end Delete;

	-- Affiche le contenu de la liste
	procedure Put(liste : in T_Liste) is
		crt : T_liste := liste;
	begin
		while crt /= null loop
			Put(To_String(crt.Mot));
			Put(Integer'Image(crt.Occurence));
			new_line;
			crt := crt.Suivant;
		end loop;
	end Put;


	-- Retourne le nombre d'occurence d'un mot s'il existe
	function Search(liste: T_Liste; mot: Unbounded_String) return Positive is
		crt : T_Liste := liste;
		occurence : natural := 0;
	begin
		if liste = null then 
			raise LISTE_VIDE; -- liste vide
		elsif liste.Mot = mot then 
			-- le mot rechercher est en tete de liste
			occurence := liste.Occurence;
		else
			--parcour la liste jusqu'a trouver un mot plus grand ou egal que le mot à rechercher
			while crt /= null and then crt.Mot < mot loop
				crt := crt.Suivant;
			end loop;
			-- verifie si les mots sont pareil
			if crt.Mot = mot then
				occurence := crt.Occurence;
			else
				-- element inexistant dans la liste
				raise ELEMENT_INEXISTANT;
			end if;
		end if;
		return occurence;
	end Search;
	
	-- Intersection de deux listes
	-- Retourne une liste qui contient les élements communs des listes en parametres
	function Intersect(liste1, liste2 : T_Liste) return T_Liste is
		crt1 : T_Liste := liste1;
		crt2 : T_Liste := liste2;
		liste : T_Liste;
	begin
		-- parcours le liste 1 
		while crt1 /= null loop
			-- parcours la liste 2 jusqu'a trouver un mot plus grand que le mot de la liste 1
			while crt2 /= null and then crt1.Mot >= crt2.Mot loop
				-- verifie si les mot sont pareil
				if crt1.Mot = crt2.Mot then 
					Insert(liste, crt1.Mot, 1); -- insere dans la nouvelle liste
				end if;
				crt2 := crt2.Suivant;				
			end loop;
			crt1 := crt1.Suivant;
		end loop;
		return liste;
	end Intersect;

	--Difference de deux liste
	-- Retourne une liste qui contient les elements de la liste 1 qui ne sont pas dans la liste 2
	function Difference(liste1, liste2 : T_Liste) return T_Liste is
		crt1 : T_Liste := liste1;
		crt2 : T_Liste := liste2;
		liste : T_Liste;
	begin
		-- fait une copie de la liste 1 
		while crt1 /= null loop
			Insert(liste, crt1.Mot, crt1.Occurence);
			crt1 := crt1.Suivant;
		end loop;
		crt1 := liste1;
		-- parcours le liste 1 
		while crt1 /= null loop
			-- parcours la liste 2 jusqu'a trouver un mot plus grand que le mot de la liste 1
			while crt2 /= null and then crt1.Mot >= crt2.Mot loop
				-- verifie si les mot sont pareil
				if crt1.Mot = crt2.Mot then 
					Delete(liste, crt2.Mot); -- Supprime le mot de la liste
				end if;
				crt2 := crt2.Suivant;
			end loop;
			crt1 := crt1.Suivant;
		end loop;
		return liste;
	end Difference;

	-- Addition le contenu des deux liste dans une seule
	function "+"(liste1, liste2 : T_Liste) return T_Liste is
		liste : T_Liste ;
		crt : T_Liste := liste1;
	begin
		-- Insere tout les élement de la liste1 dans la liste
		while crt /= null loop
			Insert(liste, crt.Mot, crt.Occurence);
			crt := crt.Suivant;
		end loop;
		-- Insere tout les élement de la liste2 dans la liste
		crt:= liste2;
		while crt /= null loop
			Insert(liste, crt.Mot, crt.Occurence);
			crt := crt.Suivant;
		end loop;
		return liste;
	end "+";
end Gestion_Liste;

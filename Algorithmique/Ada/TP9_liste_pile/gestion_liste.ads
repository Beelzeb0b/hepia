-- Cedric Dos Reis - 17.01.2018
-- Package : Gestion Liste
-- Algorithmique
-- Contient la déclaration de la structure d'une liste, des procedures et des fonctions pour gérer une liste

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
package Gestion_Liste is
	type T_Liste is limited private;
	
	-- Exceptions
	ELEMENT_INEXISTANT : exception;
	LISTE_VIDE: exception;

	-- Procedures
	procedure Insert(liste: in out T_Liste; mot: in Unbounded_String; occurence: Positive);
	procedure Delete(liste: in out T_Liste; mot: in Unbounded_String);
	procedure Put(liste: in T_Liste);
	
	-- Fonctions
	function Search(liste: T_Liste; mot: Unbounded_String) return Positive;
	function Intersect(liste1, liste2 : T_Liste) return T_Liste;
	function Difference(liste1, liste2 : T_Liste) return T_Liste;
	function "+"(liste1, liste2 : T_Liste) return T_Liste;

	
private
	type T_Element;
	type T_Liste is access T_Element;
	type T_Element is record
		Mot : Unbounded_String;
		Occurence : Natural := 0;
		Suivant : T_Liste := null;
	end record;
end Gestion_Liste;

-- Cedric Dos Reis - 15.01.2018
-- Package : Gestion Pile
-- Algorithmique
-- Contient la déclaration de la structure d'une pile, des procedures et des fonctions pour gérer une pile

generic
	type T_Info is private;

package Gestion_Pile is
	type T_Pile is limited private;

	PILE_VIDE : exception;
	
	function Vide(Pile: T_Pile) return boolean;
	function Sommet(Pile: T_Pile) return T_Info;
	procedure Empiler(Pile : in out T_Pile; Info : in T_Info);
	procedure Depiler(Pile : in out T_Pile; Info : out T_Info);
private 
	type T_Element;
	type T_Ptr_Element is access T_Element;
	type T_Element is record
		Info : T_Info;
		Suivant : T_Ptr_Element;
	end record;
	type T_Pile is record
		Sommet : T_Ptr_Element := null;
	end record;
end Gestion_Pile;

-- Cedric Dos Reis - 15.01.2018
-- Package Body: Gestion Pile
-- Algorithmique
-- Ce paquet contient l'implémentation des procedures et fonctions pour la gestion d'une pile

with Ada.Unchecked_Deallocation;

package body Gestion_Pile is
	procedure Liberer is new Ada.Unchecked_Deallocation(T_Element, T_Ptr_Element);

	-------- FUNCTIONS --------
	--retourne vrai si la pile est vide sinon retourne faux
	function Vide(Pile: T_Pile) return boolean is
	begin
		return Pile.sommet = null;
	end Vide;

	-- Retourne le sommet de la pile (recursivement)
	function Sommet(Pile: T_Pile) return T_Info is
	begin
		return Pile.sommet.Info;
	end Sommet;

	
	-- Empile une info dans la pile
	procedure Empiler(Pile : in out T_Pile; Info : in T_Info) is 		
	begin
		Pile.sommet := new T_Element'(Info, Pile.sommet);
	end Empiler;

	-- Depilage
	procedure Depiler(Pile : in out T_Pile; Info : out T_Info) is 
		tmp : T_Pile := Pile;
	begin
		if Vide(Pile) then
			raise PILE_VIDE;
		else
			Info := Pile.sommet.Info;
			Pile.Sommet := Pile.sommet.Suivant;
		end if;
	end Depiler;
	
end Gestion_Pile;


type T_Noeud;
Type T_Arbre is access T_Noeud;
type T_Noeud is record
	Cle : Integer;
	Gauche : T_Arbre := null;
	Droite : T_Arbre := null;
end record;

ARBRE_VIDE : exception;
CLE_ABSENTE : exception;
CLE_PRESENTE : exception;

procedure Insert(A: in out T_Arbre; cle : in integer);

procedure Delete(A: in out T_Arbre; cle : in integer);

procedure Search(A: T_Arbre; cle : integer) return T_Arbre;


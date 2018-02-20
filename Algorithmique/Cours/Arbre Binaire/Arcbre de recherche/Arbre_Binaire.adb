-- permet de selectionner la position où la valeur cle sera inserés
procedure Position(A : in T_Arbre; Cle : Integer; Nd, Parent : in out T_Arbre) is
begin
	If A = null then
		raise ARBRE_VIDE;
	end if;
	while Nd.Cle /= Cle loop
		if Cle > Nd.Cle then -- si la valeur à inseré est plus grande que le courant
			exit when Nd.Droite = null;
			Parent := Nd;
			Nd:= Nd.Droite;
		elsif Cle < Nd.Cle then -- si la valeur à inseré est plus petite que le courant
			exite when Nd.Gauche = null;
			Parent := Nd;
			Nd := Nd.Gauche;
		end if;
	end loop;	
end Position;

procedure Search(A: T_Arbre; cle : integer) return T_Arbre is 
	Parent : T_Arbre := null;
	Noeud : T_Arbre := A;
begin
	Position(A, cle, Noeud, Parent);
	if Cle /= Noeud.cle then
		raise CLE_ABSENTE;
	end if;
	return Noeud;
end Search;

procedure Insert(A: in out T_Arbre; cle : in integer) is
	Parent : T_Arbre := null;
	Noeud : T_Arbre := A;
begin
	if A = Null then
		A := new T_Noeud'(cle, null, null);
	else
		Position(A, cle, Noeud, Parent);
		if Cle = Noeud.Cle then
			raise CLE_PRESENTE;
		elsif cle > Noeud.cle then
			Noeud.Droite := new T_Noeud'(Cle, null, null);
		elsif cle < Noeud.cle then
			Noeud.Gauche := new T_Noeud'(Cle, null, null);
		end if;
	end if;
end Insert;

procedure Delete(A: in out T_Arbre; cle : in integer) is 
	Parent : T_Arbre := null;
	Noeud : T_Arbre := A;
	Tmp : T_Arbre := null;
begin
	Position(A, Cle, Noeud, Parent);
	if Cle /= Noeud.Cle then
		raise CLE_ABSENTE;
	end if;
	if Noeud.Gauche /= null then
		Parent := Noeud;
		Tmp := Noeud.Gauche;
		Position(Noeud.Gauche, Cle, Tmp, Parent);
	elsif Noeud.Droite /= null then
		Parent := Noeud;
		Tmp := Noeud.Droite;
		Position(Noeud.Droite, Cle, Tmp, Parent);
	end if;
	if Parent = null then
		A := null;
	elsif Parent.Gauche = Tmp then
		Parent.Gauche := Tmp.Gauche;
	elsif Parent.Droite = Tmp then
		Parent.Droite := Tmp.Droite;	
	end if;
	Liberer(Tmp);
end Delete;

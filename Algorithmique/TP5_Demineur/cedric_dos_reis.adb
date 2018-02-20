-- Cedric Dos Reis
-- Demineur
-- 04.11.2017

with Ada.Text_IO;					use Ada.Text_IO;
WITH Ada.Command_Line;				USE Ada.Command_Line;
WITH Ada.Integer_Text_IO;			USE Ada.Integer_Text_IO;
with Ada.Calendar;					use Ada.Calendar;
with Ada.Float_Text_IO;				use Ada.Float_Text_IO;
with Ada.Numerics.Float_Random;		use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;

procedure Cedric_Dos_Reis is
   -- type tableau pour l'aire de jeu
   type T_Board is array(Integer range <>,Integer range <>) of Integer;
   -- type tableau pour les drapeaux et les cases ouvertes/ferm?es
   type T_Display is array(Integer range <>,Integer range <>) of Boolean;
   Bombe_Val : Integer := -1; -- est la valeur entière qui définit une bombe 
   Gen : Generator; -- pour aléatoire
-------------------------------------------------------------------------
   -- Proc?dure d'affichage de l'aire de jeu tenant compte des cases
   -- ouvertes, ferm?es et avec drapeau
   -- Param?tre <Visibilite> : cases ouvertes/ferm?es
   --           <Flags>      : cases avec ou sans drapeau
   --           <Board>      : aire de jeu
   -- NE PAS MODIFIER CETTE PROCEDURE
   procedure Affichage(Visibilite, Flags : in T_Display; Board : in T_Board) is
   begin
      Put("   ");
      for J in Visibilite'range(2) loop
         Put(J,4);
      end loop;
      Put_Line(Standard_Error,"");
      for I in Visibilite'range(1) loop
         Put(I,4);
         for J in Visibilite'range(2) loop
            if Flags(I,J) then
               Put(Standard_Error,"  D ");
            else
               if Visibilite(I,J) then
                  Put(Standard_Error,Board(I,J),3); Put(" ");
               else
                  Put(Standard_Error,"  . ");
               end if;
            end if;
         end loop;
         Put_Line(Standard_Error,"");
      end loop;
      Put_Line(Standard_Error,"");
   end Affichage;

-------------------------------------------------------------------------
   -- Proc?dure qui place les bombes aux positions pass?es en argument sur la
   -- ligne de commande via les variables <Argument_Count> (de type Natural)
   -- et <Argument> (de type tableau de String) du paquetage <Command_Line>
   procedure Poser_Bombes(Board : in out T_Board) is
      Li,Co : Integer := 0;
   begin
      for I in 1..(Argument_Count-2)/2 loop
         Li := Integer'Value(Argument(2*I+1));
         Co := Integer'Value(Argument(2*I+2));
         -- Remplacer cette instruction pour mettre une valeur enti?re
         -- repr?sentant une bombe dans la case Board(Li,Co)
         Board(Li,Co) := Bombe_Val;
         Put_Line("Placer une bombe dans la case ("
                  & Integer'Image(Li) & "," & Integer'Image(Co) & " )"
                 );
      end loop;
   end Poser_Bombes;

-------------------------------------------------------------------------
   -- Proc?dure qui place <Nb> bombes ? des positions al?atoires
   -- dans <Board>
   procedure Poser_Bombes(Board : in out T_Board; Nb : in Natural) is
		width, height, l, c : Integer;
   begin
		width := board'Length(1);
		height := board'Length(2);
		for I in 1..Nb loop
			l := Integer(Float(height-1)*Random(Gen)) + 1; -- nombre entre (0..taille-1) + 1
			c := Integer(Float(width-1)*Random(Gen)) + 1;

			-- genere un nouvelle coordonnée de case si la coord actuelle contient deja un bombe
			while Board(l,c) = Bombe_Val loop
				l := Integer(Float(height-1)*Random(Gen)) + 1; -- nombre entre (0..taille-1) + 1
				c := Integer(Float(width-1)*Random(Gen)) + 1;
			end loop;

			-- ajoute une bombe dans la case (l,c)
			Board(l,c) := Bombe_Val;		
		end loop;
   END Poser_Bombes;

-------------------------------------------------------------------------
   ----------------------------------------------------
   -- Placer ici vos autres proc?dures et fonctions --
   ----------------------------------------------------
-------------------------------------------------------------------------

	-- verifie si toutes les cases vide ont été ouverte
	function Verifie(Visibilite : T_Display; Board : T_Board) return Boolean is
		Gagne : Boolean := True;
	begin
		For I in Board'Range(1) loop
			For J in Board'Range(2) loop
				if Visibilite(I,J) = False and Board(I,J) /= Bombe_Val then
					Gagne := False;
					return Gagne;
				end if ;
			end loop;
		end loop;
		return Gagne;
	end Verifie;

	-- Compte le nombre de bombe chez les voisins dans le rayon de la case en (Li, Co)
	function Compte_Nb_Bombe_Voisins(Board : T_Board; Li, Co : Integer; Rayon : Positive)	return Natural is
		Nb_Bombe_Voisins : Natural := 0;
	begin
		for I in Li-Rayon..Li+Rayon loop
			for J in Co-Rayon..Co+Rayon loop
				if I in Board'Range(1) and J in Board'Range(2) then
					if Board(I,J) = Bombe_Val then	
						Nb_Bombe_Voisins := Nb_Bombe_Voisins +1;
					end if;
				end if;
			end loop;
		end loop;
		return Nb_Bombe_Voisins;
	end Compte_Nb_Bombe_Voisins;
	
	-- Ouvre la case en (Li, Co) , Ouvre les case voisine si auncune bombe trouvée
	procedure Ouvre_Case(Li, Co : in Integer; Visibilite : in out T_Display; Board : in out T_Board) is
		Nb_Bombe_Voisins : Integer := 0;
		Rayon : Positive := 1;
	begin
		
		if Visibilite(Li, Co) = False then -- test si la case n'à pas déja été ouverte 
			-- compte le nombre de bombe chez les voisins
			Nb_Bombe_Voisins := Compte_Nb_Bombe_Voisins(Board, Li, Co, Rayon);

			Visibilite(Li, Co) := true; -- case ouverte
			Board(Li, Co) := Nb_Bombe_Voisins;  
			
			-- Ouvre les case voisine si aucune bombe
			if Nb_Bombe_Voisins = 0 then
				for I in Li-Rayon..Li+Rayon loop
					for J in Co-Rayon..Co+Rayon loop
						if I in Board'Range(1) and J in Board'Range(2) then
							Ouvre_Case(I, J, Visibilite, Board);
						end if;
					end loop;
				end loop;
			end if;
		end if;
	end Ouvre_Case;

   -- Aire de jeu de dimensions pass?es en ligne de commande
   Board : T_Board(1..Integer'Value(Argument(1)),1..Integer'Value(Argument(2)))
            := (others => (others => 0));
   -- Tableaux utilis?s pour la visualisation des cases ouvertes, ferm?es
   -- et avec drapeau
   Visibilite, Flags : T_Display(Board'Range(1),Board'Range(2))
                        := (others => (others => False));
   -- Position d'une case de l'aire de jeu
   Li : Integer := Board'First(1);
   Co : Integer := Board'First(2);
   -- Nombres totaux de bombes et de drapeaux
   Nb_Bombes, Nb_Drapeaux : Natural := 0;
   -- Variables d'?tat du jeu pour d?tecter la fin de partie
   Gagne, Perdu, Abandon : Boolean := False;
   -- Chronom?tre
   Start, Temps : Integer := 0;
   -- Choix de l'action utilisateur
   Choix : Natural := 0;

begin -- Demineur
   --------------------------------------------------------------
   -- VOUS NE DEVEZ RIEN MODIFIER POUR LE RENDU FINAL          --
   -- SAUF AUX ENDROITS INDIQU?S "? compl?ter" ou "? modifier" --
   --------------------------------------------------------------
   Put_Line("Dimension du plateau:"
        & Integer'Image(Board'Length(1))
        & " x"
        & Integer'Image(Board'Length(2))
       );
   
   Put("Nombre de bombes: ");
   if (Argument_Count = 2) then
      Reset(Gen);
      Get(Nb_Bombes);
      Poser_Bombes(Board,Nb_Bombes); -- bombes pos?es al?atoirement
   else
      Nb_Bombes := (Argument_Count-2)/2;
      Put_Line(Integer'Image(Nb_Bombes));
      Poser_Bombes(Board); -- bombes pos?es selon arguments
                           -- pass?s en ligne de commande
   end if;
   Nb_Drapeaux := 0;--Nb_Bombes;
   Start := Integer(Seconds(Clock));
   loop
      Put("Action (0. Quitter / 1. Drapeau / 2. Ouvrir case): ");
      Get(Choix);
      case Choix is
         -- Abandon
         when 0 => Abandon := True;

         -- Placer ou enlever un drapeau
         when 1 =>
            Put("Position (Ligne,Colonne) = ");
            Get(Li);
            Get(Co);
				-- Enleve ou positionne un drapeau
				if Flags(Li,Co) = True then
					Flags(Li,Co) := False;
					Nb_Drapeaux := Nb_Drapeaux -1;
				elsif Flags(Li,Co) = False  and Nb_Drapeaux < Nb_Bombes then
					Flags(Li,Co) := True;
					Nb_Drapeaux := Nb_Drapeaux +1;
				end if;
         -- Ouvrir une case / perdu si elle contient une bombe
         when 2 =>
            Put("Position (Ligne,Colonne) = ");
            Get(Li);
            Get(Co);
            if Board(Li,Co) = Bombe_Val then
					Perdu := true; -- PERDU
				else
					Ouvre_Case(Li, Co, Visibilite, Board); -- ouvre la case
					-- verifie si toutes les case ont été ouvertes
					Gagne := Verifie(Visibilite, Board); 
				end if;
				
         -- Choix non-valides
         when others => Put("Choix ind?fini!");
      end case;
      Affichage(Visibilite,Flags,Board);
      exit when (Gagne or Perdu) or Abandon;
   end loop;
   if Abandon then
      Put_Line("Abandon!");
   elsif Gagne then
      Put_Line("Gagn?!");
      Temps := Integer(Seconds(Clock)) - Start;
      Put_Line("Votre temps:" & Integer'Image(Temps));
   elsif Perdu then
      Put_Line("Perdu!");
   end if;
   -- Affichage du plateau de jeu avec toutes les cases ouvertes
   Put_Line("Plateau de jeu ouvert");
   Visibilite := (others => (others => True));
   Flags := (others => (others => False));
   Affichage(Visibilite,Flags,Board);
end Cedric_Dos_Reis;
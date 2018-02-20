-- Cedric Dos Reis - 20.01.2018
-- Algorithmique
-- Ce programe permet de trié lexicographiquement les mots contenu dans un fichier grace aux listes, Afficher tous les mots avec leur occurence, Supprimer un mot de la liste trié, Addition le conteenu de deux listes, Faire la différence de deux liste det de Faire l'intersection de deux liste


with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Gestion_Liste; use Gestion_Liste;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
procedure Dico is
-- lecture d'un mot de caractères dans 'a'..'z' ou 'A'..'Z'
   procedure Read_Word(Fichier  : in File_Type; 
                       Mot      : out String;
                       Lg       : out Natural) is 
      ch : Character;
   begin
      lg := 0;
      Mot := (others => Ascii.Nul); -- Ascii.Nul est le caractère vide  
      loop
         Get_Immediate(Fichier,Ch);
         exit when ch not in 'a'..'z' and ch not in 'A'..'Z';
         lg := lg+1;
         mot(lg) := ch;
      end loop;
   end Read_Word;

	-- Lit le contenu du fichier et ajoute le mot dans liste
	procedure Read_File(nomFichier: in String; liste : in out T_Liste) is
		Fichier : File_Type;
		mot     : String(1..100) := (others => Ascii.Nul);
	   Lg : Natural := 0;	
	begin
		Open(Fichier, In_File, nomFichier);  
   	while not End_Of_File(Fichier) loop
   	   Read_Word(Fichier, mot, Lg);
   	   if Lg > 0 then
   	      --Put_Line(mot(1..Lg));
				Insert(liste, To_Unbounded_String(mot(1..lg)),1);
   	   end if;
   	end loop;
   	Close(Fichier);	
	end Read_File;
   
   
   commande : Character := Argument(1)(2);
	nomFichier1 : string := Argument(2);
	tmp, liste1, liste2 : T_Liste;
begin
	-- lit le fichier et insere les mots dans la liste
   Read_File(nomFichier1, liste1);
	
	case commande is
		when 'p' =>  -- Affiche simple
			Put(liste1);

		when 's' => -- Affiche le nombre d'occurence d'un mot specifique
			Put(Integer'Image(Search(liste1, To_Unbounded_String(Argument(3)))));

		when 'x' => -- supprime le mot definit de la liste
			Delete(liste1, To_Unbounded_String(Argument(3)));
			Put(liste1);

		when 'i' => -- Intersection des listes
			Read_File(Argument(3), liste2); -- lit le deuxieme fichier;
			Put(Intersect(liste1, liste2));

		when 'd' => -- Difference des listes
			Read_File(Argument(3), liste2); -- lit le deuxieme fichier;
			Put(Difference(liste1, liste2));

		when 'c' => -- Concatenation des listes
			Read_File(Argument(3), liste2); -- lit le deuxieme fichier;
			Put(liste1+liste2);

		when others => 
			Put("Commande inconnue.");
	end case;

exception
	when LISTE_VIDE => Put_line("liste vide");
	when ELEMENT_INEXISTANT => Put_line("Cet élément n'existe pas");
end Dico;

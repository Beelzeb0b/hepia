with Ada.Text_IO; use Ada.Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;
with Ada.Command_Line; use Ada.Command_Line;

procedure readfile is
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
   
   Fichier : File_Type;
   mot     : String(1..100) := (others => Ascii.Nul);
   Lg : Natural := 0;
begin
   Open(Fichier,In_File,Argument(1));  
   while not End_Of_File(Fichier) loop
      Read_Word(Fichier,mot,Lg);
      if Lg > 0 then
         Put_Line(mot(1..Lg));
      end if;
   end loop;
   Close(Fichier);
end readfile;

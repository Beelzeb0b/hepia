with Text_IO; use Text_IO;
with Ada.Integer_Text_IO; use Ada.Integer_Text_IO;

procedure Negatif is
   type T_Image is array (Integer range<>, Integer range<>) of Natural;

   type T_Texte is record
      Txt : String(1..80):= (others => Ascii.Nul);
      Longueur : Natural := 0;
   end record;

   type T_Entete is record 
      Genre : T_Texte;
      Dim_X, Dim_Y   : Natural;
      Niveau  : Natural;
   end record;

   function LireEntete(Nom_Fichier : String) return T_Entete is
      Fichier  : File_Type;
      Entete   : T_Entete;
      Tmp      : String(1..80);
      Longueur : Natural;
      b : boolean;
   begin
      Open(Fichier,In_File,Nom_Fichier);
      Get_Line(Fichier,Entete.Genre.txt,Entete.Genre.Longueur);
      loop -- on saute les lignes de commentaires
         Look_Ahead(Fichier,Tmp(1),b);
         exit when Tmp(1) /= '#';
         Get_Line(Fichier,Tmp,Longueur);
      end loop;
      Get(Fichier,Entete.Dim_X);
      Get(Fichier,Entete.Dim_Y);
      Get(Fichier,Entete.Niveau);
      Close(Fichier);
      return Entete;
   end LireEntete;
   
   procedure Lire(Image : out T_Image; Nom_Fichier : in String) is
      Fichier  : File_Type;
      Tmp      : String(1..80);
      Longueur : Natural;
      b : boolean;
   begin
      Open(Fichier,In_File,Nom_Fichier);
      Get_Line(Fichier,Tmp,Longueur);
      loop
         Look_Ahead(Fichier,Tmp(1),b);
         exit when Tmp(1) /= '#';
         Get_Line(Fichier,Tmp,Longueur);
      end loop;
      Get_Line(Fichier,Tmp,longueur);
      Get_Line(Fichier,Tmp,longueur);
      for I in Image'Range(1) loop
         for J in Image'Range(2) loop
            Get(Fichier,Image(I,J));
         end loop;
      end loop;
      Close (Fichier);
   end Lire;

   procedure Ecrire (Entete: in T_Entete; Image : in T_Image; Nom_Fichier : String) is
      Fichier   : File_Type;
   begin
      Create (Fichier,Out_File,Nom_Fichier);
      Put(Fichier,Entete.Genre.txt(1..Entete.Genre.Longueur));
      New_Line(Fichier);
      Put(Fichier,Entete.Dim_X,4);
      Put(Fichier,Entete.Dim_Y,4);
      New_Line(Fichier);
      Put(Fichier,Entete.Niveau,4);
      New_Line(Fichier);
      for I in Image'Range(1) loop
         for J in Image'Range(2) loop
            Put(Fichier, Image (I,J),4);
            if ((I-1)*Image'length(2)+J-1) mod 20 = 0 then
                New_Line(Fichier);
            end if;
         end loop;
      end loop;
      Close (Fichier);
   end Ecrire;

   monEntete: T_Entete := LireEntete("lena.pgm");
   monImage : T_Image(1..monEntete.Dim_X,1..monEntete.Dim_Y);
   
begin
   lire(monImage,"lena.pgm");

   for I in monImage'Range(1) loop
      for J in monImage'Range(2) loop
         monImage (I,J) := 255 - monImage (I,J);
      end loop;
   end loop;

   ecrire(monEntete,monImage,"sortie.pgm");

end Negatif;


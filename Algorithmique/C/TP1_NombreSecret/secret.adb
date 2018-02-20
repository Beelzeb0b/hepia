-- Le nombre secret

-- Clause de contexte: paquetages
with Text_IO;                     use Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;

procedure Secret is  -- partie d?clarative
   Max       : Integer := 0;    -- borne sup?rieure
   Nb_Secret : Integer := -1;   -- nombre secret
   Nb        : Integer := 0;    -- nombre entr? par l'utilisateur
   Cnt       : Integer := 0;    -- compteur des coups jou?s
   Gen       : Generator;       -- g?n?rateur al?atoire

   -- instanciation d'un paquetage g?n?rique de fonctions
   package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
   use Math;

begin -- corps de la proc?dure Secret

   -- saisie de la borne sup?rieure Max
   Put("Donnez une borne sup sur l'entier positif ? deviner : ");
   Get(Max);

   -- Initialisation du g?n?rateur al?atoire
   Reset(Gen);

   -- nombre al?atoire entre 0 et Max
   Nb_Secret := Integer(Float(Max+1)*Random(Gen)-0.5);

   -- boucle pour deviner le nombre secret
   loop
      Put("Devinez : ");
      Get(Nb);
      Cnt := Cnt + 1;           -- incr?mentation du compteur des coups jou?s
      exit when Nb = Nb_Secret; -- sortie de la boucle si Nb_Secret est trouv?

      -- test pour savoir si Nb est plus petit ou plus grand que Nb_Secret
      if Nb < Nb_Secret then
         Put_Line("Nb. secret plus grand");
      elsif Nb > Nb_Secret then
         Put_Line("Nb. secret plus petit");
      end if;
   end loop;

   Put("Gagn?!");
   Put("Nb. de coups: ");
   Put(Cnt);
   New_Line;
   Put("Nb. optimal de coups: ");
   Put(Integer(Log(Float(Max),2.0)+0.5));

end Secret;
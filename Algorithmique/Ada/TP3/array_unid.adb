-- Estimation de valeur de PI
-- Cedric Dos Reis - 26.09.2017
-- Algorithmique

with Text_IO;                     use Text_IO;
with Ada.Integer_Text_IO;         use Ada.Integer_Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;

procedure array_unid is
	Max : constant := 10;
	subtype T_Indice is Integer range 1..Max;
	type T_Stat is array (T_Indice) of Integer;
	myArray : T_Stat;
	Gen : Generator;
	
	iPlusPetiteValeur : Integer;
	plusPetiteValeur	: Integer; 

	iGrandeValeur : Integer;	-- Index de la plus grand valeur

	elementRecherche : Integer; -- element recherche par l'utilisateur
	elementTrouve : Boolean := false; -- difini si l'élement recherché a été trouvé

	Total : Integer := 0; -- permet de calculer la moyenne
	Moyenne : Float := 0.0;

	Variance : Float := 0.0; -- varaiance du tableau

	median : Integer := 0; -- valeur media du tableau 
	swap : Integer;

-- instanciation d'un paquetage g�n�rique de fonctions
   package Math is new Ada.Numerics.Generic_Elementary_Functions(Float);
   use Math;
begin
	Reset(Gen);
	-- exemple agregation -> myArray(1|3=>1, 4=>5, others=> 9);
	for I in myArray'range loop -- 
		myArray(I) := Integer(Random(Gen)*10.0);
	end loop;

	for I in myArray'first..myArray'last loop
		put(myArray(I));
		New_line;
	end loop;

	-- trouve la plus petite valeur du tableau
	plusPetiteValeur := myArray(1);
	for I in myArray'range loop 
		if(plusPetiteValeur > myArray(I)) then
			plusPetiteValeur := myArray(I);
		end if;
	end loop;
	put("Plus petit valeur : ");
	put(plusPetiteValeur);
	New_Line;

	--Recherche l'index de la plus grande valeur et "swap" la plus grand valeur avec celle de la fin du tableau
	Put("Plus grand valeur a la fin : ");
	New_line;
	iGrandeValeur := 1;
	for I in myArray'range loop 
		if(myArray(iGrandeValeur) < myArray(I)) then
			iGrandeValeur := I;
		end if;
	end loop;
	-- swap les valeurs si pas deja a la fin 
	if(iGrandeValeur < myArray'last) then 
		myArray(iGrandeValeur) := myArray(iGrandeValeur) + myArray(myArray'last); -- A:=A+B
		myArray(myArray'last) := myArray(iGrandeValeur) - myArray(myArray'last);  -- B:=A-B
		myArray(iGrandeValeur) := myArray(iGrandeValeur) - myArray(myArray'last); -- A:=A-B
	end if;
	-- affiche le tableau avec la plus grande valeur a la fin
	for I in myArray'first..myArray'last loop
		put(myArray(I));
		New_line;
	end loop;

	-- Recherche dans le tableau un element entré dans la console
	Put("Entrez l'élément recherché :");
	Get(elementRecherche);
	New_line;
	for I in myArray'range loop 
		if(elementRecherche = myArray(I)) then
			put("L'élément recherché se trouve en ");
			put(I);
			elementTrouve := true;
			New_line;
		end if;
	end loop;
	if(elementTrouve = false) then
		put("Cet élément n'éxiste pas !");
		New_line;
	end if;
	

	-- Moyene des éléement du tableau
	for I in myArray'range loop 
		Total := Total +myArray(I);
	end loop;
	Moyenne := Float(Total)/Float(myArray'length);
	Put("Moyenne des éléement :");
	Put(Moyenne, exp=>0);
	New_line;

	-- Calcule de la variance
	Variance := 0.0;
	for I in myArray'range loop 
		Variance := Variance + ((Float(myArray(i)) - Moyenne)**2) / Float(myArray'length);
	end loop;
	put("Variance : ");
	put(Variance, exp=>0);
	New_line;


	-- Trouver l'élément median
	-- tri le tableau par ordre croissant
	-- https://rosettacode.org/wiki/Averages/Median
	for I in myArray'range loop 
		plusPetiteValeur := I;
		iPlusPetiteValeur := myArray(I);
		for J in I+1 .. myArray'last loop
			if myArray(J) < PlusPetiteValeur then
				 iPlusPetiteValeur := J;
				 PlusPetiteValeur := myArray(J);
			end if;                
		end loop;
		swap := myArray(I);
		myArray(I) := myArray(iPlusPetiteValeur);
		myArray(iPlusPetiteValeur) := swap;
	end loop;


	if myArray'length mod 2 = 0 then
		median := (myArray(myArray'length/2) + myArray(myArray'length/2+1)) /2;
	else
		median := myArray(myArray'length/2+1);
	end if;
	for I in myArray'first..myArray'last loop
		put(myArray(I));
		New_line;
	end loop;
	Put("Valeur median :");
	Put(median);
	
	
	
end array_unid;
	

-- Code de Reed Solomon
-- Cedric Dos Reis - 11.12.2017
-- Algorithmique

with Text_IO;                     use Text_IO;
WITH Ada.Command_Line;				USE Ada.Command_Line; 
with Ada.Numerics.Float_Random;   use Ada.Numerics.Float_Random;
with Ada.Numerics.Generic_Elementary_Functions;
with Gestion_Fractions; use Gestion_Fractions;
with Gestion_Polynomes; use Gestion_Polynomes;

Procedure Reed_Solomon is

	data, total, parity : Integer := 0;
	
	subtype T_Octet is Natural range 0..255;
	type T_Point is record
		x : Integer := 0;
		y : T_Octet := 0;
	end record;
	type T_Points is array(Integer range<>) of T_Point ;
	
	function Produit return T_Polynome is
		polynome : T_Polynome;
	begin
		return polynome;
	end Produit;
	
	function Interpolate(points : T_Points) return T_Polynome is 
		polynome : T_Polynome;
	begin
		return polynome;
	end Interpolate;
begin 
	-- REMARQUE : énoncé pas très compréhensible
	
	--polynome := Interpolate(points);
	--Put(polynome);

end Reed_Solomon;

procedure Insert(liste : in out T_Liste; Val : in Integer) is
	tmp : T_Liste := new T_Element'(Val, null);
	crt : T_Liste := liste;
	prec : T_Liste := null;
begin
	while crt /= null and then Random(gen) > 0.5 loop
		prec := crt;
		crt : crt.suivant;
	end loop;
	if Prec = null then
		tmp.Suivant := liste
		liste := tmp;
	else
		tmp.Suivant := crt;
		prec.suivant := tmp;
	end if;
end Insert;


procedure Random_Inclusion(liste1 : in out T_Liste; liste2 : in T_Liste ) is
	crt : T_Liste : liste2;
begin
	while crt /= null loop
		Insert(liste1, crt.Info);
		crt := crt.suivant;
	end loop;
end Random_Inclusion;
type T_Tab is array (Positive range<>) of integer;

procedure Promotion(Tab : in out T_Tab; I: in out Positive) is
	Max : Positive := I;
begin	
	If fils_gauche(I) <=Tab'Last and then Tab(fils_gauche(I)) > Tab(Max) then
		Max := fils_gauche;
	elsif fils_droite(I) <=Tab'Last and then Tab(fils_droite(I)) > Tab(Max) then
		Max := fils_droite;
	end if;
	if I /= Max then
		Swap(Tab(I), Tab(Max));
		I := Max;
	end if;
end Promotion;

procedure Propagation(Tab : in out T_Tab; I: in out Integer) is
	J,K : Positive;
begin
	loop
		K := I;
		Promotion(Tab, J);
		exit when J = K;
	end loop;
end Propagation;

function fils_droite(I : Positive) return Positive;
function fils_gauche(I : Positive) return Positive;
Procedure Swap(A,B: in out Integer);
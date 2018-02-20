# Cedric Dos Reis
# PGCD - MatLab
# 17.01.2018
clear all;

function result = pgcdv2(a, b)
  #Tri les nombres
  if (a >= b)
    newA = a
    newB = b
  else 
    newA = b
    newB = a
  endif
  # si les 2 nombres sont egal a 0
  if (newA == 0 && newB == 0) 
    result = 0; # retourne 0 
    return;
  # si un des deux nombres est egal à 0
  elseif (newA == 0 || newB == 0) 
    result = newA; # retourne la valeur la plus grande
    return;
  else 
	# si les deux nombre sont différents de 0
    rest = rem(newA,newB) # modulo 
    if rest > 0 # si le reste est plus grand que 0
      result = pgcdv2(newB,rest); # appel recursif
      return;
    else 
      result = newB; 
      return;
    endif
  endif
endfunction

disp(pgcdv2(15, 36));
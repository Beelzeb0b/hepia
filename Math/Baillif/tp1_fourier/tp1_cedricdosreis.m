# Cedric Dos Reis
# 28.01.2018
# Tp1 - Fourier
clear all;
per = @(x) (x-floor((x+pi)/2 /pi)*2*pi); # Permet de rendre périodique n'importe quelle fonction
t = [-3*pi:.1:3*pi]; 
# liste de fonctions
s1 = @(x) x;
s2 = @(x) rem(floor(x)*4,3)/3;
s3 = @(x) x.^2 / pi^2;
s4 = @(x) x/pi + (-1).^(floor(2*(x+pi/6))/pi);
s5 = @(x) (-1).^((sign(cos(x.^3/ 3))+1)/2);
s6 = @(x) x.^2 / 5 + sign(sin(3*x));
s7 = @(x) abs(x) / pi + sin(3*x)/ 5;
s8 = @(x) @(x) abs(per(x)) + abs(per(3*x))/3;
s9 = @(x) exp(-1./(x.^2-pi^2).^2).*x.^2 + exp(-1./x.^2).*(x.^2-pi^2);
s10 = @(x) x/-pi;
s11 = @(x) sin(x/pi).*cos(pi*x);
s = s11; # definit la fonction à utiliser
n=50 # nombre de termes
a0 = quadcc(s, -pi, pi)/(2*pi); # coefficiant a0
result = a0;
for k=1:n
	f1 = @(x) cos(k*x).*s(x); # fonction pour le calcul de coefficiant de a
	a(k) = quadcc(f1, -pi, pi)/pi; # coefficient a(k)
	f2 = @(x) sin(k*x).*s(x); # fonction pour le calcul de coefficiant de b
	b(k) = quadcc(f2,-pi,pi)/pi; # coefficiant b(k)
	result += a(k)*cos(k*t) + b(k)*sin(k*t); 
endfor
plot(t, s(per(t)),t, result); # affichage resultat
#print -djpg image.jpg
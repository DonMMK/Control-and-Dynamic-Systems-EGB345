function Gcl = PoleChange(K)
Km = 7.09;
alpha = 4.27;
Numerator = Km;
Denominator = [1 alpha 0];
Gs = tf(Numerator, Denominator);
Hs = 1;
Gcl = feedback(K*Gs, Hs*1);
end
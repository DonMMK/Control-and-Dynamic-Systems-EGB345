K = 1;
Km = 7.09;
alpha = 4.27;

Numerator = Km;
Denominator = [1 alpha 0];

Gs = tf(Numerator, Denominator);
Hs = 1;

%Gcl = (Gs / (1 + Gs * Hs) );
Gcl = feedback(Gs, Hs);

stepplot(Gcl);
stepinfo(Gcl)
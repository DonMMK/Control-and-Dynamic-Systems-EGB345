K = 5.4;
Km = 7.09;
alpha = 4.27;

Numerator = Km;
Denominator = [1 alpha 0];

Gl = tf([1 4.27], [1 8.54]) ;
Gs = tf(Numerator, Denominator);
G = Gl * Gs;
Hs = 1;

%Gcl = (Gs / (1 + Gs * Hs) );
Gcl = feedback(K*G, Hs);

stepplot(Gcl);
stepinfo(Gcl)
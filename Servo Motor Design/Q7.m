K = 1.35;
Km = 7.09;
alpha = 4.27;

Numerator = Km;
Denominator = [1.0000   12.8100   36.4700         0];
Denominator2 = [1.0000 46.9700 182.3000 0];

Gs = tf(Numerator, Denominator);
Gs2 = tf(Numerator, Denominator2);
Hs = 1;

%Gcl = (Gs / (1 + Gs * Hs) );
Gcl = feedback(K*Gs, Hs);
Gcl2 = feedback(K*Gs2, Hs);
hold on
stepplot(Gcl);
stepinfo(Gcl)
stepplot(Gcl2);
stepinfo(Gcl2)

hold off
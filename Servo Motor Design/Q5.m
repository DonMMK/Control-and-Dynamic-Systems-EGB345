K = 0.994;

%% Case 1 
Km = 7.09 * 0.9;
alpha = 4.27 * 0.9;

Numerator = Km;
Denominator = [1 alpha 0];

Gs = tf(Numerator, Denominator);
Hs = 1;

%Gcl = (Gs / (1 + Gs * Hs) );
Gcl = feedback(K*Gs, Hs);
figure(1)
stepplot(Gcl);
stepinfo(Gcl)

%% Case 2
Km = 7.09 * 0.9;
alpha = 4.27 * 1.1;

Numerator = Km;
Denominator = [1 alpha 0];

Gs = tf(Numerator, Denominator);
Hs = 1;

%Gcl = (Gs / (1 + Gs * Hs) );
Gcl = feedback(K*Gs, Hs);
figure(2)
stepplot(Gcl);
stepinfo(Gcl)

%% Case 3
Km = 7.09 * 1.1;
alpha = 4.27 * 0.9;

Numerator = Km;
Denominator = [1 alpha 0];

Gs = tf(Numerator, Denominator);
Hs = 1;

%Gcl = (Gs / (1 + Gs * Hs) );
Gcl = feedback(K*Gs, Hs);

figure(3)
stepplot(Gcl);
stepinfo(Gcl)

%% Case 4
Km = 7.09 * 1.1;
alpha = 4.27 * 1.1;

Numerator = Km;
Denominator = [1 alpha 0];

Gs = tf(Numerator, Denominator);
Hs = 1;

%Gcl = (Gs / (1 + Gs * Hs) );
Gcl = feedback(K*Gs, Hs);
figure(4)
stepplot(Gcl);
stepinfo(Gcl)
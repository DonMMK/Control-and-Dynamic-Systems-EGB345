Kinit = 1.35;

% Drop 10% 
figure(1)
K = Kinit * 0.9;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)

% Drop 20% 
figure(2)
K = Kinit * 0.8;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)

% Drop 30% 
figure(3)
K = Kinit * 0.7;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)

% Drop 40% 
figure(4)
K = Kinit * 0.6;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)

% Drop 50% 
figure(5)
K = Kinit * 0.5;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)

% Rise 10% 
figure(6)
K = Kinit * 1.1;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)

% Rise 20% 
figure(7)
K = Kinit * 1.2;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)

% Rise 30% 
figure(8)
K = Kinit * 1.3;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)

% Rise 40% 
figure(9)
K = Kinit * 1.4;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)

% Rise 50% 
figure(10)
K = Kinit * 1.5;
Gcl = PoleChange(K)
pole(Gcl)
stepplot(Gcl)


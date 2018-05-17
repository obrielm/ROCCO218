[t, Vs] = GenSquare(5,1000,0.4);

samplingRate = 1000;

R = 1000;

C = 100e-6;

h = 1/samplingRate;

Vc  = Get_Capacitor_Voltage(R, C, Vs, h);

figure 

hold on

plot(t, Vc, 'b')

plot(t, Vs, 'r')


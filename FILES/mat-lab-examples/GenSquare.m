function [t, y] = GenSquare(frequency, sampleRate, duration )

%SR = 1/sampleRate;

t = 0:SR:duration;
y = square(2*pi*frequency*t);

plot(t, y, '-or');

end

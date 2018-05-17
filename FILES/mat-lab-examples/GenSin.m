function [ ] = GenSin(frequency, sampleRate, duration )

SR = 1/sampleRate;

t = 0:SR:duration;
y = sin(2*pi*frequency*t);

plot(t, y)

end

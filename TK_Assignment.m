%AB-CDEFG-H
%18-36611-1
clc
clear
close all

% Digital Signal plotting

Transmitted_Message = 'Hasib';
x = asc2bn(Transmitted_Message);
bp = 1;
bit =[];
for n = 1:1:length(x)
    if x(n)==1
        se = 3*ones(1,100);
    else x(n)==0
        se = zeros(1,100);
    end
    bit = [bit se];
end
t1 = bp/100:bp/100:bp*length(x);
subplot(4,1,1)
plot(t1,bit,'LineWidth',2.5)
axis([0 bp*length(x) -.5 6])
ylabel('amplitude(volt)')
xlabel('time(sec)')
title('Transmitting Signal at Transmitter')

% ASK Modulation

A1 = 3;
A2 = 0;
br = 1/bp;
f = br*10;

t2 = bp/99:bp/99:bp;
ss = length(t2);

m = []
for i = 1:1:length(x)
    if x(i)==1
        y = A1*cos(2*pi*f*t2);
    else x(i)==0
        y = A2*cos(2*pi*f*t2);
    end
    m = [m y];
end
t3 = bp/99:bp/99:bp*length(x);
subplot(4,1,2)
plot(t3,m)
axis([0 bp*length(x) -6 6])
xlabel('time(sec)')
ylabel('amplitude(volt)')
title('Transmitting Signal After ASK Modulation');

% Signal With AWGN Noise

t4 = bp/99:bp/99:bp*length(x);
mr = awgn(m,18);   %AB = 18
subplot(4,1,3)
plot(t4,mr)
axis([0 bp*length(x) -6 6])
xlabel('time(sec)')
ylabel('amplitude(volt)')
title('Recieved Signal at Reciever')

% ASK demodulation

mn=[];
for n = ss:ss:length(mr)
    t = bp/99:bp/99:bp;
    y = cos(2*pi*f*t);
    mm = y.*mr((n-(ss-1)):n);
    t5 = bp/99:bp/99:bp;
    z = trapz(t5,mm);
    zz = round((2*z/bp));
    if zz>1.5
        a = 1;
    else
        a = 0;
    end
    mn = [mn a];
end


bit =[];
for n = 1:length(mn)
    if mn(n)==1
        se = 3*ones(1,100);
    else
        se = zeros(1,100);
    end
    bit = [bit se];
end
t5 = bp/100:bp/100:bp*length(mn);
subplot(4,1,4)
plot(t5,bit,'LineWidth',2.5)
grid on;
ylabel('Amplitude(volt')
xlabel('Time(sec)')
title('Demodulated Signal at Reciever')

% Converting Information bit to ASCII

Received_Message = bin2asc(mn)      
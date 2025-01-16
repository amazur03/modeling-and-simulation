clear all;
close all;

% ----------- I CZĘŚĆ: Wartości nominalne -----------

% Wartości nominalne
TzewN = -20; % Temperatura zewnętrzna nominalna [°C]
TwewN = 20;  % Temperatura wewnętrzna nominalna [°C]
TpN = 15;    % Temperatura poddasza nominalna [°C]
Ppu = 100;   % Powierzchnia użytkowa [m^2]
H = 2.5;     % Wysokość pomieszczenia [m]
Vw = Ppu * H; % Objętość powietrza wewnętrznego [m^3]
Vp = Vw / 4; % Objętość powierzchni wewnętrznych [m^3]
cpp = 1000;  % Ciepło właściwe powietrza [J/(kg*K)]
roo = 1.2;   % Gęstość powietrza [kg/m^3]
PgN = 10000; % Moc grzewcza nominalna [W]
a = 3;       % Stała dla strumienia cieplnego (K1 = 3Kp)

% Identyfikacja parametrów statycznych
Kp = PgN / (a * (TwewN - TzewN) + (TwewN - TpN)); % Stała przenikania ciepła przez ściany [W/K]
Kd = (Kp * (TwewN - TpN)) / (TpN - TzewN);       % Stała przenikania ciepła przez poddasze [W/K]
K1 = a * Kp;                                     % Stała dla strumienia cieplnego [W/K]

% Parametry dynamiczne
Cvw = cpp * roo * Vw; % Pojemność cieplna powietrza wewnętrznego [J/K]
Cvp = cpp * roo * Vp; % Pojemność cieplna poddasza [J/K]

% ----------- II CZĘŚĆ: Warunki początkowe -----------

% Warunki początkowe
Tzew0 = TzewN; % Temperatura zewnętrzna początkowa [°C]
Pg0 = PgN;     % Moc grzewcza początkowa [W]

% Stan równowagi
Twew0 = (Pg0 / (K1 + (Kp * Kd) / (Kp + Kd))) + Tzew0;
Tp0 = (Kp / (Kp + Kd)) * (Pg0 / (K1 + (Kp * Kd) / (Kp + Kd))) + Tzew0;

% ----------- III CZĘŚĆ: Symulacja -------------------

czas = 15000;        % Czas symulacji [s]
czas_skok = 1500;    % Czas skoku zakłócenia [s]

dTzew = 0;           % Zakłócenie temperatury zewnętrznej
dPg = 0.1 * PgN;     % Zakłócenie mocy grzewczej

% Symulacja
fig1 = figure();
hold on;
grid on;
xlabel('Czas [s]');
ylabel('Temperatura [°C]');
title('Temperatura poddasza');

% Parametry symulacyjne
k = 3.5 / dPg;
T = 3000;

% Model symulacyjny lab1s
[out] = sim('lab1s.slx', czas);
plot(out.tout, out.aTp, 'r', 'DisplayName', 'Obiekt');

% Model symulacyjny lab2_2s
[out1] = sim('lab2s.slx', czas);
plot(out1.tout, out1.simout, 'g', 'DisplayName', 'Model');

legend;
hold off;
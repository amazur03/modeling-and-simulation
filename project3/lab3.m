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
Kd = (Kp * (TwewN - TpN)) / (TpN - TzewN);        % Stała przenikania ciepła przez poddasze [W/K]
K1 = a * Kp;                                      % Stała dla strumienia cieplnego [W/K]

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
% Parametry symulacji
czas = 15000;        % Czas symulacji [s]
czas_skok = 1500;    % Czas skoku zakłócenia [s]

dTzew = 0; %0 10     % Zakłócenie temperatury zewnętrznej
dPg = 0.1 * PgN;     % Zakłócenie mocy grzewczej

% Parametry identyfikacji
k = 3.5 / ((1/10) * PgN);
T = 3000;
T0 = 250;

% Nastawy Zieglera-Nicholsa
RKp = (0.9 * T) / (k * T0);
Ti = 3.33 * T0;
SP0 = Tp0;
dSP = 10; % 0 10
Cv0 = Pg0;

% ----------- III CZĘŚĆ: Symulacja -------------------
[out] = sim('lab3s.slx', czas); % Model symulacyjny

% Wykresy
fig1 = figure(); hold on; grid on;
xlabel('Czas [s]');
ylabel('Temperatura [°C]');
title("Wykres Tp dla skoku dTzew = 10");
plot(out.tout, out.aTp, 'r');

fig2 = figure(); hold on; grid on;
xlabel('Czas [s]');
ylabel('Temperatura [°C]');
title("Wykres Pg dla skoku dTzew = 10");
plot(out.tout, out.aPg, 'b');
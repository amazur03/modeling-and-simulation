clear all
close all

%---------I czesc-------------

%wartosci nominalne
TzewN = -20; % Temperatura zewnętrzna nominalna [°C]
TwewN = 20;  % Temperatura wewnętrzna nominalna [°C]
TpN = 15;    % Temperatura poddasza nominalna [°C]
Ppu = 100;   % Powierzchnia użytkowa [m^2]
H = 2.5;     % Wysokość pomieszczenia [m]
Vw = Ppu * H; % Objętość powietrza wewnętrznego [m^3]
Vp = 1/4 * Vw; % Objętość powierzchni wewnętrznych [m^3]
cpp = 1000;  % Ciepło właściwe powietrza [J/(kg*K)]
roo = 1.2;   % Gęstość powietrza [kg/m^3]
PgN = 10000; % Moc grzewcza nominalna [W]
a = 3;       % Stała dla strumienia cieplnego (K1 = 3Kp)

% identyfikacja parametrow statycznych
Kp = PgN / (a * (TwewN - TzewN) + (TwewN - TpN)); % Stała przenikania ciepła przez ściany [W/K]
Kd = (Kp * (TwewN - TpN)) / (TpN - TzewN);       % Stała przenikania ciepła przez poddasze [W/K]
K1 = a * Kp;  % Stała dla strumienia cieplnego [W/K]

% parametry dynamiczne
Cvw = cpp * roo * Vw; % Pojemność cieplna powietrza wewnętrznego [J/K]
Cvp = cpp * roo * Vp; % Pojemność cieplna poddasza [J/K]

%--------II czesc-------------

% warunki poczatkowe
Tzew0 = TzewN; % Temperatura zewnętrzna początkowa [°C]
Pg0 = PgN;     % Moc grzewcza początkowa [W]

% stan rownowagi
Twew0 = (Pg0 / (K1 + (Kp * Kd) / (Kp + Kd))) + Tzew0;
Tp0 = (Kp / (Kp + Kd)) * (Pg0 / (K1 + (Kp * Kd) / (Kp + Kd))) + Tzew0;

%------------III czesc ----------
czas = 15000; % Czas symulacji
%zaklocenie
czas_skok = 1500;
dTzew = 0; %0 1
dPg = 1/10 * PgN; %0, 1/10 * PgN

tab_Tzew = [TzewN, TzewN + 10, TzewN + 10];
tabl_Pg = [PgN, PgN, PgN * 0.2];
kolor = ['r', 'g', 'b', 'c', 'm', 'k'];

% symulacja

fig1 = figure(); hold on; grid on;
xlabel('Czas [s]');
ylabel('Temperatura wewnętrzna [°C]');
title("Zmiana temperatury wewnętrznej (Twew)");

fig2 = figure(); hold on; grid on;
xlabel('Czas [s]');
ylabel('Temperatura poddasza [°C]');
title("Zmiana temperatury poddasza (Tp)");

fig3 = figure(); hold on; grid on;
xlabel('Czas [s]');
ylabel('Różnica temperatur (Twew - Twew0) [°C]');
title("Różnica temperatury wewnętrznej od stanu początkowego");

fig4 = figure(); hold on; grid on;
xlabel('Czas [s]');
ylabel('Różnica temperatur (Tp - Tp0) [°C]');
title("Różnica temperatury poddasza od stanu początkowego");

legend_entries = {'TzewN, PgN', 'TzewN + 10, PgN', 'TzewN, PgN * 0.2'};

for i = 1:3
    Tzew0 = tab_Tzew(i);
    Pg0 = tabl_Pg(i);
    Twew0 = (Pg0 / (K1 + (Kp * Kd) / (Kp + Kd))) + Tzew0;
    Tp0 = (Kp / (Kp + Kd)) * (Pg0 / (K1 + (Kp * Kd) / (Kp + Kd))) + Tzew0;
    [out] = sim('lab1s.slx', czas); % Model symulacyjny
    
    figure(fig1), plot(out.tout, out.aTwew, kolor(i), 'DisplayName', legend_entries{i});
    figure(fig2), plot(out.tout, out.aTp, kolor(i), 'DisplayName', legend_entries{i});
    figure(fig3), plot(out.tout, out.aTwew - Twew0, kolor(i), 'DisplayName', legend_entries{i});
    figure(fig4), plot(out.tout, out.aTp - Tp0, kolor(i), 'DisplayName', legend_entries{i});
end

% Dodanie legendy do wszystkich wykresów
figure(fig1), legend show;
figure(fig2), legend show;
figure(fig3), legend show;
figure(fig4), legend show;
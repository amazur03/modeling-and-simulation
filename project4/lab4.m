clear all;
close all;

%---------- ODPOWIEDŹ SKOKOWA ----------
% Parametry symulacji - odpowiedź skokowa
U0 = 0;
dU = 5;         % Wartość skoku
x0 = U0;
x_prim0 = 0;
ksi = -0.75;    % Współczynnik tłumienia % 2, 0.1, 0, -0.75, -2
omega_n = 0.5;  % Częstotliwość własna

czas_skok = 20; % Czas skoku
czas_sim = 200; % Czas symulacji skoku

% Symulacja odpowiedzi skokowej
out = sim('lab4s.slx', czas_sim);

% Wykres - odpowiedź skokowa
fig1 = figure();
hold on;
grid on;
xlabel('Czas [s]');
ylabel('X');
title('Odpowiedź skokowa dla dU = 5');
plot(out.tout, out.simout_x, 'r');  % Wykres X w funkcji czasu
legend('Odpowiedź skokowa', 'Location', 'Best');

%---------- TRAJEKTORIE ----------
% Parametry symulacji - trajektorie
dU = 0;                    % Wartość skoku
tab_U = [5, 5];            % Warunki początkowe X0
tabl_x_prim0 = [5, -5];    % Warunki początkowe X0'
kolory = {'r', 'g', 'b', 'c', 'm', 'k'}; % Lista kolorów dla wykresów
czas_sim = 250;            % Czas symulacji trajektorii

% Wykres - trajektorie
fig2 = figure();
hold on;
grid on;
xlabel('X');
ylabel("X'");
title('Wykres trajektorii');

% Pętla rysująca trajektorie dla różnych warunków początkowych
for i = 1:length(tab_U)
    U = tab_U(i);
    x_prim0 = tabl_x_prim0(i);
    out = sim('lab4s.slx', czas_sim);
    plot(out.simout_x, out.simout_dx, 'Color', kolory{i}); % Trajektoria - Wykres X w funkcji X'
end
legend({'Trajektoria 1', 'Trajektoria 2'}, 'Location', 'Best');
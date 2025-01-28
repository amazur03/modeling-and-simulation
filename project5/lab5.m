clear all;
close all;

% ---------- Parametry ----------
u = 5;
x = 1;
x_prim = 1;

% ---------- Parametry symulacji ----------
czas_sim = 50;
kolory = {'r', 'g', 'b', 'c', 'm', 'k'};    % Lista kolorów dla wykresów
style = {'-', '-.', ':'};                   % Lista stylów linii
tab_x = [1, -2, 2];                         % Warunki początkowe X0
tab_dx = [1, 4, -1];                        % Warunki początkowe X0'
tab_u = [0.5, 2.5, 5];                      % Różne wartości mi

% ---------- X w funkcji czasu ----------
fig1 = figure();
hold on;
grid on;
xlabel('Czas [s]');
ylabel('X');
title('X w funkcji czasu');

% Pętla rysująca dla różnych warunków początkowych
for i = 1:length(tab_u)
    x = tab_x(i);
    x_prim = tab_dx(i);
    %u = tab_u(i);
    out = sim('lab5s.slx', czas_sim);
    plot(out.tout, out.simout_x, 'Color', kolory{i}, 'LineStyle', style{i}); % Trajektoria - Wykres X w funkcji X'
end
legend({'Trajektoria 1', 'Trajektoria 2', 'Trajektoria 3'}, 'Location', 'Best');
%legend({'mi = 0.5', 'mi = 2.5', 'mi = 5'}, 'Location', 'Best');


% ---------- Wykres trajektorii ----------
fig2 = figure();
hold on;
grid on;
xlabel('X');
ylabel("X'");
title('Wykres trajektorii');

% Pętla rysująca trajektorie dla różnych warunków początkowych
for i = 1:length(tab_u)
    x = tab_x(i);
    x_prim = tab_dx(i);
    %u = tab_u(i);
    out = sim('lab5s.slx', czas_sim);
    plot(out.simout_x, out.simout_dx, 'Color', kolory{i}, 'LineStyle', style{i}); % Trajektoria - Wykres X w funkcji X'
end
legend({'Trajektoria 1', 'Trajektoria 2', 'Trajektoria 3'}, 'Location', 'Best');
%legend({'mi = 0.5', 'mi = 2.5', 'mi = 5'}, 'Location', 'Best');
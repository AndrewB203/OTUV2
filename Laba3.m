%% Лабораторная работа №3
% Определение запасов устойчивости по критерию Найквиста и диаграммам Боде

clear all;
close all;
clc;

%% Исходные данные
T1 = 0.7;
K1 = 1.6;
T = 0.1;
K = 0;

%% 1. Передаточные функции
% Разомкнутая система: W(s) = K1 / (T1*s + 1)
num = K1;
den = [T1 1];
W_open = tf(num, den);

% Замкнутая система с единичной обратной связью: W_closed = W_open / (1 + W_open)
W_closed = feedback(W_open, 1);

%% 2. Построение годографа Найквиста вручную
omega = logspace(-2, 2, 1000); % Частоты от 0.01 до 100 рад/с
[re, im] = nyquist(W_open, omega);
re = squeeze(re);
im = squeeze(im);

figure;
plot(re, im, 'b', 'LineWidth', 1.5);
hold on;
plot(-1, 0, 'ro', 'MarkerSize', 10, 'LineWidth', 2); % Критическая точка (-1, j0)
xlabel('Re(W(j\omega))');
ylabel('Im(W(j\omega))');
title('Годограф Найквиста (ручной расчет)');
grid on;
axis equal;

% Определение запасов устойчивости
[~, idx] = min(abs(im)); % Точка пересечения с действительной осью
h = 1 + re(idx); % Запас по амплитуде
phi = 180 + angle(re(idx) + 1i*im(idx)) * 180/pi; % Запас по фазе (в градусах)

disp(['Запас устойчивости по амплитуде (h): ', num2str(h)]);
disp(['Запас устойчивости по фазе (φ): ', num2str(phi), '°']);

%% 3. Построение годографа Найквиста с помощью функции nyquist
figure;
nyquist(W_open);
title('Годограф Найквиста (функция nyquist)');
grid on;

%% 4. Построение диаграммы Боде
figure;
bode(W_open);
title('Диаграмма Боде разомкнутой системы');
grid on;

% Определение запасов устойчивости по Боде
[mag, phase, w] = bode(W_open, omega);
mag = squeeze(mag);
phase = squeeze(phase);

% Запас по фазе: частота, где |W(jω)| = 1 (0 dB)
[~, idx_crossover] = min(abs(mag - 1));
phase_margin = 180 + phase(idx_crossover);

% Запас по амплитуде: минимальное расстояние до 0 dB при фазе = -180°
idx_phase_180 = find(phase <= -180, 1);
if ~isempty(idx_phase_180)
    gain_margin = 20*log10(1/mag(idx_phase_180));
else
    gain_margin = Inf; % Система не пересекает -180°
end

disp(['Запас по фазе (по Боде): ', num2str(phase_margin), '°']);
disp(['Запас по амплитуде (по Боде): ', num2str(gain_margin), ' dB']);

%% Выводы
disp('----------------------------------------');
disp('Выводы:');
disp('1. Запасы устойчивости, полученные по годографу Найквиста и диаграмме Боде, должны совпадать.');
disp('2. Система устойчива, если годограф не охватывает точку (-1, j0).');
disp('3. Чем больше запасы (h и φ), тем дальше система от границы устойчивости.');
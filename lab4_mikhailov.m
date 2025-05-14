%% Построение годографа Михайлова
lab4_init; % Загрузка параметров

syms s K T;
Q = T*s + 1 + K; % Характеристическое уравнение

% Построение для начальных условий (T=0.1, K=0)
Q_init = subs(Q, [T, K], [0.1, 0]);
omega = 0:0.01:100;
Q_jw = subs(Q_init, s, 1i*omega);

figure;
plot(real(Q_jw), imag(Q_jw), 'b', 'LineWidth', 1.5);
hold on;
plot(0, 0, 'ro', 'MarkerSize', 10);
xlabel('Re(Q(j\omega))');
ylabel('Im(Q(j\omega))');
title('Годограф Михайлова (T=0.1, K=0)');
grid on;
axis equal;
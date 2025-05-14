%% Построение границы устойчивости Kкр = f(T)
lab4_init;

% Расчет критического коэффициента усиления
K_critical = 1 ./ T_range; % Для системы 1-го порядка

figure;
plot(T_range, K_critical, 'k-', 'LineWidth', 2);
hold on;
plot(T_A1, K_A1, 'ro', 'MarkerSize', 10); % Точка A1
plot(T_A2, K_A2, 'bo', 'MarkerSize', 10); % Точка A2
plot(T_A3, K_A3, 'go', 'MarkerSize', 10); % Точка A3

xlabel('Постоянная времени T');
ylabel('K_{кр}');
title('Граница устойчивости K_{кр} = 1/T');
legend('K_{кр}', 'A1 (уст.)', 'A2 (неуст.)', 'A3 (граница)');
grid on;
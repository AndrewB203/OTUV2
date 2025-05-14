%% Анализ характеристик для трех точек
lab4_init;

% Создание передаточных функций
W_A1 = tf(K_A1, [T_A1 1]);
W_A2 = tf(K_A2, [T_A2 1]);
W_A3 = tf(K_A3, [T_A3 1]);

systems = {W_A1, W_A2, W_A3};
colors = {'r', 'b', 'g'};
legends = {'A1 (устойчивая)', 'A2 (неустойчивая)', 'A3 (граница)'};

%% 1. Переходные характеристики
figure;
hold on;
for i = 1:3
    step(systems{i}, colors{i});
end
title('Переходные характеристики');
legend(legends);
grid on;

%% 2. Импульсные характеристики
figure;
hold on;
for i = 1:3
    impulse(systems{i}, colors{i});
end
title('Импульсные характеристики');
legend(legends);
grid on;

%% 3. Диаграммы Боде
figure;
hold on;
for i = 1:3
    bode(systems{i}, colors{i});
end
title('Диаграммы Боде');
legend(legends);
grid on;

%% 4. Годографы Найквиста
figure;
hold on;
for i = 1:3
    nyquist(systems{i}, colors{i});
end
title('Годографы Найквиста');
legend(legends);
grid on;
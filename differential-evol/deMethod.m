function [P, jP] = deMethod (fobj, lb, ub, N)

% Inicialização
tMax = 100; % Máximo de gerações
n = 2;


C = 0.9; % Prob. recombinação [0.6 0.9]
F = 0.8; % Fator de escala [0.8 0.99]

P = randi([lb(1) ub(1)], N, n); % População
jP = cellfun(fobj, num2cell(P, 2));
t = 1; % Contador de geração

jPAvg = zeros(tMax, 1);
jPBest = zeros(tMax,1);

while (t <= tMax)
	for (i = 1:N)
		r = randperm(N, 3);
		delta = randi(n);
		for (j = 1:n)
			if ((rand() <= C) || (j == delta))
				U(i, j) = P(r(1), j) + F*(P(r(2), j) - P(r(3), j));
			else
				U(i, j) = P(i, j);
			end
		end
		if (fobj(U(i, :)) <= fobj(P(i, :)))
			P(i, :) = U(i, :);
		end
	end
	jP = cellfun(fobj, num2cell(P, 2));
	plotar(fobj, lb, ub, t, P', jP');

	jPBest(t) = min(jP);
	jPAvg(t) = mean(jP);
	t = t + 1;
end

figure(1);
plot(1:tMax, jPBest);
hold('on')
plot(1:tMax, jPAvg);

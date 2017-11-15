function [xbest, jxbest, nfe] = evolMethod(cap, popSize)
% cap: capacidade da mochila
% popSize: tamanho da população

objWeights = [10,18,12,14,13,11,8,6];
objValues = [5,8,7,6,9,5,4,3];
nObjs = length(objWeights);

pc = 0.75; % probabilidade de cruzamento
pm = 0.085; % probabilidade de mutação
maxGen = 100; % número de gerações

pop = zeros(popSize, nObjs);
jPop = zeros(popSize, 1);
for i = 1:popSize
	pop(i,:) = randi([0 1], nObjs, 1);
	jPop(i) = fitness_ksp(pop(i,:), objValues, objWeights, cap);
end
iter = 0;

jPopAvg = zeros(maxGen, 1);
jPopBest = zeros(maxGen, 1);

while (iter < maxGen)
	
	iter = iter + 1;
	
	for (i = 1: popSize)
		jPop(i) = fitness_ksp(pop(i,:), objValues, objWeights, cap);
	end

	jPopAvg(iter) = mean(jPop);
	jPopBest(iter) = max(jPop);

	% Passo 1
	parents = selectParents(pop, jPop, pc);
	
	% Passo 2
	nParents = size(parents)(1);
	allOffspring = zeros(size(parents));
	for (i = 1:2:(nParents-1))
		selectedParents = [parents(i, :) ; parents(i+1, :)];
		offspring = CutAndCrossfill_Crossover(parents);
		allOffspring(i,:) = offspring(1,:);
		allOffspring(i+1,:) = offspring(2,:);
	end

	
	nOffspring = size(allOffspring)(1);
	probOffspring = zeros(nOffspring,1);
	for (i = 1:nOffspring)
		probOffspring(i) = rand();
	end
	aliveOffspring = allOffspring((probOffspring < pc),:);
	
	% Passo 3
	offspring = chernobyl(aliveOffspring, pm);

	% Passos 4 e 5
	nAliveOffspring = size(aliveOffspring)(1);
	pop = pop(nAliveOffspring:end, :);
	pop = vertcat(pop, offspring);

end

% Plota a evolução
plot(1:iter, jPopBest(1:iter));
hold('on')
plot(1:iter, jPopAvg(1:iter));

xbest = pop;
jxbest = max(jPopBest);
nfe = iter;

function [xbest, jxbest, nfe] = evolMethod(cap, popSize)
% cap: capacidade da mochila
% popSize: tamanho da população

objWeights = [10,18,12,14,13,11,8,6];
objValues = [5,8,7,6,9,5,4,3];
objs = [objWeights objValues];
nObjs = size(objs)(1);

pc = 0.8; % probabilidade de cruzamento
pm = 0.1; % probabilidade de mutação
maxGen = 1000; % número de gerações

pop = zeros(popSize, nObjs);
jPop = zeros(popSize, 1);
for i = 1:popSize
	pop(i,:) = randi([0 1], nObjs, 1);
	jPop(i) = fitness_ksp(pop(i,:), objValues, objWeights, cap);
end

iter = 0;
stagnantIter = 0;

jPopAvg = zeros(maxGen, 1);
jPopBest = zeros(maxGen, 1);

while ((iter < maxGen) && (stagnantIter < 20))
	
	iter = iter + 1;
	
	for (i = 1: popSize)
		jPop(i) = fitness_ksp(pop(i,:), objValues, objWeights, cap);
	end

	jPopAvg(iter) = mean(jPop);
	jPopBest(iter) = min(jPop);
	
	if ((iter > 2) && (jPopBest(iter) == jPopBest(iter-1)))
		stagnantIter = stagnantIter + 1;
	else
		stagnantIter = 0;
	end

	% Passo 1
	parents = selectParents(pop, jPop, pc);
	
	% Passo 2
	allOffspring = cellfun(@CutAndCrossfill_Crossover, num2cell(parents,2));
	
	nOffspring = size(allOffspring)(1);
	probOffspring = zeros(nOffspring,1);
	for (i = 1:nOffspring)
		probOffspring = rand();
	end
		
	aliveOffspring = allOffspring((probOffspring > pc),:);

	% Passo 3
	offspring = chernobyl(offspring, pm);

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
jxbest = cellfun(@fitness_nq,num2cell(pop,2));
nfe = iter;

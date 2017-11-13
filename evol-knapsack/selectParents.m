function parents = selectParents(pop, jPop, pc)

% Seleciona os pais usando uma roleta proporcional ao fitness

popSize = size(pop)(1);
nTurns = popSize/2;
selectedParents = zeros(nTurns,2);

% Montando a roleta
rouletteSum = floor(sum(jPop));


roulette = zeros(rouletteSum, 1);

lastPos = 1;
for (i = 1:popSize)
	nRoulettePos = jPop(i);
	for (j = 1:nRoulettePos)
		roulette(lastPos) = i;
		lastPos = lastPos + 1;
	end
end

% Rodando a roleta
for (i = 1:nTurns)
	selectedParents(i,:) = randperm(rouletteSum, 2);
end


parents = selectedParents;

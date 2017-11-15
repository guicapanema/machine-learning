function parents = selectParents(pop, jPop, pc)

% Seleciona os pais usando uma roleta proporcional ao fitness

popSize = size(pop)(1);
matingPool = zeros(size(pop));


% Montando a roleta
aVec = jPop/sum(jPop);

currentMember = 1;

while (currentMember <= popSize)
	r = rand();
	i = 0;
	a = 0;
	while(a < r)
		i = i+1;
		a = a + aVec(i);
	end
	matingPool(currentMember,:) = pop(i,:);
	currentMember = currentMember + 1;
end

parents = matingPool;

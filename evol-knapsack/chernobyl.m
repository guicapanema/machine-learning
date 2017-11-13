function mutated = chernobyl(offspring, prob)

for i = 1:size(offspring)(1)
	if (rand(1) <= prob)
		% Muta genes (bit flip)
		index = randperm(size(offspring)(2), 1);
		offspring(i,index) = !offspring(i,index);
	end
end

mutated = offspring;

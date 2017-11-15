function [offspring] = CutAndCrossfill_Crossover(parents) 
% parents = matrix [parent1 ; parent2] where each parent 
% represents a genotype for the N-Queens Problems
% e.g.: parent1 = [ 1 3 5 2 6 4 7 8 ]
    N = size(parents,2);
    offspring = zeros(2,N);
    pos = randi(N-1);   %single point crossover
    offspring(1,1:pos) = parents(1,1:pos);
    offspring(2,1:pos) = parents(2,1:pos);
	offspring(1,pos+1:end) = parents(2,pos+1:end);
	offspring(2,pos+1:end) = parents(1,pos+1:end);
end %End of function

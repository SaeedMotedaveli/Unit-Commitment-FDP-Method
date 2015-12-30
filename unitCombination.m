function UCM = unitCombination(numOfUnit, unitsData)

allPossibleCombination = power(2, numOfUnit);
UCM = zeros(allPossibleCombination, numOfUnit + 2);

for i = 0 : allPossibleCombination - 1
    
    combination = createCombination(i);
    
    sumOfPmax = 0;
    for n = 1 : numOfUnit
        if combination(n) == '1'
            UCM(i+1, n+2) = 1;
            sumOfPmax = sumOfPmax + unitsData(n, 2);
        end
    end
    
    UCM(i+1, 1) = i;
    UCM(i+1, 2) = sumOfPmax;
end

UCM = sortrows(UCM, 2);
for i = 0 : allPossibleCombination - 1
    UCM(i+1, 1) = i;
end

end

    function combination = createCombination(num)
        
        combination = dec2base(num, 2);
        if length(combination) == 1
            combination = ['000', combination];
        elseif length(combination) == 2
            combination = ['00', combination];
        elseif length(combination) == 3
            combination = ['0', combination];
        end
    end

% @author: Saeed Motedaveli

clc;

% Initialize Data
initializeData();

% Units Number
unitsNum = length(units(:, 1));

% Calculate Diffrent Combination of Units.
% for 4 units its like 1111, 1110, ...
UCM = unitCombination(unitsNum, units);

% In state 0 the combination of units is: 0110
startCombination = 12;
numOfTimes = 8;

% Sort Units by Full-Load Ave. Cost
sortedUnits = sortUnits(units);

% Final Result Matrix
result = zeros(length(UCM), 8);
resultCombination = zeros(length(UCM), 8);

IHR = units(:, 4);          % Incremental Heat Rate
NLC = units(:, 5);          % No-Load Cost
FC = fuel_cost;             % Fuel Cost
SUC = unit_status(:, 4);    % Start-Up Cost : Cold

% Calculate Fcost for time 0 to 1
load = load_pattern(1, 2);  % Power that load need it in first hour
for i = length(UCM): -1 : 1
    if UCM(i, 2) < load
        break;
    end
    
    % Save total Cost for stage 1
    result(i, 1) = calculateFcost(UCM, 1, 0, UCM(i, 1), 12, sortedUnits, load, IHR, FC, NLC, SUC);
    % Save minimum combination of Fcost for stage 1
    resultCombination(i, 1) = startCombination;
end

% Calculate Fcost for 1 to numOfTimes
for t = 2 : numOfTimes
    load = load_pattern(t, 2);   % Power that load need it
    
    for i = length(UCM): -1 : 1
        
        if UCM(i, 2) < load
            break;
        end
        
        minFcost = 0;
        minFcostCombination = 0;
        for j = 1 : length(UCM)
            if result(j, t-1) == 0
                continue;
            end
            
            Fcost = calculateFcost(UCM, t, t-1, UCM(i, 1), UCM(j, 1), sortedUnits, load, IHR, FC, NLC, SUC) + result(j, t-1);
            
            if minFcost == 0
                minFcost = Fcost;
                minFcostCombination = j-1;
            elseif minFcost > Fcost
                minFcost = Fcost;
                minFcostCombination = j-1;
            end
            
        end
        
        % Save total Cost
        result(i, t) = minFcost;
        % Save minimum combination of Fcost
        resultCombination(i, t) = minFcostCombination;
        
    end
end

% Print result
fprintf('####################### Minimum Total Cost of every Stage #######################\n\n');
fprintf('     Comb.');
for i = 1 : length(result(1, :))
    fprintf('\t%7.0f', i);
end
fprintf('\n---------------------------------------------------------------------------------\n');
for i = 1 : length(result)
    
    fprintf('  %d\t', UCM(i, 1));
    for k = 3 : length(UCM(1, :))
        fprintf('%d', UCM(i, k));
    end
    
    fprintf(' ');
    
    for j = 1 : length(result(1, :))
        fprintf('\t%7.0f', result(i, j));
    end
    
    fprintf('\n');
end

fprintf('\n\n\n####################### Minimum Combination to every Stage #######################\n\n');
fprintf('     Comb.');
for i = 1 : length(result(1, :))
    fprintf('\t%7.0f', i);
end
fprintf('\n---------------------------------------------------------------------------------\n');
for i = 1 : length(result)
    
    fprintf('  %d\t', UCM(i, 1));
    for k = 3 : length(UCM(1, :))
        fprintf('%d', UCM(i, k));
    end
    
    fprintf(' ');
    
    for j = 1 : length(result(1, :))
        fprintf('\t%7.0f', resultCombination(i, j));
    end
    
    fprintf('\n');
end


bestCombination = zeros(numOfTimes, 1);
for i = 1 : numOfTimes
    
    minOfFcost = 0;
    minCombination = 0;
    for j = length(result) : -1 : 1
        Fcost = result(j, i);
        if Fcost > 0
            if minOfFcost == 0
                minOfFcost = Fcost;
                minCombination = resultCombination(j, i);
            elseif minOfFcost > Fcost
                minOfFcost = Fcost;
                minCombination = resultCombination(j, i);
            end
        end 
    end
    bestCombination(i) = minCombination;
end

fprintf('\n\n\n######################## Best Combination of every Stage ########################\n\n');
for i = 1 : length(result(1, :))
    fprintf('\t%-7s', [int2str(i-1), '->', int2str(i)]);
end
fprintf('\n---------------------------------------------------------------------------------\n');
for i = 1 : length(result(1, :))
    if i == length(result(1, :))
        fprintf('\t%-7s', [int2str(bestCombination(i)), '->', int2str(startCombination)]);
    else
        fprintf('\t%-7s', [int2str(bestCombination(i)), '->', int2str(bestCombination(i+1))]);
    end
end

fprintf('\n\n');

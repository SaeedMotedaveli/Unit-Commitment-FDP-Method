% @author: Saeed Motedaveli

function Fcost = calculateFcost(UCM, CJ, PJ, K, L, unitP, totallP, IHR, fuelCost, noLoadCost, startFromCold)

    % Calculate Pcost
    lc = length(UCM(1, :));
    CC = UCM(K+1, 3 : lc);      % Current Combination
    PC = UCM(L+1, 3 : lc);      % Previous Combination
    Pcost = calculatePcost(CC, unitP, totallP, IHR, fuelCost);
    Pcost = Pcost + CC * noLoadCost;
    
    % Calculate Scost
    Scost = 0;
    if K ~= L
        Scost = calculateScost(CC, PC, startFromCold);
    end
    

    
    Fcost = Pcost + Scost;

end

function Pcost = calculatePcost(combination, unitP, totallP, IHR, fuelCost)

    P = zeros(length(unitP(:,1)), 2);
    P(:, 1) = unitP(:, 1);
    for i = 1 : length(combination)
        if combination(unitP(i)) == 1
            P(i, 2) = unitP(i, 3);
        end
    end

    if  sum(P(:, 2)) ~= totallP
        for n = 1 : length(combination)
            sumP = sum(P(:, 2));
            
            if sumP == totallP
                break;
            elseif combination(P(n,1)) == 1
                P(n,2) = unitP(n, 2);
                sumP = sum(P(:, 2));
                if sumP > totallP
                    P(n, 2) = P(n, 2) - (sumP - totallP);
                end
            end
        end
    end
    
    P = sortrows(P, 1);
    IHR = IHR / 1000;
    
    Pcost = P(:, 2)' * IHR * fuelCost;
end

function Scost = calculateScost(CC, PC, startFromCold)
    Scost = 0;
    
    for i = 1 : length(CC)
        if CC(i) ~= PC(i)
            Scost = Scost + startFromCold(i);
        end
    end
end

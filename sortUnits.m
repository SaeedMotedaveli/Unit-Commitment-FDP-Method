% @author: Saeed Motedaveli

function sortedUnits = sortUnits(units)

sortedUnits = zeros(length(units(:, 1)), 4);
sortedUnits(:, 1) = units(:, 1);
sortedUnits(:, 2) = units(:, 2);
sortedUnits(:, 3) = units(:, 3);
sortedUnits(:, 4) = units(:, 6);
sortedUnits = sortrows(sortedUnits, 4);

end

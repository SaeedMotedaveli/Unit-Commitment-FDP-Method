% @author: Saeed Motedaveli



%                                                      Full-Load     Minimum
%       unit   P_max   P_min     IHR        No-Load    Ave. Cost      Times
%              (MW)    (MW)   (Btu/kWh)   Cost ($/h)   ($/m Wh)     Up   Down  
units = [1      80      25      10440       213.00      23.54       4    2
         2      250     60      9000        585.62      20.34       5    3
         3      300     75      8730        684.74      19.74       5    4
         4      60      20      11900       252.00      28.00       1    1];

     
%             unit    Initial Condition    Hot($) Cold($) Cold Start(h)
unit_status = [1            -5              150     350         4
               2            8               170     400         5
               3            8               500     1100        5
               4            -6              0       0.02        0];
% Initial Condition: Hours Off-Line (-)
%                    Hours On-Line (+)


load_pattern = [1       450
                2       530
                3       600
                4       540
                5       400
                6       280
                7       290
                8       500];

% Fuel Cost ($/MBtu)
fuel_cost = 2;

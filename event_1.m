function [value,isterminal,direction] = event_1(t, y) %
value = [y(1) - 0; y(1) - 5; y(3) - 2; y(3) - 7];
isterminal = [1; 1; 1; 1];
direction = [-1;1;-1; 1];
end
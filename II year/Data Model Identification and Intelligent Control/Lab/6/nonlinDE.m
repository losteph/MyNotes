function y = nonlinDE(y1, y2)
% NONLINDE Equazione alle differenze non lineare
% y(k) = g(y(k-1), y(k-2))

    num = y1 * y2 * (y1 - 0.5);
    den = 1 + (y1^2) * (y2^2);
    
    y = num / den;
end
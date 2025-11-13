function C = jacOutFcn(~,~)
    % Derivative matrix of outputs with respect to states
    C = zeros(1,4);
    C(1,1) = 1;
end
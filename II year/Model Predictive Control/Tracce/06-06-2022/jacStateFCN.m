function [A,B] = jacStateFCN(x,u,params)
    % x1 = xp
    % x2 = yp
    % x3 = theta_p
    % u1 = Vc
    % u2 = omega
    Ts = params(1);
    A = zeros(3,3);
    B = zeros(3,2);

    A(1,1) = 1;
    A(1,3) = -u(1)*sin(x(3))*Ts;
    A(2,2) = 1;
    A(2,3) = u(1)*cos(x(3))*Ts;
    A(3,3) = 1;

    B(1,1) = cos(x(3))*Ts;
    B(2,1) = sin(x(3))*Ts;
    B(3,2) = Ts;
end
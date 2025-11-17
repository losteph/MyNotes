function y = outFunc(x,~)
    hr = 1000;  % meters
    tr = 10.10; % seconds
    Tr = 288.2; % K

    y = zeros(3,1);
    y(1) = x(1)*(hr/tr);
    y(2) = x(2)*hr;
    y(3) = x(3)*Tr - 273.2;
end
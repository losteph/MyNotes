function C = outFuncJac(~,~)
    hr = 1000;  % meters
    tr = 10.10; % seconds
    Tr = 288.2; % K

    C = zeros(3,3);

    C(1,1) = Tr;
    C(2,2) = (hr/tr);
    C(3,3) = hr;
end
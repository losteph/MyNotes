% Plotting
close all;

outputLabels = ["Temperature of Ballon [°C]", "Velocity [m/s]", "Height [m]"];
figure(2); % Output Plots
for i=1:3
    subplot(3,1,i)
    plot(tvec,y_history(:,i));
    grid minor
    hold on
    stairs(tvec,ref_history(:,i));
    xlim([0 240]);
    xlabel("Time [minutes]")
    ylabel(outputLabels(i))
end

figure(3); % MV Plot
stairs(tvec,mv_history)
grid minor
legend("fuel","vent")
ylim([-1 101]);
ylabel("Valve values [%]")
xlabel("Time [minutes]")
title("Manipulated Variables")

figure(5) % Computational Time plot
plot(tvec,c_history);
xlim([0 240]);
grid minor
ylabel("Time to compute  [s]")
xlabel("Time of simulation [minutes]")
title("Computational Time")

figure(4) % Reference plot
stairs(tvec,ref_history(:,3),'LineWidth',2);
grid on
ylim([0 4000]);
xlim([0 240]);
xticks([0 5 30 50 90 130 160 210 240])
yticks([0 1000 2000 3500])
ylabel("Height [m]")
xlabel("Time [minutes]")
title("Reference")
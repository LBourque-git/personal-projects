function[] = plot_temperature(t, Temp_at_point, Temp_at_point_RK)

t = t';
linewidth = 1.5;
hold on;
plot(t,Temp_at_point, 'LineWidth', linewidth, 'Color',  'r');
plot(t,Temp_at_point_RK,'g--', 'LineWidth', linewidth);
xlabel('t [s]');
ylabel('T [K]');
legend('Forward Euler','RK2');
end
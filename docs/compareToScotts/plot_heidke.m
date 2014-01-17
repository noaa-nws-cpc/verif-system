close all;

% Start a new figure
figure('Position',[10 50 600 400]) ; set(gcf,'PaperPositionMode','auto');
set(gcf,'Color','w') ; hold on;
% Set the font size
set(gca,'fontsize',18);
% Plot two data series
plot(date,scott,'k','linewidth',2); hold on;
plot(date,vwt,'b','linewidth',2);
% Format all labels
datetick('x','mmm-dd');
title('VWT Score Comparison');
legend('Scott''s','VWT');
% Save figure
saveas(gcf,'plot_heidke.png','png')
% Orient landscape for vector formats
orient landscape;
% Print vector formats
saveas(gcf,'plot_heidke.pdf','pdf')
saveas(gcf,'plot_heidke.eps','epsc2')
close;

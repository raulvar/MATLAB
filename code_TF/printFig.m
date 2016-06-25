function printFig( fileName )
%printFig Summary of this function goes here
%   Detailed explanation goes here

set(gcf, 'color', 'white');
set(gca,'FontSize',16)

set(gcf,'PaperPositionMode','auto')
pause()
print(fileName,'-depsc2','-r300')


end


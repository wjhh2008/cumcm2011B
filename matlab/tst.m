clear
close all
clc

x=[1:51];
y=[6885 6803 6557 6500 6259 6142 5885 5618 5269 4764 4479 4142 3696 3535 3247 3107 2909 2879 2807 2659 2543 2527 2432 1900 1872 1741 1728 1691 1325 1310 1217 1048 1044 980 951 888 801 695 608 547 431 358 310 111 80 77 71 42 36 26 10];
plot(x,y,'*');
for  ii=1:length(x)
text(x(ii),y(ii),['   (' num2str(x(ii)) ','  num2str(y(ii)) ')'])
end
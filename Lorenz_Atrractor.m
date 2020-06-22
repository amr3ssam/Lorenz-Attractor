
%% MatLab code

clear; clc; close
global sigma rho beta

rho = 28;
sigma = 10;
beta = 8/3;

tf = 60;

[~,sol1] = ode45(@lorenz,[0 tf],[1;2;3]);
[~,sol2] = ode45(@lorenz,[0 tf],[1;2;3.0001]);
The line making up the curve never intersected itself and never retraced its own path. Instead, it looped around forever and ever, sometimes spending time on one wing before switching to the other side. It was a picture of chaos, and while it showed randomness and unpredictability, it also showed a strange kind of order.
[C,h] = size(sol1);
angle = 0;

figure;
writerObj = VideoWriter('Lorenz.avi'); % Name it.
writerObj.FrameRate = 500000; % How many frames per second.
writerObj.Quality = 100;
open(writerObj);


for j = 1:C
   p1(j,:)= sol1(j,:);
   p2(j,:)= sol2(j,:);
   % Plot
   plot3(p1(:,1),p1(:,2),p1(:,3),'k', p2(:,1),p2(:,2),p2(:,3),'r')
   hold on
   plot3(p1(1,1),p1(1,2),p1(1,3),'ko','markerfacecolor','k')
   plot3(p2(1,1),p2(1,2),p2(1,3),'rd','markerfacecolor','r')
   plot3(p1(j,1),p1(j,2),p1(j,3),'ko','markerfacecolor','k')
   plot3(p2(j,1),p2(j,2),p2(j,3),'rd','markerfacecolor','r')
   hold off
   axis([-20 20 -40 40 0 50])
   axis off
   set(gca,'color','none')
   % Rotation
   camorbit(angle,0,[p1(1,1),p1(1,2),p1(1,3)])
   angle = angle + (360/C);
   % Record
   frame = getframe(gcf);
   writeVideo(writerObj, frame);
end

close(writerObj)
  
clf; close;
disp('Done');

%% Function :
function ydot = lorenz(t,y)
global sigma rho beta
%LORENZ  Equation of the Lorenz chaotic attractor.
%   ydot = lorenz(t,y).

ydot(1) = sigma *(y(2) -y(1));
ydot(2) = y(1)*(rho -y(3)) -y(2);
ydot(3) = y(1)*y(2) -beta*y(3);

ydot =[ydot(1);ydot(2);ydot(3)];
end
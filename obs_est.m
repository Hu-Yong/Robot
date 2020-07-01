function [sys,x0,str,ts]=s_function(t,x,u,flag)

switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
global p g
sizes = simsizes;
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 12;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0 0];
str=[];
ts=[];


function sys=mdlDerivatives(t,x,u)   
p=[2.9 0.76 0.87 3.04 0.87];
g=9.8;
L=[200 0;
    0 200];

x2hat=[x(1);x(2)];

q=[u(1);u(3)];
dq=[u(2);u(4)];
vhat=[u(5);u(6)];
tol=[u(7);u(8)];
dhat=[u(9);u(10)];

M=[p(1)+p(2)+2*p(3)*cos(q(2)) p(2)+p(3)*cos(q(2));
    p(2)+p(3)*cos(q(2)) p(2)];
C=[-p(3)*dq(2)*sin(q(2)) -p(3)*(dq(1)+dq(2))*sin(q(2));
     p(3)*dq(1)*sin(q(2))  0];
G=[p(4)*g*cos(q(1))+p(5)*g*cos(q(1)+q(2));
    p(5)*g*cos(q(1)+q(2))];

U=[tol(1) 0;
    0 tol(2)];
x2=dq;
dx2hat=-L*(x2hat-x2)+inv(M)*(U*vhat-C*dq-G)+dhat;


sys(1)=dx2hat(1);
sys(2)=dx2hat(2);

function sys=mdlOutputs(t,x,u)
dq=[u(2);u(4)];
x2=dq;
x2_error=x2-x;

sys(1)=x2_error(1);
sys(2)=x2_error(2);
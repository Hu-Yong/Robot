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
sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0.09 0 -0.09 0];
str=[];
ts=[];

p=[2.9 0.76 0.87 3.04 0.87];
g=9.8;
function sys=mdlDerivatives(t,x,u)   
global p g

 q=[x(1);x(3)];
dq=[x(2);x(4)];

M=[p(1)+p(2)+2*p(3)*cos(q(2)) p(2)+p(3)*cos(q(2));
    p(2)+p(3)*cos(q(2)) p(2)];
C=[-p(3)*dq(2)*sin(q(2)) -p(3)*(dq(1)+dq(2))*sin(q(2));
     p(3)*dq(1)*sin(q(2))  0];
G=[p(4)*g*cos(q(1))+p(5)*g*cos(q(1)+q(2));
    p(5)*g*cos(q(1)+q(2))];
d=[1+0.2*sin(t);1+0.2*sin(t)];

tol=u(1:2);

S=inv(M)*(tol+d-C*dq-G);

sys(1)=x(2);
sys(2)=S(1);
sys(3)=x(4);
sys(4)=S(2);
function sys=mdlOutputs(t,x,u)

sys(1)=x(1);
sys(2)=x(2);
sys(3)=x(3);
sys(4)=x(4);

function [sys,x0,str,ts] = control_strategy(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end

function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 14;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];

p=[2.9 0.76 0.87 3.04 0.87];
g=9.8;

function sys=mdlOutputs(t,x,u)
global p g
k1=60;k2=60;
K2=[60 60;
    60 60];

b1=0.02;b2=0.02;

  qd=[u(1);u(4)];
 dqd=[u(2);u(5)];
ddqd=[u(3);u(6)];

 q=[u(7);u(9)];
dq=[u(8);u(10)];
vhat=[u(11);u(12)];
bd=[u(13);u(14)];

M=[p(1)+p(2)+2*p(3)*cos(q(2)) p(2)+p(3)*cos(q(2));
    p(2)+p(3)*cos(q(2)) p(2)];
C=[-p(3)*dq(2)*sin(q(2)) -p(3)*(dq(1)+dq(2))*sin(q(2));
     p(3)*dq(1)*sin(q(2))  0];
G=[p(4)*g*cos(q(1))+p(5)*g*cos(q(1)+q(2));
    p(5)*g*cos(q(1)+q(2))];

d=M*bd;

e1=q-qd;
alpha=-[k1*e1(1)-dqd(1);k2*e1(2)-dqd(2)];
e2=dq-alpha;
dalpha=[-k1*dq(1)+k1*dqd(1)-ddqd(1);-k2*dq(2)+k2*dqd(2)-ddqd(2)];

tol=(-K2*e2-[e1(1)/(b1^2-e1(1)^2);e1(2)/(b2^2-e1(2)^2)]+C*alpha+G+M*dalpha-d);

sys(1)=tol(1);
sys(2)=tol(2);
sys(3)=e1(1);
sys(4)=e1(2);
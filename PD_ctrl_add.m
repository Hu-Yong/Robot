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
sizes.NumInputs      = 12;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0  = [];
str = [];
ts  = [];


function sys=mdlOutputs(t,x,u)
p=[2.9 0.76 0.87 3.04 0.87];
g=9.8;

  q_d=[u(1);u(4)];
 dq_d=[u(2);u(5)];
ddq_d=[u(3);u(6)];
    q=[u(7);u(9)];
   dq=[u(8);u(10)];
 vhat=[u(11);u(12)];


 e=q-q_d;
de=dq-dq_d;  

M=[p(1)+p(2)+2*p(3)*cos(q(2)) p(2)+p(3)*cos(q(2));
    p(2)+p(3)*cos(q(2)) p(2)];
C=[-p(3)*dq(2)*sin(q(2)) -p(3)*(dq(1)+dq(2))*sin(q(2));
     p(3)*dq(1)*sin(q(2))  0];
G=[p(4)*g*cos(q(1))+p(5)*g*cos(q(1)+q(2));
    p(5)*g*cos(q(1)+q(2))];

    Fai=5*eye(2);
    dqr=dq_d-Fai*e;
    ddqr=ddq_d-Fai*de;
    s=Fai*e+de;
    Kd=100*eye(2);
    if vhat>0
        tol=(1/vhat(1))*(M*ddqr+C*dqr+G-Kd*s);
    else 
        tol=M*ddqr+C*dqr+G-Kd*s;
    end

sys(1)=tol(1);
sys(2)=tol(2);
sys(3)=e(1);
sys(4)=e(2);

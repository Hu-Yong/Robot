function [sys,x0,str,ts]=eso3(t,x,u,flag)

switch flag
    case 0
        [sys,x0,str,ts]=mdlInitializeSizes;
    case 1
        sys=mdlDerivatives(x,u);
    case 3
        sys=mdlOutputs(x);
    case {2,4,9}
        sys=[];
    otherwise 
        error(['Unhandled flag=',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
    sizes=simsizes;
    sizes.NumContStates = 6;
    sizes.NumDiscStates = 0;
    sizes.NumOutputs    = 6;
    sizes.NumInputs     = 8;
    sizes.DirFeedthrough= 0;
    sizes.NumSampleTimes= 1;
    sys=simsizes(sizes);
    x0=[0;0;0;0;0;0];
    str=[];
    ts=[-1 0];
function sys=mdlDerivatives(x,u)

p=[2.9 0.76 0.87 3.04 0.87];
g=9.8;
tol=[u(1);u(2)];
  q=[u(5);u(7)];
  dq=[u(6);u(8)];

M=[p(1)+p(2)+2*p(3)*cos(q(2)) p(2)+p(3)*cos(q(2));
    p(2)+p(3)*cos(q(2)) p(2)];
C=[-p(3)*dq(2)*sin(q(2)) -p(3)*(dq(1)+dq(2))*sin(q(2));
     p(3)*dq(1)*sin(q(2))  0];
G=[p(4)*g*cos(q(1))+p(5)*g*cos(q(1)+q(2));
    p(5)*g*cos(q(1)+q(2))];
b=inv(M);
h=C*dq+G;
f1=-b*h;
d=0.0025;
bet1=[30;24];
bet2=[1000;1000];
bet3=[1500;1500];
z1=[x(1);x(2)];
z2=[x(3);x(4)];
z3=[x(5);x(6)];

    e=z1-q;
    dz1(1)=z2(1)-bet1(1)*e(1);
    dz1(2)=z2(2)-bet1(2)*e(2);
    dz2(1)=f1(1)+z3(1)-bet2(1)*fal(e(1),0.5,d)+b(1,:)*tol;
    dz2(2)=f1(2)+z3(2)-bet2(2)*fal(e(2),0.25,d)+b(2,:)*tol;
    dz3(1)=-bet3(1)*fal(e(1),0.25,d);
    dz3(2)=-bet3(2)*fal(e(2),0.25,d);
    sys(1)=dz1(1);
    sys(2)=dz1(2);
    sys(3)=dz2(1);
    sys(4)=dz2(2);
    sys(5)=dz3(1);
    sys(6)=dz3(2);
function sys=mdlOutputs(x)
    sys(1)=x(1);
    sys(2)=x(2);
    sys(3)=x(3);
    sys(4)=x(4);
    sys(5)=x(5);
    sys(6)=x(6);
function f=fal(e,a,d)
    if abs(e)<d
        f=e*d^(a-1);
    else f=(abs(e))^a*sign(e);
    end
    
        
    
    
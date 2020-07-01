close all;

figure(1);
subplot(211);
plot(out.tout,out.qd.Data(:,1),'--r',out.tout,out.q.Data(:,1),'b');
xlabel('time(s)');ylabel('position tracking for link 1(rad)');
legend('desired trajectory','actual trajectory')
subplot(212);
plot(out.tout,out.qd.Data(:,4),'--r',out.tout,out.q.Data(:,3),'b');
xlabel('time(s)');ylabel('position tracking for link 2(rad)');
legend('desired trajectory','actual trajectory')

figure(2);
subplot(211);
plot(out.tout,out.qd.Data(:,2),'--r',out.tout,out.q.Data(:,2),'b');
xlabel('time(s)');ylabel('speed tracking for link 1(rad/s)');
legend('desired trajectory','actual trajectory')
subplot(212);
plot(out.tout,out.qd.Data(:,5),'--r',out.tout,out.q.Data(:,4),'b');
xlabel('time(s)');ylabel('speed tracking for link 2(rad/s)');
legend('desired trajectory','actual trajectory')

figure(3);
subplot(211);
plot(out.tout,out.e.Data(:,3),'r');
xlabel('time(s)');ylabel('error for link1(rad)');
%hold on 
%line([0,10],[0.02,0.02],'linestyle','--','color','b');
%hold on 
%line([0,10],[-0.02,-0.02],'linestyle','--','color','b');
subplot(212);
plot(out.tout,out.e.Data(:,4),'r');
xlabel('time(s)');ylabel('error for link2(rad)');
%hold on 
%line([0,10],[-0.02,-0.02],'linestyle','--','color','b');
%hold on 
%line([0,10],[-0.04,-0.04],'linestyle','--','color','b');

figure(4);
plot(out.tout,out.eso.Data(:,6),'b');
xlabel('time(s)');ylabel('disturbance(Nm)');


figure(5);
subplot(211);
plot(out.tout,out.rho.Data(:,1),'b');
xlabel('time(s)');ylabel('The fault factor for link 1');
subplot(212);
plot(out.tout,out.rho.Data(:,2),'b');
xlabel('time(s)');ylabel('The fault factor for link 2');


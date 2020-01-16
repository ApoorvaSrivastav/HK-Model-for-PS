% This program gives the estimated value vector Lr(8,1) of brightness of a
% pixel for 8 lighting conditions
Light_info = zeros(8,4); %Array will have first three elements as normal unit vector
                         %and last element as the phi angle
k=5;
d=85e-6;
T12=1.25;
T21=0.8;
sig_s=50e-3;
sig_a=3.8e-3;
rho=.25;
normal_init=[1,1,-1];
cos_theta_i=zeros(8,1);
cos_theta_r=zeros(8,1);
Lr=zeros(8,1);
Li=zeros(8,1);
X=zeros(8,1);
Light_info(1,1:3)=unit_vec([k/2,-k/2,k/2]);
Light_info(2,1:3)=unit_vec([0,-k/2,k/2]);
Light_info(3,1:3)=unit_vec([-k/2,-k/2,k/2]);
Light_info(4,1:3)=unit_vec([-k/2,0,k/2]);
Light_info(5,1:3)=unit_vec([-k/2,k/2,k/2]);
Light_info(6,1:3)=unit_vec([0,k/2,k/2]);
Light_info(7,1:3)=unit_vec([k/2,k/2,k/2]);
Light_info(8,1:3)=unit_vec([k/2,0,k/2]);
Light_info(:,4)=[54.735,45,54.735,45,54.735,45,54.735,45];
for i =1:1:8
cos_theta_i(i)=dot(Light_info(i,1:3),normal_init);
cos_theta_r(i)=dot((2*cos_theta_i(i)*normal_init - Light_info(i,1:3)),normal_init);
end
%Lr=XLi + Y
% X and Y Calculation
for i=1:1:8
    var1=((sig_a+sig_s)*d*(cos_theta_r(i) + cos_theta_i(i)))/(cos_theta_i(i)*cos_theta_r(i));
    var2=sig_a*T12*T21*cos_theta_i(i)*p_calculation(Light_info(i,4));
    var3=1-exp(-var1);
    var_num=var2*var3;
    var_den=(sig_a+sig_s)*(cos_theta_r(i) + cos_theta_i(i));
    X(i)=var_num/var_den;
end
Y=rho*cos_theta_i;
prompt="Enter brightness value of the pixel under each lighting condition and press enter";

for i=1:1:8
    Li(i)=input(prompt);
    Lr(i)=X(i)*Li(i) + Y(i);
end

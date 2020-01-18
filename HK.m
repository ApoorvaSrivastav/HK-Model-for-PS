% This program gives the estimated value vector Lr(8,1) of brightness of a
% pixel for 8 lighting conditions
Light_info = zeros(8,4); %Array will have first three elements as normal unit vector
                         %and last element as the cos_phi of angle between light source and viewing direction 
k=250;
d=.085;
T12=1.25;
T21=0.8;
sig_s=50;
sig_a=3.8;
rho=.25;
normal_init=unit_vec([0,1,-1]);
view_direc=unit_vec([0,0,-1]);
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
Light_info(:,1:3)=-Light_info(:,1:3);


for i =1:1:8
Light_info(i,4)=dot(Light_info(i,1:3),view_direc);
cos_theta_i(i)=dot(Light_info(i,1:3),normal_init);
v1=2*cos_theta_i(i);
v2=v1*normal_init;
cos_theta_r(i)=dot((v2 - Light_info(i,1:3)),normal_init);
end
phi=acosd(Light_info(:,4));
theta_i=acosd(cos_theta_i);
theta_r=acosd(cos_theta_r);
%Lr=XLi + Y
% X and Y Calculation
for i=1:1:8
    var1=((sig_a+sig_s)*d*(cos_theta_r(i) + cos_theta_i(i)))/(cos_theta_i(i)*cos_theta_r(i));
    p=p_calculation(Light_info(i,4));
    var2=sig_a*T12*T21*cos_theta_i(i)*p;
    var3=1-exp(-var1);
    var_num=var2*var3;
    var_den=(sig_a+sig_s)*(cos_theta_r(i) + cos_theta_i(i));
    X(i)=var_num/var_den;
end
Y=rho*cos_theta_i;
%prompt="Enter brightness value of the pixel under each lighting condition and press enter";
Li=[222,230,220,222,212,235,212,210];
for i=1:1:8
    %Li(i)=input(prompt);
    Lr(i)=X(i)*Li(i) + Y(i);
end

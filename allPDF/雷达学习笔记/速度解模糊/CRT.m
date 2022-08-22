%%�ٶȽ�ģ��matlab�����Լ�����
clear;
clc;
clear;
outid = 160; 
%%
for  vid = 1:1:outid   
vreal = (vid -outid/2);  %���������ʵ���ٶ�vreal��Χ:-80-80 km/h

Va_res = 0.3;  %������ά�ٶȷֱ���
Va_res_maxv = Va_res *128; %���������Ƶ������Ϊ128�����A�����ɼ���ٶ�

Vb_res = 0.5; %������ά�ֱ���
Vb_res_maxv = Vb_res *128;  %���������Ƶ������Ϊ128�����B�����ɼ���ٶ�

%ģ���ٶ�
Va_binnum = mod(round(vreal/Va_res),128);  %�������룬��128ȡ�࣬dopperbin����
Vb_binnum = mod(round(vreal/Vb_res),128);

    for i = 1:1:10
        %���Ŀ��ʵ��ģ���ٶ�
        Vout_real(1,i) = Va_binnum*Va_res + (i-5)*Va_res_maxv; 
        Vout_real(2,i) = Vb_binnum*Vb_res + (i-5)*Vb_res_maxv;
    end
    
 min_V = 99;
 out_V = 0;
    
 for i = 1:1:10
       for j=1:1:10
        V_cha = abs(Vout_real(1,i) - Vout_real(2,j)); %���ֵ
         if(abs(Vout_real(1,i)) < 80) && (abs(Vout_real(2,j)) < 80) 
            if(V_cha <min_V)
               min_V =  V_cha;  %ȡ�ٶȲ�ֵ��С
               out_V = Vout_real(1,i); %ȡ��ֵ��С���ٶȽ�
            end
         end               
       end       
 end
 V_list(vid) = out_V;
end
%%
plot(V_list);
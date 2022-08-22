%%速度解模糊matlab代码以及解析
clear;
clc;
clear;
outid = 160; 
%%
for  vid = 1:1:outid   
vreal = (vid -outid/2);  %定义测试中实际速度vreal范围:-80-80 km/h

Va_res = 0.3;  %多普勒维速度分辨率
Va_res_maxv = Va_res *128; %定义多普勒频点数量为128，算出A波最大可检测速度

Vb_res = 0.5; %多普勒维分辨率
Vb_res_maxv = Vb_res *128;  %定义多普勒频点数量为128，算出B波最大可检测速度

%模糊速度
Va_binnum = mod(round(vreal/Va_res),128);  %四舍五入，对128取余，dopperbin数量
Vb_binnum = mod(round(vreal/Vb_res),128);

    for i = 1:1:10
        %算出目标实际模糊速度
        Vout_real(1,i) = Va_binnum*Va_res + (i-5)*Va_res_maxv; 
        Vout_real(2,i) = Vb_binnum*Vb_res + (i-5)*Vb_res_maxv;
    end
    
 min_V = 99;
 out_V = 0;
    
 for i = 1:1:10
       for j=1:1:10
        V_cha = abs(Vout_real(1,i) - Vout_real(2,j)); %算差值
         if(abs(Vout_real(1,i)) < 80) && (abs(Vout_real(2,j)) < 80) 
            if(V_cha <min_V)
               min_V =  V_cha;  %取速度差值最小
               out_V = Vout_real(1,i); %取差值最小的速度解
            end
         end               
       end       
 end
 V_list(vid) = out_V;
end
%%
plot(V_list);
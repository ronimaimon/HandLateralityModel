% inputs: starting points, drift rate, threshold, noise_std, number of
% iters
function [correct, RT]= my_diffusion_percise(sp, dr, thresh, noise_std, iters, dt)

RT= zeros(1, iters);
correct= zeros(1,iters);

if length(sp)~= iters
    sp=sp*ones(1, iters);
end
if length(dr)~= iters
    dr=dr*ones(1, iters);
end
if length(thresh)~= iters
    thresh=thresh*ones(1, iters);
end


sqrt_dt_noise= sqrt(dt)*noise_std;
dt_dr=dt*dr;
for k=1: iters   
    evidence= sp(k); % initialize at starting point
    rt= 0; 
    while abs(evidence)< thresh(k)
        rt= rt+dt;
        evidence= evidence+ sqrt_dt_noise*randn+ dt_dr(k);
    end
    RT(k)= rt;
    if evidence>= thresh(k)
        correct(k)= 1;
    end
end
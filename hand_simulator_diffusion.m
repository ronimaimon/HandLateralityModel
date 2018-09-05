function [is_this_hand, rt]=hand_simulator_diffusion(z,v,theta, T_mu)
T = lognrnd(T_mu,1,1,1);
[is_this_hand, rt] = my_diffusion_percise(z, v, theta, .1,1, 1e-3);
if rt > T
    rt = T;
    is_this_hand = 0;
end
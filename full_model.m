function [ acc,rts ] = full_model(model_params,samples)
%FULL_MODEL Runs a simulation of the hand laterality judgment task
%   Detailed explanation goes here
st = 0.05;
rts = zeros(2,samples);
acc = zeros(2,samples);
for stim=1:2
for i=1:samples
    if stim==1
       [is_dom, rt_dom] = hand_simulator_diffusion(model_params.z, model_params.v, ...
                                                   model_params.theta,model_params.Timer_mu);
       if model_params.num_of_simulators==2                                   
           [is_ndom, rt_ndom] = hand_simulator_diffusion(-model_params.z, -model_params.v, ...
                                                      model_params.theta,model_params.Timer_mu);
       elseif model_params.num_of_simulators==1    
           rt_ndom = Inf;
       end
       if rt_dom < rt_ndom
           rt = rt_dom;
           response_acc = is_dom;
       else
           rt = rt_ndom;
           response_acc = ~is_ndom;
       end
    else
       [is_dom, rt_dom] = hand_simulator_diffusion(model_params.z, -model_params.v, ...
                                                   model_params.theta,model_params.Timer_mu);
       if model_params.num_of_simulators==2                                   
           [is_ndom, rt_ndom] = hand_simulator_diffusion(-model_params.z, model_params.v, ...
                                                      model_params.theta,model_params.Timer_mu);
       elseif model_params.num_of_simulators==1    
           rt_ndom = Inf;
       end
       if rt_dom < rt_ndom
           rt = rt_dom;
           response_acc = ~is_dom;
       else
           rt = rt_ndom;
           response_acc = is_ndom;
       end
    end
    rts(stim,i) = rt + unifrnd(model_params.t_wait-st,model_params.t_wait+st);
    acc(stim,i) = response_acc;
end
end
end


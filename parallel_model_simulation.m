clear; close all;
params_ctrl.t_wait   = .300; % Early processing time/ Nondecision
params_ctrl.z        = .006;% starting point
params_ctrl.v        = .1; % drift rates
params_ctrl.Timer_mu = 1.6;  % Mean of timer distribution
samples = 5e4;
stim_str={'dom', 'ndom'};


params_ctrl.theta   = .17;
params_ctrl.num_of_simulators = 2;
[acc_pred_ctrl, rts_pred_ctrl] = full_model(params_ctrl,samples);

subplot(211)
acc_ctrl = [0.909075  0.901354];
acc_err_ctrl = [0.017	0.017]; %0.016628  0.016755
rt_ctrl = [1.265119413  1.307031275];
rt_err_ctrl= [.0704	.0734]; % 70.387572  73.380428
bar([1 1.5],acc_ctrl,'w')
hold on
errorbar([1 1.5],acc_ctrl,acc_err_ctrl,'.')
scatter([1 1.5],mean(acc_pred_ctrl,2),100,'rd')

hold off
ylim([0.5 1])
ylabel('Accuracy')

yyaxis right
bar([2 2.5],rt_ctrl,'w')
hold on
errorbar([2 2.5],rt_ctrl,rt_err_ctrl,'.')
ylim([0.5 2])
ylabel('Reaction time')
s = scatter([2 2.5],[mean(rts_pred_ctrl(1,acc_pred_ctrl(1,:)==1)),mean(rts_pred_ctrl(2,acc_pred_ctrl(2,:)==1))],100,'rd');

hold off

xticks([1 1.5 2 2.5])
xticklabels({'Dominant Acc','Non-Dominant Acc','Dominant RT','Non-Dominant RT'});
xlim([0.5 3]);
title('Control Data')
legend(s,{'Model'});


params_cong = params_ctrl;
params_cong.theta    = .138;

params_cong.num_of_simulators = 1;

[acc_pred_cong, rts_pred_cong] = full_model(params_cong,samples);

subplot(212)

acc_cong = [0.867863  0.928815];
acc_err_cong = [0.025816	0.016474];%not updated
rt_cong = [1.405251180  1.517358161];
rt_err_cong= [0.094525085	0.105223841];%not updated
bar([1 1.5],acc_cong,'w')
hold on
errorbar([1 1.5],acc_cong,acc_err_cong,'.')
scatter([1 1.5],mean(acc_pred_cong,2),100,'rd')

hold off
ylim([0.5 1])
ylabel('Accuracy')

yyaxis right
bar([2 2.5],rt_cong,'w')
hold on
errorbar([2 2.5],rt_cong,rt_err_cong,'.')
ylim([0.5 2])
ylabel('Reaction time')
s = scatter([2 2.5],[mean(rts_pred_cong(1,acc_pred_cong(1,:)==1)),mean(rts_pred_cong(2,acc_pred_cong(2,:)==1))],100,'rd');

hold off

xticks([1 1.5 2 2.5])
xticklabels({'Intact Acc','Missing Acc','Intact RT','Missing RT'});
xlim([0.5 3]);
title('Congenitals Data')
legend(s,{'Model'});

'results'
rt_preds = [mean(rts_pred_ctrl(1,acc_pred_ctrl(1,:)==1)),mean(rts_pred_ctrl(2,acc_pred_ctrl(2,:)==1)),mean(rts_pred_cong(1,acc_pred_cong(1,:)==1)),mean(rts_pred_cong(2,acc_pred_cong(2,:)==1))]
acc_preds = [mean(acc_pred_ctrl,2)',mean(acc_pred_cong,2)']
mean([rt_ctrl rt_cong] - rt_preds)+mean([acc_ctrl acc_cong]- acc_preds)*1000
%%
% AMPUTEES Currently not in use!
params_amp          = params_ctrl;
params_amp.theta    = .16;
params_amp.z        = 0.005;


[acc_pred_amp, rts_pred_amp] = full_model(params_amp,samples);
% subplot(313)
figure

acc_amp = [0.908383	0.925754];
acc_err = [0.013842	0.019756];
rt_amp = [1.210474188	1.266061257];
rt_err = [.085915642	.098296192];
bar([1 1.5],acc_amp,'w')
hold on
errorbar([1 1.5],acc_amp,acc_err,'.')
scatter([1 1.5],mean(acc_pred_amp,2),100,'rd')

hold off
ylim([0.5 1])
ylabel('Accuracy')

yyaxis right
bar([2 2.5],rt_amp,'w')
hold on
errorbar([2 2.5],rt_amp,rt_err,'.')
ylim([0.5 2])
ylabel('Reaction time')
s = scatter([2 2.5],[mean(rts_pred_amp(1,acc_pred_amp(1,:)==1)),mean(rts_pred_amp(2,acc_pred_amp(2,:)==1))],100,'rd');

hold off

xticks([1 1.5 2 2.5])
xticklabels({'Intact Acc','Missing Acc','Intact RT','Missing RT'});
xlim([0.5 3]);
title('Amputees Data')
legend(s,{'Model'});
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0.5, 0.5, 0.5, 0.9]);
print('model','-dpng')
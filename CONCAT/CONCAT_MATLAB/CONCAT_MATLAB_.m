% =========================================
% SU26: COMPUTATION FOR SCIENTIFIC APP: 10370
% /
% CIC-IDS-2017 (PERSONAL PROJECT)
% Problem Description:
% Download and analyze CIC-IDS-2017 Network Intrustion
% traffic dataset using Kaggle API from Python-MATLAB
% bridge / statistical analysis on network flows.
%
% Author: Antonio Gonzalez
% Date: May 26,2026

% CONCLUSION:
% --- BWD > FWD----
% Normal traffic has more forward than backward packets
% could potentially be a sign of data ex-filtration
% this attack could have the data extracting more then being
% sent it keeping them off the radar. 

% ================================================

% MATLAB cant see Kagglehub's API but python can.
% Python can talk to MATLAB and import it for it.
py.importlib.import_module('kagglehub');
dataset_path = py.kagglehub.dataset_download('chethuhn/network-intrusion-dataset');
csv_folder = string(dataset_path);

% The Dataset for this is way to large to store locally
% Dataset is currently using KaggleHub's API key to run locally
% via cache, this tells us where is it locally.
fprintf('Dataset downloaded to: %s\n', csv_folder);

% Dataset downloaded to: /Users/antoniogonzalez/.cache/kagglehub/datasets/chethuhn/network-intrusion-dataset/versions/1

% ls /Users/antoniogonzalez/.cache/kagglehub/datasets/chethuhn/network-intrusion-dataset/versions/1
% Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv
% Friday-WorkingHours-Afternoon-PortScan.pcap_ISCX.csv
% Friday-WorkingHours-Morning.pcap_ISCX.csv
% Monday-WorkingHours.pcap_ISCX.csv
% Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv
% Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv
% Tuesday-WorkingHours.pcap_ISCX.csv
% Wednesday-workingHours.pcap_ISCX.csv



% Instead of a '[]' like in python as a list MATLAB were using a
% {} array instead.

files = {
    'Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv',
    'Monday-WorkingHours.pcap_ISCX.csv',
    'Friday-WorkingHours-Morning.pcap_ISCX.csv',
    'Friday-WorkingHours-Afternoon-PortScan.pcap_ISCX.csv',
    'Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv',
    'Tuesday-WorkingHours.pcap_ISCX.csv',
    'Wednesday-workingHours.pcap_ISCX.csv',
    'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv'
    };

% Concatenating all CSV's to one table
% table() is an empty table currently not assigned yet.
combined_data = table();

% Begin looping each file into one
for i = 1:length(files)
    filePath = fullfile(csv_folder, files{i}); % path of all CSV
    temp = readtable(filePath, 'VariableNamingRule', 'preserve'); % place for temporary read of csv
    combined_data = [combined_data; temp]; % stacks temp to 'combined_data'
end 

% Combined_data = empty
% Reads Monday
% Combine_data = Monday
% Reads Tuesday 
% Combine_data = Monday + Tuesday
% For all 8 files

fprintf('Total rows loaded: %d\n', height(combined_data));

% ---- Extracting Network Flow Traffic ------
flow_duration = combined_data.('Flow Duration');
fwd_packets = combined_data.('Total Fwd Packets');
bwd_packets = combined_data.('Total Backward Packets');
flow_bytes_per_s = combined_data.('Flow Bytes/s');
% Very interesting find, these values have a space at the front of them
% Within the dataset, however error was found, MATLAB automatically 
% sanitizes existing values, removing the spaces. 
% Ended up having to use 'VariableNamingRule' to clean up the error
% ignores anything MATLAB dislikes within the variable name.

% ---- Statistical Calculations -----
% Calculate basic statistics
mean_duration           = mean(flow_duration, 'omitnan');
min_duration            = min(flow_duration);
max_duration            = max(flow_duration);
total_packets           = fwd_packets + bwd_packets;
total_FwdPackets        = sum(fwd_packets);
total_BwdPackets        = sum(bwd_packets);
avg_packets             = mean(total_packets, 'omitnan');
avg_bytes_per_s         = mean(flow_bytes_per_s, 'omitnan');

% 'omitnan is just to remove and disqualify empty no values


% ---- FINAL Display Output ----
fprintf("======================================\n");
fprintf(" CIC-IDS-2017 NETWORK TRAFFIC ANALYSIS \n ");
fprintf("====================================== \n");
fprintf("Flow Duration:\n");
fprintf(" - Mean:    %.2f microseconds\n" , mean_duration);
fprintf(" - Min:     %.2f microseconds\n", min_duration);
fprintf(" - Max:     %.2f microseconds\n", max_duration);
fprintf("====================================== \n");
fprintf("===========Packet Analysis========= \n");
fprintf("====================================== \n");
fprintf(" - Avg Total Packets per Flow: %.2f\n", avg_packets);
fprintf("====================================== \n");
fprintf("===========Traffic Volume========= \n");
fprintf(" Avg Flow Bytes/sec: %.2f\n", avg_bytes_per_s);
fprintf("====================================== \n");


% --- Visualization BAR CHART ---
figure; 
% The bar of the chart, taking both means at the X
% to compare the two
bar([mean(fwd_packets, 'omitnan'), mean(bwd_packets, 'omitnan')]);
set(gca, 'XTickLabel', {'Fwd Packets', 'Bwd Packets'});
title('Avg Forward vs Backward Packets - CIC-IDS-2017');
xlabel('Packet Direction');
% How many packets were received vs given.
ylabel('Average Count');

% --- Visualization PIE CHART ---
% BENIGN VS ATTACK


% The slices of the pie
% counts = how many times did we see the category
% names = each category of attacks/BENIGN
label_counts = countcats(categorical(combined_data.('Label')));
label_names = categories(categorical(combined_data.('Label')));

figure;
% The Pie that now holds each category
pie(label_counts);
legend(label_names, 'Location', 'bestoutside');
title('CIC-IDS-2017 Attack Types vs Benign Traffic');







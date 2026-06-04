# Project Journal: CIC-IDS-2017 Analysis


Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub


# Environment Setup & Security
Date: April 24, 2026


Goal: Initialize a professional Git repository with an .env safely and securely.


# Interruptions
Problems: Standard issues, update Python, VS Code.
Solution: Restarting environment, force update VS Code through website.


# Observation
Scoping DataSet:
Discovery: Once I loaded the dataset files I first noticed only 8 files to the dataset.
These data sets were rather larger than most.


Analysis: All 8 files represented the days of the week Monday, Tuesday, Wednesday, Thursday, Friday.
However not Saturday or Sunday, suggesting that this data set is only referring to an average workweek excluding weekends.


Concern: A potential attack doesn't just come from an average work week. Potential attacks are always 24/7.
Understanding this is only recorded previous data I wonder how this would affect understanding weekend traffic
and potential attacks.
(Sample Bias)


----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub


# Monday_WorkingHours
Date: April 24, 2026


Goal: Observe the first CSV file, see what is available to take from the dataset.


# Observation
1. Dataset: (529918 rows x  79 columns) Dataset shows each port and network traffic going through the dataset.
BENIGN value count 529918/529918
2. Dataset shows each port traffic by number, as well as packet size
(Total Length of Fwd Packets) / (Total Length of Bwd Packets) and Idle Mean
and if traffic flow caused delay. This is great as these values can potentially show us DDoS attacks
and any signs of delays.
3. Notice the dataset doesn't have time stamps, however it does have 'Flow Duration', 'Flow IAT Mean', 'Fwd IAT Total' which show us the actual duration of how long the conversation lasted within the network. (Helps defend against DDoS attacks.)




Analysis:
Label value count: Label BENIGN 529918
BENIGN value is reported 529918/529918 no malicious/dangerous network traffic was reported on monday's csv
This proves that the monday csv is more of an intro to the dataset, no value's missing, no intrusions, completely clean.


Concerns:
As much as I love 'Flow Duration', 'Flow IAT Mean', 'Fwd IAT Total', this dataset would be a lot more significantly impactful
against attacks if we had actual timestamps to work with. Timestamps can help us accurately spot 'temporal pattern analysis'. Where we can spot and locate potential patterns and determine when we're most likely to be attacked.
----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub


#  Observe Monday-Friday


Goal: Open, Compare and Observe each CSV file separately, organize each file in its own designated folder based on the day.


#  Observation
1. First I noticed how big these files were separated let alone all together.
2. Compared to monday that was all BENIGN I began to see more and more diverse and more serious attacks.
(DDoS), (Brute Force), (PortScan), (DoS Hulk), (DoS GoldenEye) (DoS slowloris), (DoS Slowhttptest), (Heartbleed)
3. Wednesday had some of the most interesting attacks and labels compared to the rest of the days. (692703) values.
I certainly feel as if this one will be the largest of the rest.


Analysis: The next step is to predict how well an ML model can detect such attacks using the dataset provided.


----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub


# ML Monday-Friday
Date: April 26, 2026


Goal: Simple Random Forest Tree (Mon-Fri) comparison.


# Observation
1. I was not expecting a 'Random Forest Tree' method to be so accurate in its predictions. At first Monday seemed
to experience a perfect predicting rate of 100%. I first believed it to be accurate due to Monday being
entirely BENIGN, so I went forward with Tuesday to see if the same anomaly would continue. Tuesday also came in at 100%
accuracy. At first I thought I was experiencing 'data leakage' with how well the model was originally doing. I first
ensured that my X and Y values were in the correct position in my 'TrainTestSplit' model. Both returned correctly. I then verified my
X_train and X_test values were both coming back as '<class 'numpy.ndarray'>' to ensure there was no class error issue. There wasn't.


2. I was expecting more of a delay in my outputs when testing the results of my models. The slowest at 58.6 seconds and the shortest
being Monday at 1.2 seconds. I can certainly predict that when putting the models together using 'concat' the model prediction is going
to take much longer, also limiting the accuracy of 'Random Forest Tree' and 'XGBOOST' will increase the odds of my prediction but make the process
drastically slower to output.


Analysis: So far Random Forest Tree has been able to accurately predict potential threats based on traffic information to determine what is an attack
or not.


Concerns: How well will it be able to keep up, later how well will I be able to predict which ports are most likely to be attacked.


----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub


# XGBOOST
Date: April 27, 2026


Goal: Set up XGBOOST for comparison against RFC


# Observation:
1. First observation was XGBOOST speed was much faster than RFC which was the exact opposite of what I was expecting for this dataset.
the fastest being 0.8 seconds ('Monday-WorkingHours.pcap_ISCX.csv') XGBOOST compared to RFC with 1.5 seconds.


2. XGBOOST was for the most part on par with RFC in these datasets, however I actually saw significant reductions in probability when
it came to the hardest data set. 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' main issues being
'Web Attack – SQL Injection' from my observation based on the recall scores being the lowest, it's a sign that the actual attacks are being constantly missed, its cause is directly from not enough data to fight against it and that the data doesn't
drastically change enough for the data to truly respond against it.


3. Infiltration however, actually improved slightly better compared to the RFC while using XGBOOST.


4. Surprisingly enough, heartbleed on 'Wednesday-workingHours.pcap_ISCX.csv' only has 11 cases in that entire dataset however both
RFC and XGBOOST were able to detect it in each model so well.
Conclusion on heartbleed:
Even though its only 11 cases, from further investigation on 'Wednesday-workingHours.pcap_ISCX.csv' heartbleed
only seems to attack port 444 with zero variation to other ports. This is because heart bleed is a bug in SSL/TLS encryption. It sends a small "heartbeat" request to a server but lies about how big it is, tricking the server to send back more data than it should. This leaks the server memory which may contain passwords, keys and sensitive data. This is why websites look into becoming SSL (Secure Socket Layer) which not only protects the website but its users as well.


Solution:
If SSL is not available, or there are too many users on the network, implementing an idle timeout that logs users out can help reduce active connections, protecting both the user and the network from Heartbleed attacks.

                 
                         XGBOOST                                                            RANDOM FOREST CLASSIFIER
                                        'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv'

-Fold--
              precision    recall  f1-score   support                                precision    recall  f1-score   support


           0       1.00      1.00      1.00     33611                             0       1.00      1.00      1.00     33632
           1       0.73      0.84      0.78       301                             1       0.73      0.81      0.77       273
           2       1.00      0.80      0.89         5                             2       1.00      0.20      0.33         5
           3       0.45      0.29      0.35       130                             3       0.49      0.35      0.41       137

    accuracy                           1.00     34047                      accuracy                           1.00     34047
   macro avg       0.80      0.73      0.76     34047                     macro avg       0.81      0.59      0.63     34047
weighted avg       1.00      1.00      1.00     34047                  weighted avg       1.00      1.00      1.00     34047

-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     33610
           1       0.76      0.84      0.80       302
           2       0.80      1.00      0.89         4
           3       0.50      0.35      0.41       130

    accuracy                           1.00     34046
   macro avg       0.76      0.80      0.78     34046
weighted avg       1.00      1.00      1.00     34046

-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     33610
           1       0.76      0.82      0.79       302
           2       1.00      0.50      0.67         4
           3       0.47      0.38      0.42       130

    accuracy                           1.00     34046
   macro avg       0.81      0.67      0.72     34046
weighted avg       1.00      1.00      1.00     34046

-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     33610
           1       0.74      0.79      0.76       301
           2       1.00      0.50      0.67         4
           3       0.42      0.34      0.37       131

    accuracy                           1.00     34046
   macro avg       0.79      0.66      0.70     34046
weighted avg       1.00      1.00      1.00     34046

-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     33610
           1       0.76      0.81      0.78       301
           2       1.00      0.50      0.67         4
           3       0.48      0.39      0.43       131

    accuracy                           1.00     34046
   macro avg       0.81      0.67      0.72     34046
weighted avg       1.00      1.00      1.00     34046



----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub


# SQL-Injection/Infiltration
Date: April 28, 2026


Goal: Investigate SQL-Injection/Infiltration issues.


# Observation:
Seeing biggest issue on Thursday's files, file: 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' and Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv' both SQL-Injection, and 'Infiltration' my reasoning is because there isn't enough
data on these attacks for the model to truly understand them yet/the parameters on the dataset for both SQL injection and Infiltration are so minute that it's hard to predict when the model displays such little difference compared to BENIGN more data could help this result.


concat data with all 8 files may help finding more evidence on these two parameters become detectable but I'm not too hopeful.


dropna was one of my biggest concerns for deleting too much data that might actually support things like 'Infilteration' and 'SQL-Injection' being detectable however coming from diving into what we were dropping. 'Rows before: 529918 Rows after: 529481'


After further research, dropna is only removing 437 benign rows from 'Flow Bytes/s'
and 'Flow Packets'.


No attack samples are being lost, so dropna is not
contributing to the poor detection of 'Infiltration' and 'SQL-Injection'.




----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub


#  StratifiedKFold on XGBOOST
Date: April 29, 2026


Goal: Now with the drastic speed increase added StratifiedKFold with 5 extra folds.
See if 5 extra folds helps the model predict better results.


#  Observation:
Overall I was anticipating to either see the model really reflect drastically different results between the 5 folded models especially keeping it at the 80/20 level but shuffling it through 5 different ways to experience new in different data or at least see a gradual improvement as it went on through each fold. Instead it was rather consistent especially with most of the data being pretty high and consistent throughout most data sets I was more so really paying attention to the difficult csv's such as 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' which has definitely been the hardest for the model.




----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub


#  INDEX.MD CREATED
Date: April 30, 2026


Goal: Write through an index to navigate code to users more easily.



----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

*** BIG UPDATE ***
#  PYTORCH STRESS - NVIDIA CPU vs MAC GPU via MPS
Date: May 1st, 2026


Goal: Start up pytorch for each individual CSV and compare.
2nd Goal: Understanding computer internal architecture (creates massive efficiency)

# PYTORCH 
PyTorch is one of the most widely used open-source deep learning frameworks today, powering some of the biggest trends in AI such as sensors on cars like stop assist, lane assist, and self driving (computer vision), image generation and speech recognition. This uses a multi dimensional arrays (tensors) AI platform (deep neural network) using high performance parallel computing from both the CPU and the GPU 

The biggest focus to what people love about using it in models is its optimization to improve its statistical modeling while on run time, something I was expecting to see more in XGBOOST. This is called (Dynamic Computation Graph) where  Directed Acyclic Graph (DAG) whose functions focus on memorizing executed operations on the tensors allowing you to change size, operation and shape while on each iteration.

# UNEXPECTED FIND
When running these larger datasets on something much more elaborate such as Pytorch compared to RFC or XGBOOST, my computer was noticeably getting hotter, certainly not in a concerning way or in any way beginning to bottleneck but noticeably hotter. I did notice that Pytorch was doing what I thought I would see in XGBOOST where the model performance would drastically improve as each fold progressed. Coming from my results especially with the later days in the week such as 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' or file 'Thur_WH_M_TORCH' it really wanted nothing to do with 'SQL-Injection' getting a pretty consistent '0.0' across the board. Overall PYTORCH wasn't more successful than the rest, but still consistently got what I believe were more accurate and honest responses. When models predict 100% caught other than on 'Monday's' 100% BENIGN file I'm skeptical to want to believe it where PYTORCH was consistently more around the range of 70-90% accuracy on most thing's if not 100% I'm certainly hoping to see PYTORCH win the end of the race.

# Further Research
This is probably still the same speculation as the rest of them where my biggest concerns are that the models will weight the results in an unfair biased sample or scope bias where it'll mostly see that 'BENIGN' is much more massive than anything else. When the model see this it'll understand that being biased to 'BENIGN' will result in a better precision but lack in recall.

# Before running all CSV together:
I was wondering how the performance of all 8 rather larger CSVs running together would have an effect on either the computer or 
the performance of the model. So I began to research for efficiencies in my pytorch code. It so happens that I was utilizing the code 'NeuralNet(input_size, num_classes)' which is technically correct for the idea of NVIDIA's CUDA GPU design. However this severely bottlenecks macs performance. By simply adding '.to(device)' we get Mac's full potential. See when we want to utilize both the CPU and Gpu power from NVIDIA's CUDA design the CPU and GPU are not connected and the code understands this however for a MacBook they're all together on one logic board system. When running Pytorch on mac without '.to(device)' my GPU isn't working putting all the power on the CPU's cores alone. Pretty impressive the macbook was able to still do the data but a simple extra heat on my lap had me thinking to ask why?


----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

#  CONCAT FILES
Date: May 2nd, 2026

Concat did not help SQL-Injection which proves my theory that this isn't a modeling problem however is a data problem. With 2.8 million rows of data SQL-Injection is just so rare and the dataset shows such little difference in change that it's almost impossible for the model to predict. Even proven before that dropna was simply only dropping values that were inf from the values, nothing of value that could benefit the data to better predicting SQL-Injection. However I did notice that, infiltration did go up and improve slightly with concat getting more access of data did in fact improve it's chances in the model to be detected.

----------------------------------------------------------------------------------------------------------------------------------

Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

#  CSV/CONCAT Graphs
Date: May 5th-9th, 2026
(Finals Week)

Graphing: Out of all three models used on this project, XGBOOST was the easiest and most legible experience out of all of them.

Surprisingly enough I was shocked to see that the graphs were able to show how different the models solved the same problem of detecting intrusion. My expectations were that all three models would indicate the same value as most important in detecting intrusion for the same individual CSV file. Even through CONCAT each file was drastically different. So I wanted to do further research to better explain as to why.

RFC: The mean decreases in impurity(Gini). across all 100 decision trees which of the feature reduced uncertainty the most on average? It averages across 100 trees, importance gets spread across many correlated features. This prevents any single feature from dominating.

XGBOOST: Uses gain. Which feature reduced prediction error the most in its own boosting sequence is what its going to then focus more onto. XGBoost builds trees one at a time, each one fixing the mistakes previous on the tree. It then tends to concentrate importance very heavily on the one feature that cuts the problem fastest. 

PYTORCH/SHAP: Uses Shapely values. It asks: if I remove this feature, how much would the prediction change across every possible subset of features? This is called a game theory based method that is drastically and fundamentally different from the other two models. 

Simply: They are all asking different legitimate questions to solve the same complex problem they're put in front of.

Unfortunately, I wasn't able to experience truly one suffer one something in the dataset while others thrived however. The dataset overall is very clean and easy for the models to get an accurate detection on most except for SQL-Injection and Infiltration. Which CONCAT didn't seem to help with either.

Obviously, Monday's graphs were all consistently no value as all of the data in Monday's CSV were completely BENIGN.

Most important column: 

Monday: Doesn't have a most important column — all data is BENIGN

Tuesday:
RFC - Destination Port
XGBOOST - Destination Port
TORCH/SHAP - Destination Port
(Actually had the same interest after intrusion)

Wednesday: 
RFC - Bwd Packet Length Mean
XGBOOST - BWD Packet Length Std
TORCH/SHAP - Flow Duration
(Were after almost the same thing)

Thursday:
Thursday Morning:
RFC - Fwd IAT Min
XGBOOST - init_win_bytes_backward
TORCH/SHAP - Destination Port

Thursday Afternoon:
RFC - Total Length of FWD Packets
XGBOOST - ACK Flag Count
TORCH/SHAP - Destination Port

Friday:
Friday Morning:
RFC - init_Win_bytes_forward
XGBOOST - Bwd IAT Min
TORCH/SHAP - Flow Duration

Friday Afternoon P:
RFC -  Total Length of Fwd Packets
XGBOOST - Total Length of FWD Packet
TORCH/SHAP - Flow Duration

Friday Afternoon D:
RFC - Avg Fwd Segment Size
XGBOOST - Fwd Packet Length Mean 
TORCH/SHAP - Flow Duration

RFC - More diverse than PyTorch but mainly likes packet movement
XGBOOST - Most diverse of all three
PyTorch favored mainly Destination Port/Flow Duration

Concat:
RFC - Packet Length Std
XGBOOST - Idle Mean
TORCH/SHAP - Fwd Packet Length Min

URGENT: Some column names are clashing within the different CSV files

Show charts, and score comparisons once the new drop is down
Use this for google slides

Duplicated columns noticed:     
    'Fwd Header Length.1',
    'Avg Fwd Segment Size',
    'Subflow fwd bytes',
    'Subflow fwd packets',
    'Subflow bwd Packets',
    'Subflow bwd bytes',
    'Packet Length Variance' 


----------------------------------------------------------------------------------------------------------------------------------

Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

#  Remove duplicated columns
Date: May 13th, 2026

------------------------------------------------------

# Mondays Working Hours:

All results on Monday didn't change with the column drop however,
'Destination Port' for Monday on torch actually had less outliers showing the only sign of slight improvement.

------------------------------------------------------

# Tuesday Working Hours:

0 - BENIGN
1 - FTP-Patator
2 - SSH-Patator

RFC - No Changes from drop column results compared to original

TORCH - Graph is entirely less accurate. Slightly increase in accuracy overall in 'FTP-Patator' for F1-score, 'SSH-Patator' saw an overall decrease in precision and F1-Score. Overall drop column didn't succeed in improving results.

Original:
Epoch 10/10 Loss: 0.0000
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     86310
           1       0.99      1.00      0.99      1587
           2       0.97      0.98      0.97      1232

    accuracy                           1.00     89129
   macro avg       0.99      0.99      0.99     89129
weighted avg       1.00      1.00      1.00     89129

Drop Column Results:
Epoch 10/10 Loss: 0.0000
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     86226
           1       0.99      1.00      1.00      1662
           2       0.90      0.98      0.94      1241

    accuracy                           1.00     89129
   macro avg       0.96      0.99      0.98     89129
weighted avg       1.00      1.00      1.00     89129

XGBOOST - No Changes from drop column results compared to original

------------------------------------------------------

# Wednesday Working Hours:

RFC - No change from column dropping duplicates.

XGBOOST - Saw Slight decrease in F1-Score from column drop, could be potentially a sign of becoming more accurate despite score going down. (Less leakage)

PyTorch - actually saw slight decrease in Precision, Recall and F1-Score.

------------------------------------------------------

# Thursday Working Hours Afternoon:
(Huge Improvement!)
0 - BENIGN 
1 - INFILTRATION 

------------------------------------------------------

RFC - Much better improvement from both precision, f1-score and macro average 
precision and macro average f1-score from the model against infiltration, 
BENIGN still 100% across for this CSV.


Original:

              precision    recall  f1-score   support

           0       1.00      1.00      1.00     57669
           1       0.78      0.70      0.74        10

    accuracy                           1.00     57679
   macro avg       0.89      0.85      0.87     57679
weighted avg       1.00      1.00      1.00     57679

Drop Column Results:
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     57669
           1       0.88      0.70      0.78        10

    accuracy                           1.00     57679
   macro avg       0.94      0.85      0.89     57679
weighted avg       1.00      1.00      1.00     57679

------------------------------------------------------

TORCH - Much greater improvement, with the graph showing much less outliers with new column drop. Saw a slight decrease in 'infiltration' recall but overall saw a higher precision/f1-score showing better improvement, detections increased from 8 to 10. BENIGN is always 100% caught.

Original:
Epoch 10/10 Loss: 0.0000
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     57669
           1       0.71      0.62      0.67        10

    accuracy                           1.00     57679
   macro avg       0.86      0.81      0.83     57679
weighted avg       1.00      1.00      1.00     57679


Drop Column Results:
Epoch 10/10 Loss: 0.0000
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     57669
           1       0.86      0.60      0.71        10

    accuracy                           1.00     57679
   macro avg       0.93      0.80      0.85     57679
weighted avg       1.00      1.00      1.00     57679

------------------------------------------------------

XGBOOST - Graph showed no variable change. Drastic Improvement for 'infiltration' However, Macro average and weighted average still stayed the same. BENIGN still same.

-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     57671
           1       1.00      0.43      0.60         7

    accuracy                           1.00     57679
   macro avg       1.00      0.88      0.93     57679
weighted avg       1.00      1.00      1.00     57679

Drop Column Results:
-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     57671
           1       1.00      0.75      0.86         8

    accuracy                           1.00     57679
   macro avg       1.00      0.88      0.93     57679
weighted avg       1.00      1.00      1.00     57679

------------------------------------------------------

# Thursday Working Hours Morning:
0 - BENIGN 
1 - Web Attack � Brute Force 
2 - Web Attack � XSS  
3 - Web Attack � Sql Injection 

------------------------------------------------------

RFC - Slight Change, IAT's went up in importance, 'init_Win_bytes_backward' came down.
First time actually seeing results come down losing precision very slightly. To my surprise Brute Force actually slightly decreased in model prediction overall with a slightly poorer F1-Score with the new column drop. 'Web Attack � XSS' actually had the most improvement with the column drop out of the rest of the results.

Unfortunately, 'Web Attack – SQL Injection' / 'Infiltration' were the biggest attacks I wanted to seek improvement for the model as they are its weakest. Which we were able to improve the detection for the model in 'infiltration', 'Web Attack – SQL Injection' saw a pretty significant decrease in detection. Which to my knowledge proves this attack needs more consistent data, and search for more variable changes.

Original:
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     33632
           1       0.73      0.81      0.77       273
           2       1.00      0.20      0.33         5
           3       0.49      0.35      0.41       137

    accuracy                           1.00     34047
   macro avg       0.81      0.59      0.63     34047
weighted avg       1.00      1.00      1.00     34047

Drop Column Results:

              precision    recall  f1-score   support

           0       1.00      1.00      1.00     33632
           1       0.72      0.79      0.76       273
           2       1.00      0.40      0.57         5
           3       0.46      0.33      0.38       137

    accuracy                           1.00     34047
   macro avg       0.80      0.63      0.68     34047
weighted avg       1.00      1.00      1.00     34047

------------------------------------------------------

TORCH - Graph had little change, some outliers reduced from column drop. BENIGN actually saw a 0.01% dip in precision. While for ' Web Attack � Brute Force' precision went up slightly recall/F1-score drastically decreased should a disadvantage. As for 'Web Attack � XSS' PyTorch is still completely unable to detect web attacks, which definitely surprised me. It probably isn't the best for this case. Lastly, as for 'Web Attack – SQL Injection', we can see a slight improvement from the column drop but definitely not enough to call an improvement. Proving 1. Torch may not be the best for this dataset and 'Web Attack – SQL Injection' for this dataset needs more data for the model to attack as well as needs more parameters to detect 'Web Attack – SQL Injection' better. 

Original:
Epoch 10/10 Loss: 0.0127
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     33632
           1       0.56      0.99      0.71       273
           2       0.00      0.00      0.00         5
           3       0.80      0.03      0.05       137

    accuracy                           0.99     34047
   macro avg       0.59      0.50      0.44     34047
weighted avg       0.99      0.99      0.99     34047


Drop Column Results:
Epoch 10/10 Loss: 0.0127
              precision    recall  f1-score   support

           0       0.99      1.00      1.00     33632
           1       0.69      0.51      0.59       273
           2       0.00      0.00      0.00         5
           3       1.00      0.04      0.07       137

    accuracy                           0.99     34047
   macro avg       0.67      0.39      0.41     34047
weighted avg       0.99      0.99      0.99     34047

------------------------------------------------------

XGBOOST - Overall a massive decrease across the board in everything. Beginning to question if this was the right move, or did those columns actually have something valuable to help this model learn? Or are we reducing data leakage or overfitting? Graph didn't change much.

Original:
-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     33593
           1       0.76      0.84      0.80       309
           2       0.80      1.00      0.89         4
           3       0.50      0.35      0.41       141

    accuracy                           1.00     34047
   macro avg       0.81      0.67      0.72     34047
weighted avg       1.00      1.00      1.00     34047

Drop Column Results:
-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     33610
           1       0.73      0.80      0.76       301
           2       1.00      0.50      0.67         4
           3       0.42      0.33      0.37       131

    accuracy                           1.00     34046
   macro avg       0.79      0.66      0.70     34046
weighted avg       1.00      1.00      1.00     34046

------------------------------------------------------

# Friday Working Hours Afternoon DDoS: 
Nothing has been changed since the new drop columns and original, 
this dataset is not using those parameters to predict in the model.

0 - DDoS
1 - BENIGN

------------------------------------------------------

RFC - Completely the same, zero changes.

Original:
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     19628
           1       1.00      1.00      1.00     25515

    accuracy                           1.00     45143
   macro avg       1.00      1.00      0.99     45143
weighted avg       1.00      1.00      1.00     45143

Drop Column Results:
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     19628
           1       1.00      1.00      1.00     25515

    accuracy                           1.00     45143
   macro avg       1.00      1.00      1.00     45143
weighted avg       1.00      1.00      1.00     45143

------------------------------------------------------

TORCH - Graph shows a lot fewer outliers with column drop change. Zero changes in detection, still 100%

Original:
Epoch 10/10 Loss: 0.0090
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     19628
           1       1.00      1.00      1.00     25515

    accuracy                           1.00     45143
   macro avg       1.00      1.00      1.00     45143
weighted avg       1.00      1.00      1.00     45143

Drop Column Results:
Epoch 10/10 Loss: 0.0090
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     19628
           1       1.00      1.00      1.00     25515

    accuracy                           1.00     45143
   macro avg       1.00      1.00      1.00     45143
weighted avg       1.00      1.00      1.00     45143

------------------------------------------------------

XGBOOST - Completely the same, zero changes.

Original:
-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     19537
           1       1.00      1.00      1.00     25605

    accuracy                           1.00     45142
   macro avg       1.00      1.00      1.00     45142
weighted avg       1.00      1.00      1.00     45142

Drop Column Results:
-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     19537
           1       1.00      1.00      1.00     25605

    accuracy                           1.00     45142
   macro avg       1.00      1.00      1.00     45142
weighted avg       1.00      1.00      1.00     45142


------------------------------------------------------

# Friday Working Hours Afternoon Portscan: 
Some variables changes on graph. (check)

RFC - Some variables changes on graph. (check) No changes to prediction

Original:
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     25455
           1       1.00      1.00      1.00     31765

    accuracy                           1.00     57220
   macro avg       1.00      1.00      1.00     57220
weighted avg       1.00      1.00      1.00     57220

Drop Column Results:
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     25455
           1       1.00      1.00      1.00     31765

    accuracy                           1.00     57220
   macro avg       1.00      1.00      1.00     57220
weighted avg       1.00      1.00      1.00     57220

------------------------------------------------------

TORCH - Some outliers reduced. 

Original:
Epoch 10/10 Loss: 0.0000
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     25455
           1       1.00      1.00      1.00     31765

    accuracy                           1.00     57220
   macro avg       1.00      1.00      1.00     57220
weighted avg       1.00      1.00      1.00     57220

Drop Column Results:
Epoch 10/10 Loss: 0.0000
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     25455
           1       1.00      1.00      1.00     31765

    accuracy                           1.00     57220
   macro avg       1.00      1.00      1.00     57220
weighted avg       1.00      1.00      1.00     57220


XGBOOST - Graph/Prediction did not change.

Original:
-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     25458
           1       1.00      1.00      1.00     31761

    accuracy                           1.00     57219
   macro avg       1.00      1.00      1.00     57219
weighted avg       1.00      1.00      1.00     57219

Drop Column Results:
-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     25458
           1       1.00      1.00      1.00     31761

    accuracy                           1.00     57219
   macro avg       1.00      1.00      1.00     57219
weighted avg       1.00      1.00      1.00     57219


# Friday Working Hours Morning:
0 - BENIGN
1 - Bot

RFC - Graph/Prediction did not change.

Original:
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     37759
           1       1.00      0.96      0.98       424

    accuracy                           1.00     38183
   macro avg       1.00      0.98      0.99     38183
weighted avg       1.00      1.00      1.00     38183

Drop Column Results:
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     37759
           1       1.00      0.96      0.98       424

    accuracy                           1.00     38183
   macro avg       1.00      0.98      0.99     38183
weighted avg       1.00      1.00      1.00     38183

TORCH - A drastically higher amount of outliers grew from column drops, extremely bizarre. Slight improvement compared to before for 'bot' coming out from BENIGN.

Original:
Epoch 10/10 Loss: 0.0137
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     37823
           1       1.00      0.62      0.76       360

    accuracy                           1.00     38183
   macro avg       1.00      0.81      0.88     38183
weighted avg       1.00      1.00      1.00     38183

Drop Column Results:

Epoch 10/10 Loss: 0.0137
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     37759
           1       1.00      0.66      0.79       424

    accuracy                           1.00     38183
   macro avg       1.00      0.83      0.89     38183
weighted avg       1.00      1.00      1.00     38183


XGBOOST - Graph did not change much. Slight increase in recall but slight decrease in 
recall macro average. Nothing drastic.

Original:
-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     37791
           1       1.00      0.99      1.00       391
...
    accuracy                           1.00     38182
   macro avg       1.00      1.00      1.00     38182
weighted avg       1.00      1.00      1.00     38182

Drop Column Results:
-Fold--
              precision    recall  f1-score   support

           0       1.00      1.00      1.00     37791
           1       1.00      1.00      1.00       391
...
    accuracy                           1.00     38182
   macro avg       1.00      0.99      1.00     38182
weighted avg       1.00      1.00      1.00     38182

------------------------------------------------------

# CONCAT:

RFC - Overall Negative.

TORCH - The Most Negative.

XGBOOST - Overall Negative.

# Conclusion:
Column drop barely did anything, some improvement only within smaller single-CSV datasets, with a lot more negative results. In terms of CONCAT the results were so minuscule or negative that removing the duplicated columns is ineffective and should just be completely left alone.

These results indicate that the columns dropped were just noise. (Mainly shown in most TORCH models.) Most improvements seen on individual CSV files were from 'Infiltration' which is one of the improvements I wanted to see, however it's not enough of an improvement to deem it trustworthy.

Note: Only 4 out of 7 columns were actually being dropped due to a case sensitivity bug in the drop list. The three Subflow columns ('Subflow Fwd Bytes', 'Subflow Fwd Packets', 'Subflow Bwd Bytes') were silently failing due to incorrect casing. The true 7-column experiment was never fully run. Despite this, the CONCAT results on the 4 columns that did drop are sufficient evidence — all three models showed no meaningful improvement or slight regression, confirming these columns carry real predictive signal.

Exception: 'Fwd Header Length.1' is a true duplicate column created by pandas when the same column name appears twice in the CSV. This one should always be removed regardless of model performance.

Conclusion: Columns should not be dropped, except for 'Fwd Header Length.1'.

See PowerPoint for full results.

----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

#  Destination Port's on attack
Date: May 14th, 2026

So I wanted to see what ports trended to see patterns in attacks, what destination ports do they tend to go to in order to attack. As we know some attacks go to specific ports only. I wanted to see that result in this dataset.

I first started with a simple code on 'Tuesday_WorkingHours.ipynb':
'''print(data.isnull().sum())
   print('----')
   print(data['Label'].value_counts())
   for i in data['Label']:
       for n in data['Destination Port']:
           print(f"{i}, {n}")'''

I just first wanted to see the labels and the destination port's printed together, funny enough forgetting
that the csv is massive leading to a computer crash.

Improved Final version:

num_port = {}
count = {}

'''for label, port in zip(data['Label'], data['Destination Port']):
      if label not in num_port:
         num_port[label] = []
      num_port[label].append(port)

   for label, ports in num_port.items():
      count = {}
      for port in ports:
         if port not in count:
               count[port] = 0
         count[port] += 1
      most_common_port = max(count, key=count.get)
      least_common_port = min(count, key=count.get)
      other_ports = [port for port, hits in count.items() if port not in [most_common_port, least_common_port]]
      print(f"Label: {label}, Most Common Destination Port: {most_common_port}, Hits: {count[most_common_port]}")
      print(f"Label: {label}, Least Common Destination Port: {least_common_port}, Hits: {count[least_common_port]}")
      print(f"Label: {label}, Other Destination Ports: {other_ports}")
      print("-----")'''

# Results:

# BENIGN
Label: BENIGN, Most Common Destination Port: 53, Hits: 957812
Label: BENIGN, Least Common Destination Port: 33637, Hits: 1
Label: BENIGN, Other Destination Ports: (Too much! Please see 'concat_RFC.ipynb for more.)

BENIGN Conclusion -
Port 53: DNS Digital Phone Book
Port 33647: Inconclusive.
Other: Many.

 Port 53 being the most common makes sense, this tells us that the most common destination port
 is coming from the DNS thats telling the computer what number its trying to find, hence a phone book.
 The most normal of traffic is just people trying to get on to the internet and surf.

 Port 33647 is not a register port, could very well be an outlier of the dataset or potentially a silent, malware attack to the network that slipped by as BENIGN. Not enough evidence/data to conclude from. Could be something to potentially watch out for if more traffic comes from this port. Often attackers will use unregistered high ports for active malware.

 Other Ports are scattered among all the destination ports which is completely normal to see from normal traffic.

-----
# INFILTRATION
Label: Infiltration, Most Common Destination Port: 444, Hits: 36
Label: Infiltration, Least Common Destination Port: 444, Hits: 36
Label: Infiltration, Other Destination Ports: []

## Infiltration Conclusion -

Port 444: SEVERE CONCERN. Port is outdated not really used on a network anymore.
Port 443: Normal HTTPS traffic

This is a situation where the attacker has already broken inside to network but now needs to move 
laterally through the network in order to:

1. Move laterally through systems
2. Exfiltrate data
3. Establish persistence
4. Communicate back to their command and control (C2) server

C2 communication: Talk back to the attacker for further commands.

Data Exfiltration: The extraction of sensitive data back to the attacker from the network.
Tunneling: This hides the attack to go undercover to mimic what normal traffic looks like to avoid 
an attack.

Beaconing: Sending a pulse back to the attacker keeping the connection that it is still alive in 
the network.

What the attacker does in order to do this is try to sit as close as they can to port 443, which is normal
HTTPS traffic and tries to mimic it to avoid detection. Traffic is most likely encrypted to not disclose
what type of packets of imformation its containing or where its going. The attack is most likely extremely
slow and quiet to prevent detection.

For this type of situation I don't recommend closing port 444, it is usually an entirely useless port, however this is a situation where the attacker is already in the network, closing it would just make the attacker move to another port instead. 

### What to do now?
1. Assume compromised. Treat as threat.
2. Identify: 
How many machines are communicating there.
What are the IP's whats the source where is it going.
When has the traffic start.
How long has it started.
When does it normally start.
3. Contain:
DO NOT BLOCK PORT - Use as Forensic Evidence.
Isolate machines on port 444, DO NOT SHUT DOWN.
4. Investigate Entry - Where did it get in.
Were we a victim too:
Phishing email that executed a payload?
Exploited public facing service?
Compromised Credentials? 
Malicious Insider?
5. Eradication/Recovery
Path/Close Vulnerabilities.
Wipe/Reimage Compromised Machines.
Rotate all API's and Credentials.
Restore to clean backups.
6. Harden network. (Fool me once, shame on me. Fool me twice..?)
Dont become the same victim twice.

- Network Segmentation
- Zero Trust Architecture
- EDR (Endpoint Detection and Response.)
- Behavior Monitoring
- Least Privilege


-----
# BOT
Label: Bot, Most Common Destination Port: 8080, Hits: 1261
Label: Bot, Least Common Destination Port: 1841, Hits: 1
Label: Bot, Other Destination Ports: (Too much! Please see 'concat_RFC.ipynb for more.)

Port 8080: Super Common HTTPS traffic port (Used typically when port 80 is congested.)
Port 1841: Unregistered. Suspicious.

Bots are the beginning of something far worse. This is when a machine in the network has become a bot or more accurately, a zombie. The end goal here isn't one zombie but a massive amount of zombie to then lead to a much bigger attack like:

- DDos Attack
- Spam Campaign: Massive physhing email spree.
- Cryptomining: Very new reason for attacking machines now.
- Data theft
- Malware Spreading

## Bot Conclusion:

Bots are extremely difficult to solve. The best thing against them is always prevention. Stop the chances of them from even getting through the door and spreading. (like roaches.) 

### LAYER 1 - PREVENTION
1. Keeping all systems patched and updated keeps most bot and malware exploits away as most bot malware knows to exploit vulnerabilities not yet patched.

2. Email filtering. Blocking, attachments, links that potentially are phishing. 

3. Web Filtering. 
This is when we block well known malicious domains and drive by download sites.

4. User Awareness training.

This is mostly what users on the network can prevent themselves from doing to prevent the spread. But incase user has been potentially infected having detections to monitor that to then clean either the machine or account from becoming 'zombified' might be the best solution.

### LAYER 2 DETECTION

- EDR to monitor behavior on each machine to flag and report suspicious activity even regardless of what port.

- Network Traffic Analysis: Looks for beaconing patterns, unusual outbound connections and traffic to unknown IP'S

- DNS Monitoring:
This is where bots like to use DNS to locate their C2 server. Seeing unusual DNS queries are a major red flag.

- SIEM (Security Information and Event Management) 
Focuses and logs everything to correlate suspicious patterns.

### LAYER 3 Containment (Limiting the radius of attack)

- Network Segmentation (Separation)

- Zero Trust (Verify Everything)

- Least Privilege (Only what you need)

- Firewall Rules (Block the unknown when can.)

### LAYER 4 Response

1. Isolate
2. Contain
DO NOT SHUT DOWN
(Preserve Memory Forensics)
3. Investigate what it connects to. (What machines are talking to the infected.)
4. Assume worst.
Assume lateral movement has happened.
Check all neighbors from the infection.

### LAYER 5 Recovery
1. Wipe and reimage the infected.

2. Rotate credentials on network.

3. Patch vulnerability thats been exploited.
Review and tighten firewall and any monitoring rules if can. 

Bots are silent infectious zombies. They are 'The Walking Dead' to the network world.

-----
# PORTSCAN
Label: PortScan, Most Common Destination Port: 80, Hits: 373
Label: PortScan, Least Common Destination Port: 123, Hits: 1
Label: PortScan, Other Destination Ports: (Too much! Please see 'concat_RFC.ipynb for more.)

Port 80: Standard HTTP
Port 123: NTP (Network Timed Protocol)

PortScan probes every port, checking which ones are open and what it can tell the attacker it can get its hands on. Port 123 only has one account of it therefor not enough data however NTP is sometimes a subject of an attack by DDoS, Bot, and Infiltration attacks, so it could potentially be related.

The problem with looking at Port Scan from this direction is Port Scan knocks on all doors so other destinations is just all over the place which makes 123 port most likely an outlier. Port 80 being hit 373 at port 80 isn't that much data and I don't believe it tells us much, other than its potential that the first warning of attack could begin in port 80.

What should be focused on now is what happened after then inital portscan, what happens next is the actual attack, also why I think this dataset could drastically improve if there were timestamps of the networks movement. 

You can't prevent port scanning, but you can prevent the attack.

-----
# DDoS
Label: DDoS, Most Common Destination Port: 80, Hits: 128024
Label: DDoS, Least Common Destination Port: 64869, Hits: 1
Label: DDoS, Other Destination Ports: [64873, 27636]

Port 80: Basic HTTP port
Port 64869: Unregistered.
Port 64873: Unregistered.
Port 27636: registered range (1024–49151) NO PURPOSE.
dynamic/ephemeral port range (49152–65535)

# DDoS Conclusion
For wild ports like '64869', '64873', '27636' express immediate concern these ports typically have no assignment so seeing something that far off is an immediate red flag.

Port 80 being the most common is of no suprise, DDoS is looking to be expensive to the servers attention and looking to drain its attention to the attack, slowing down and crashing the entire network when it can.It's also using a port for HTTP and not HTTPS so it doesnt need to go through encryption so it can spam faster. 

## LAYER 1 Absorb

- CDN (Content Delivery Network)
if possible spread traffic across hundreds of servers globally so no single server gets overwhelmed making the DDoS successful.

- Load Balancers
This is a distributer from incoming traffic across multiple servers to prevent the DDoS from centralizing against one port and overwhelming the server, this offsets the load.

- Overprovisioning bandwidth
Simply if possible you have more capacity than an attacker can flood.

## Layer 2 Filtering

- DDoS scrubbing centers 
Traffic gets routed through a cleaning center that strips malicious requests before forwarding legitimate ones

- Rate Limiting
You can have the network cap at how many requests one IP can make per second limiting the chances of the network being overwhelmed. (Like a DDoS attack)

- IP Reputation filtering
Blocking known malicious IP'S and botnets automatically.

- Geo Blocking
If an attack traffic comes from specific countries that are not known for being allowed on the network we can restrict and block off that countries capability to become apart of our traffic entirely.

## Layer 3 Detect Early (Monitoring)

- Anomaly Detection
Alerts if normal traffic deviates from its normal path.

- Traffic analysis 
Identify patterns that indicate flooding behavior.

- SIEM alert
Automating alerting thresholds have been exceeded.

## Layer 4 Specialized DDoS Protection Services

- Cloudflare

- AWS Shield

- Akamai

## Layer 5 Architecture

- Anycast routing
spreads attack traffic across multiple data centers globally

- Microservices
if one service goes down others stay up. (GCP, AWS, AZURE)

- Auto scaling
Automatic spin up of more servers when traffic spikes

- Redundant ISP connections
Multiple internet connections so if one gets flooded it doesn't take down the whole operation.



-----
# FTP-PATATOR
Label: FTP-Patator, Most Common Destination Port: 21, Hits: 7937
Label: FTP-Patator, Least Common Destination Port: 80, Hits: 1
Label: FTP-Patator, Other Destination Ports: []

Port 21: (OUTDATED MUST BE CLOSED) Legacy FTP
Port 80: Basic HTTP

## FTP-PATATOR Conclusion
Port 21 is a very outdated file transfer protocol that has very little use in 2026 but is often still used by companies today like government, healthcare and old 2000s generation companies that still havent replaced old hardware or closed the port entirely.

Extremely obsolete and needs to be shut closed.

However this doesn't completely cover Patator as a whole. Patator is a brute force tool that systematically tries a bunch of different combinations until it cracks your username and password.
Patator is not limited to only FTP. 

(Think of this as trying every combination in a combination lock.)

Finally this FTP-Patator will then log in for full FTP access.

### What to do

- Close Port 21 entirely
- Migrate to SFTP on port 22
- Implement account lockout policies
- Rate limit login attempts
- If port 21 must stay open whitelist trusted IPs only

-----
# SSH-PATATOR
Label: SSH-Patator, Most Common Destination Port: 22, Hits: 5897
Label: SSH-Patator, Least Common Destination Port: 22, Hits: 5897
Label: SSH-Patator, Other Destination Ports: []

Port 22: SSH Secure Shell Protocol

## SSH-Patator Conclusion
SSH-Patator only likes and cant hit port 22, port 22 is extremely dangerous if an attacker has their hands on this in your network. Does the same exact thing FTP does but SSH is much more dangerous/sensitive. Brute force combination lock hack.

Gives attacker access to:

- Full command line control.
- Can do anything on that machine
- Install malware
- Create backdoors
- Move Laterally through network
- Exfiltrate data
- Creating backdoor account
- Installing rootkit
(hides presence within machine)


Entire machine is compromised once SSH-Patator is successful.

### What to do

- Install 2-Factor Authentication
- Port knocking
Until the port is needed and a sequence of ports are hit the port stays entirely closed.
- Fail2ban
blocks IP's after failing attempts automatically
- Rate Limiting
Very practical for all kinds of brute force attempts using slow down or lock outs for too many attempts. This can stop most brute force attempts.
- IP whitelisting
Simply only trusted IP's can use from this port.

-----
# Dos slowloris
Label: DoS slowloris, Most Common Destination Port: 80, Hits: 5796
Label: DoS slowloris, Least Common Destination Port: 80, Hits: 5796
Label: DoS slowloris, Other Destination Ports: []
Port 80: Basic HTTP

## Dos slowloris conclusion:
Unlike a normal DDoS attack that floods you, is obvious and just got for the objective 
its looking to do and harm. 'Dos slowloris' is strategic more silent and harder to see. It slowly
bombs the network to avoid detection using very little bandwidth.

Slowloris opens many connections to the server sending partial incomplete requests making the server wait thinking the complete request will come to complete it.

This drastically limits the connection slots halting anyone else from using the network.

### What to do

- Connection timeout settings 
- Limit connections per Ip
(limits one source from holding too many connections with the network)
- Load balancers
Distributes and manages connections much more efficiently.
- Nginx 
- Cloudflare



-----
# Dos Slowhttptest
Label: DoS Slowhttptest, Most Common Destination Port: 80, Hits: 5499
Label: DoS Slowhttptest, Least Common Destination Port: 80, Hits: 5499
Label: DoS Slowhttptest, Other Destination Ports: []
Port 80: Basic HTTP

## Dos Slowhttptest Conclusion

Slowhttptest is the same as slowloris but comes with more, it uses more techniques than slowloris to do the same objective.

- Slowloris
- Slow POST
- Slow Read
- Range Header

### What to do

- Connection timeout settings 
- Limit connections per Ip
(limits one source from holding too many connections with the network)
- Load balancers
Distributes and manages connections much more efficiently.
- Nginx 
- Cloudflare

-----
# DoS Hulk
Label: DoS Hulk, Most Common Destination Port: 80, Hits: 231073
Label: DoS Hulk, Least Common Destination Port: 80, Hits: 231073
Label: DoS Hulk, Other Destination Ports: []
Port 80: Basic HTTP

## Dos Hulk Conclusion

All Dos especially when coming from port 80 are all doing relatively have the same objective and just do it in different ways.

'Dos Hulk' sends massive and agressive waves of caching nonsense the network tries to read but cant. Nothing in them, the link goes no where, floods all space in the network slowing and crashing it.

### What to do
Same as the rest.

- Rate Limiting
- CAPTCHA
(Humans arent Dos attacks.)
- IP reputation filtering
- Cloudflare or WAF
- Load Balancing 
- Connection timeout settings 

-----
# DoS GoldenEye
Label: DoS GoldenEye, Most Common Destination Port: 80, Hits: 10293
Label: DoS GoldenEye, Least Common Destination Port: 80, Hits: 10293
Label: DoS GoldenEye, Other Destination Ports: []
Port 80: Basic HTTP

## DoS GoldenEye Conclusion:
Combination of Hulk and Slowloris.

Hulk - Sending unique request generation

Slowloris - Slow and exhausting.

### What to do
Same as all the rest.
- WAF
- Rate limiting
- Connection timeouts
- Cloudflare
- Nginx
- IP reputation
- CAPTCHA
(Humans arent Dos attacks.)
- Load Balancing 


-----
# HeartBleed
Label: Heartbleed, Most Common Destination Port: 444, Hits: 11
Label: Heartbleed, Least Common Destination Port: 444, Hits: 11
Label: Heartbleed, Other Destination Ports: []

## HeartBleed Conclusion:

Heartbleed is a critical vulnerability in OpenSSL, the encryption library used by 
millions of servers to handle secure HTTPS and SSL/TLS connections.

SSL connections use a heartbeat mechanism to keep connections alive. A machine sends 
a heartbeat message to the server saying "I am still here, send back X bytes to confirm." 
Heartbleed exploits this by sending a heartbeat claiming to carry a large amount of data 
but actually sending almost nothing. The server then reads back a large chunk of its own 
memory to fulfill the request, unknowingly handing over whatever sensitive data was 
stored there at the time. This could include passwords, private encryption keys, 
and session tokens.

It's almost as if 'Heartbleed' is the pirate in a sea of SSL data

Port 444 only recording 11 hits is expected. Heartbleed is not a flood attack, 
it is a precise surgical strike. One successful hit can expose everything, 
making 11 attempts significant despite the low volume. However the more this 
attack is recorded, the better the chance the model can see it for the future.

### What to do

- Patch OpenSSL immediately to the latest version
- Revoke and reissue all SSL certificates
- Rotate all passwords and session tokens that may have been exposed
- Update all software dependent on the vulnerable OpenSSL version
- Implement WAF rules to detect and block Heartbleed exploitation attempts


-----
# Web Attack � Brute Force
Label: Web Attack � Brute Force, Most Common Destination Port: 80, Hits: 1507
Label: Web Attack � Brute Force, Least Common Destination Port: 80, Hits: 1507
Label: Web Attack � Brute Force, Other Destination Ports: []
Port 80: Basic HTTP

## Web Attack � Brute Force Conclusion:

Exactly like 'FTP-PATATOR and 'SSH-Patator' but web based and brutal.
It tries every combination for either username or password or both until its broken.

### What to do
Same as 'FTP-PATATOR and 'SSH-Patator' but for the website.

- Install 2-Factor Authentication
- Port knocking
- Fail2ban
- Rate Limiting
- IP whitelisting
- Implement account lockout policies
- CAPTCHA

-----

# Web Attack � XSS
Label: Web Attack � XSS, Most Common Destination Port: 80, Hits: 652
Label: Web Attack � XSS, Least Common Destination Port: 80, Hits: 652
Label: Web Attack � XSS, Other Destination Ports: []
Port 80: Basic HTTP

## Web Attack � XSS Conclusion:

XSS (Cross-Site Scripting)

This is when the attacker injects malicious Javascript into a webpage, the victim goes to the website and accidentally executes the JavaScript harming their machine.

This can lead to potential:

- Stealing of session cookies
- Capture keystrokes
- Redirect users to malicious sites
- Hijack browser sessions

### What to do 

- Input sanitation
(Turns all special characters into plain text, no code allowed.)
- Content Security policy
Browser can now only execute code thats been approved sources.
- HTTPOnly cookies
Simply tells website that the cookies cannot be in javascript.
- WAF
(WEB APPLICATION FIREWALL)


-----
# Web Attack � Sql Injection
Label: Web Attack � Sql Injection, Most Common Destination Port: 80, Hits: 21
Label: Web Attack � Sql Injection, Least Common Destination Port: 80, Hits: 21
Label: Web Attack � Sql Injection, Other Destination Ports: []
Port 80: Basic HTTP

## Web Attack � Sql Injection Conclusion
Same exact concept as 'Web Attack � XSS' but in SQL this time however actually targeting the database
instead of the user and the machine. Steals, modifies, destroys data.

- Attacker accesses entire database
- Every user account
- Every password
- Every credit card
- Every piece of data ever stored
- Can delete everything
- Far more catastrophic

### What to do 
- Input sanitation
(Turns all special characters into plain text, no code allowed.)
- Parameterized Queries
Database never sees inputs as executable code.
- WAF
(WEB APPLICATION FIREWALL)
- HTTPS Port 443

-----

# Thoughts

I understood that you can't just close ports at the beginning of this to solve all your problems even though, some of the best network protection you can do it, is the port being used? No? Close. However I was expecting at least more than one suggestion was going to be close a port its not needed. 

# Conclusion:

Infiltration
- Network Segmentation
- Zero Trust Architecture
- EDR (Endpoint Detection and Response.)
- Behavior Monitoring
- Least Privilege

Bot
- Network Segmentation (Separation)
- Zero Trust (Verify Everything)
- Least Privilege (Only what you need)
- Firewall Rules (Block the unknown when can.)
PortScan
Cannot Prevent. Only can prevent the upcoming attack.

DDoS
- Anycast routing
spreads attack traffic across multiple data centers globally
- Microservices
if one service goes down others stay up. (GCP, AWS, AZURE)
- Auto scaling
Automatic spin up of more servers when traffic spikes
- Redundant ISP connections
Multiple internet connections so if one gets flooded it doesn't take down the whole operation.

FTP-Patator
- Close Port 21 entirely
- Migrate to SFTP on port 22
- Implement account lockout policies
- Rate limit login attempts
- If port 21 must stay open whitelist trusted IPs only

SSH-Patator
- Install 2-Factor Authentication
- Port knocking
Until the port is needed and a sequence of ports are hit the port stays entirely closed.
- Fail2ban
blocks IP's after failing attempts automatically
- Rate Limiting
Very practical for all kinds of brute force attempts using slow down or lock outs for too many attempts. This can stop most brute force attempts.
- IP whitelisting
Simply only trusted IP's can use from this port.

Dos slowloris
- Connection timeout settings 
- Limit connections per Ip
(limits one source from holding too many connections with the network)
- Load balancers
Distributes and manages connections much more efficiently.
- Nginx 
- Cloudflare

DoS Slowhttptest
- Connection timeout settings 
- Limit connections per Ip
(limits one source from holding too many connections with the network)
- Load balancers
Distributes and manages connections much more efficiently.
- Nginx 
- Cloudflare

DoS Hulk
- Rate Limiting
- CAPTCHA
(Humans arent Dos attacks.)
- IP reputation filtering
- Cloudflare or WAF
- Load Balancing 
- Connection timeout settings 

DoS GoldenEye

- WAF
- Rate limiting
- Connection timeouts
- Cloudflare
- Nginx
- IP reputation
- CAPTCHA
(Humans arent Dos attacks.)
- Load Balancing 

Heartbleed
- Patch OpenSSL immediately to the latest version
- Revoke and reissue all SSL certificates
- Rotate all passwords and session tokens that may have been exposed
- Update all software dependent on the vulnerable OpenSSL version
- Implement WAF rules to detect and block Heartbleed exploitation attempts

Web Attack � Brute Force
- Install 2-Factor Authentication
- Port knocking
- Fail2ban
- Rate Limiting
- IP whitelisting
- Implement account lockout policies
- CAPTCHA

Web Attack – XSS
- Input sanitation (turns all special characters into plain text, no code allowed)
- Content Security Policy (browser only executes code from approved sources)
- HTTPOnly cookies (cookies cannot be accessed by JavaScript)
- WAF (Web Application Firewall)

Web Attack � Sql Injection Conclusion
- Input sanitation
(Turns all special characters into plain text, no code allowed.)
- Parameterized Queries
Database never sees inputs as executable code.
- WAF
(WEB APPLICATION FIREWALL)
- HTTPS Port 443

------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

#  Conclusion
Date: May 18th, 2026

Wrote conclusion. Still an on going project, conclusion holds what has already been done.

------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: MATLAB | VS Code | Python/Kagglehub

# MATLAB EXPERIMENT

## Overview
Statistical analysis of the CIC-IDS-2017 Network Intrusion 
Detection dataset using MATLAB, pulling 2.8 million rows of 
network traffic data via KaggleHub API through a Python-MATLAB 
bridge.

## EXTRACTION
First time extracting KaggleHub to MATLAB using python
MATLAB cannot see Kaggle without Python, once the dataset
of 2.8 million is in a cache were are able to extract the data
without taking over the computers memory. 

**Problem:** MATLAB is extremely variable name sensitive.
Column headers with leading spaces and special characters 
caused errors during CSV concatenation in the for loop.

**Solution:**
```matlab
readtable(filePath, 'VariableNamingRule', 'preserve');
```
This tells MATLAB to preserve the original column headers 
exactly as they appear in the dataset instead of 
auto-sanitizing them.

---- MATLAB NOTES ------
% Very interesting find, these values have a space at the front of them
% Within the dataset, however error was found, MATLAB automatically 
% sanitizes existing values, removing the spaces. 
% Ended up having to use 'VariableNamingRule' to clean up the error
% ignores anything MATLAB dislikes within the variable name.
---- MATLAB NOTES ------


 ## % CONCLUSION:

 Normal traffic typically has more forward than backward packets.
The dataset shows backward packets slightly exceeding forward 
packets which could indicate data exfiltration — attackers 
extracting more data than they send, helping them stay 
under the radar.

---- MATLAB NOTES ------

% --- BWD > FWD----
% Normal traffic has more forward than backward packets
% could potentially be a sign of data ex-filtration
% this attack could have the data extracting more then being
% sent it keeping them off the radar.

---- MATLAB NOTES ------

## Files

| `CONCAT_MATLAB_.m` | MATLAB analysis script |

------------------------------------------------------------------

Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub


# CONCAT RFC + SMOTE / SQL
Date: June 3rd, 2026


Goal: 

Apply SQL to compare Infiltration to Heartbleed to determine low F1 Score

Apply SMOTE to the CONCAT RFC model to improve detection on the rarest attack classes
and compare findings against the SQL packet length analysis as well as remove any data leakage.

Hypothesis:

Data scarcity for both, however infiltration must have higher variable difference compared to BENIGN
that makes it easier to detect than heartbleed. 

## SQL Observation

Infiltration:

          Label  Destination Port  total_flows  avg_flow_duration  \
0  Infiltration               444           36         78407720.5   

   avg_packet_length  avg_flow_bytes_per_sec  avg_fwd_packets  \
0         161.101292             20188.21903       830.222222   

   avg_bwd_packets  avg_init_win_fwd  avg_init_win_bwd  avg_psh_flags  \
0       829.611111       2111.166667            1732.0       0.555556   

   avg_ack_flags  
0       0.833333  

heartBleed:

        Label  Destination Port  total_flows  avg_flow_duration  \
0  Heartbleed               444           11       1.106797e+08   

   avg_packet_length  avg_flow_bytes_per_sec  avg_fwd_packets  \
0        1626.602318            65902.802173      2583.727273   

   avg_bwd_packets  avg_init_win_fwd  avg_init_win_bwd  avg_psh_flags  \
0      1897.181818       2899.272727        276.454545            0.0   

   avg_ack_flags  
0       0.909091  

## SQL Conclusion

Heartbleed avg packet length is 10x larger than Infiltration and still more 
unnoticeable in the predictive model than infiltration. 

avg flow bytes per second is 3x more data per second

avg fwd packet heartbleed is way more foward traffic 

avg bwd packet infiltration is much more balanced while heartbleed is much more
noticeable

avg init win bwd heartbleed (276) is anomalously low compared to infiltration (1732), a highly suspicious server receive window asymmetry

avg psh flag, heartbleed is completely 0 infiltration is 0.56

Heartbleed had more noticeable variable change overall compared to infiltration despite drastically being underfitted in my model compared to infiltration beating my hypothesis. 

## SQL Analysis Note

Maybe the avg init win bwd and  avg psh flag that makes infiltration much more
noticeable than heartbleed but every other factor in this makes heartbleed much more active and bigger for the model to predict rather than infiltration.

I still believe this is data scarcity and more data is required in order for the model to predict these two variables more.

## SMOTE CONCAT RFC Observation

1. First thing I confirmed was that the SMOTE targets (8, 9, 13) were actually correct.
Label 8 is Heartbleed (9 total samples), Label 9 is Infiltration (29 total samples),
Label 13 is Web Attack - SQL Injection (17 total samples). These are genuinely the three
rarest classes in the entire 2.8 million row dataset. SMOTE was pointing at the right problem.

2. The first real issue wasn't SMOTE at all. The model wasn't finishing because class 0 (BENIGN)
alone had 1.8 million training rows. Training 100 trees on 2.26 million samples with no
parallelization or undersampling caused the model to hang and never produce output.
The fix was adding a RandomUnderSampler after SMOTE to bring the dominant classes
(0, 2, 4, 10) down to 50,000 each, making training actually feasible, and adding
class_weight='balanced' to the RFC.

3. Once the model ran, 8 and 9 came in at reasonable F1 scores. However, the test support
for these classes was 2, 7, and 4 samples respectively. These scores are statistically
meaningless at that size. One missed prediction swings the entire F1. Class 8 scoring 1.00
just means it got 2 right, not that the model truly understands Heartbleed.

4. Added class 14 (Web Attack - XSS) to SMOTE targeting it at 1000. Result barely changed,
F1 went from 0.34 to 0.39. This confirmed that class 14's problem isn't sample count,
it's that XSS traffic at the network flow level is nearly identical to normal HTTP traffic.
SMOTE generating more synthetic XSS samples doesn't help when the model can't tell them
apart in the feature space to begin with.


# Analysis

The most significant finding came from connecting the RFC results to the SQL packet
length analysis.

Heartbleed avg packet length: 1626
Infiltration avg packet length: 161

This explains the RFC behavior completely. Heartbleed has an enormous and distinctive
packet signature because of the exploit mechanics. It asks the server to return far more
data than it sends, producing unusually large packets. Even with only 9 real samples the
RFC picks it up because the signal is that obvious.

Infiltration on the other hand is deliberately quiet. It mimics normal HTTPS traffic on
port 444 with small packets, slow movement, and encrypted payloads designed to avoid
detection. The model struggles because thats exactly what the attacker intended.

XSS follows the same logic. Its an application-layer attack that looks like plain HTTP
traffic at the flow level. No anomalous packet size, no unusual port, nothing that
sticks out in the features this dataset captures.

The original hypothesis was that Infiltration would be more noticeable from packet size.
The conclusion proved the opposite and in doing so explained why the model behaves the
way it does across all three models (RFC, XGBOOST, PyTorch) on these classes.

It isn't about how many samples you have. It's about how distinctive the network signature is.
Heartbleed announces itself. Infiltration and XSS hide.


# Conclusion

SMOTE worked as intended and was targeting the right classes. The deeper finding is that
for attacks like Infiltration and XSS, resampling techniques hit a ceiling set by the
feature space itself. No amount of synthetic data can teach a model to detect an attack
that is engineered to look like normal traffic at the network level.

Classes 8, 9, 13 remain limited by the dataset. Classes 12 and 14 remain limited by
feature overlap. The model performs well on 11 of 15 classes and the remaining 4 have
documented and explainable reasons for their shortcomings which is a finding in itself.

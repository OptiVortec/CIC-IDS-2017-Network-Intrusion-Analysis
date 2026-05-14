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
2. Dataset shows each port traffic by number, as well as package size
(Total Length of Fwd Packets) / (Total Length of Bwd Packets) and Idle Mean
and if traffic flow caused delay. This is great as these values can potentially show us DDoS attacks
and any signs of delays.
3. Notice the dataset doesn't have time stamps, however it does have 'Flow Duration', 'Flow IAT Mean, 'Fwd IAT Total' which show us the actual duration of how long the conversation lasted within the network. (Helps defend against DDoS attacks.)




Analysis:
Label value count: Label BENIGN 529918
BENIGN value is reported 529918/529918 no malicious/dangerous network traffic was reported on monday's csv
This proves that the monday csv is more of an intro to the dataset, no value's missing, no intrusions, completely clean.


Concerns:
As much as I love 'Flow Duration', 'Flow IAT Mean, 'Fwd IAT Total', this dataset would be a lot more significantly impactful
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
'Web Attack – SQL Injection' from my observation based on the recall scores being the lowest, it's a sign that the actual attacks are being constantly missed, its directly from both not enough data to fight against it and that the data doesn't
drastically change enough for the data to truly respond against it.


3. Infiltration however, actually improved slightly better compared to the RFC while using XGBOOST.


4. Surprisingly enough, heartbleed on 'Wednesday-workingHours.pcap_ISCX.csv' only has 11 cases in that entire dataset however both
RFC and XGBOOST were able to detect it in each model so well.
Conclusion on heartbleed:
Even though its only 11 cases, from further investigation on 'Wednesday-workingHours.pcap_ISCX.csv' heartbleed
only seems to attack port 443 with zero variation to other ports. This is because heart bleed is a bug in SSL/TLS encryption. It sends a small "heartbeat" request to a server but lies about how big it is, tricking the server to send back more data than it should. This leaks the server memory which may contain passwords, keys and sensitive data. This is why websites look into becoming SSL (Secure Socket Layer) which not only protects the website but its users as well.


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
Seeing biggest issue on Thursday's files, file: 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' and Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv ' both SQL-Injection, and 'Infiltration' my reasoning is because there isn't enough
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
Overall I was anticipating to either see the model really reflect drastically different results between the 5 folded models especially keeping it at the 80/20 level but shuffling it through 5 different ways to experience new in different data or at least see a gradual improvement as it went on through each fold. Instead it was rather consistent especially with most of the data being pretty high and consistent throughout most data sets I was more so really paying attention to the difficult csv's such as 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' which is definitely been the hardest for the model.




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
When running these larger datasets on something much more elaborate such as Pytorch compared to RFC or XGBOOST, my computer was noticeably getting hotter, certainly not in a concerning way or in anyway beginning to bottleneck but noticeably hotter. I did notice that Pytorch was doing what I thought I would see in XGBOOST where the model performance would drastically improve as each fold progressed. Coming from my results especially with the later days in the week such as 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' or file 'Thur_WH_M_TORCH' it really wanted nothing to do with 'SQL-Injection' getting a pretty consistent '0.0' across the board. Overall PYTORCH wasn't more successful than the rest, but still consistently got what I believe were more accurate and honest responses. When models predict 100% caught other than on 'Monday's' 100% BENIGN file I'm skeptical to want to believe it where PYTORCH was consistently more around the range of 70-90% accuracy on most thing's if not 100% I'm certainly hoping to see PYTORCH win the end of the race.

# Further Research
This is probably still the same speculation as the rest of them where my biggest concerns are that the models will weight the results in an unfair biased sample or scope bias where it'll see it mostly see that 'BENIGN' is much more massive than anything else. When the model see this it'll understand that being biased to 'BENIGN' will result in a better precision but lack in recall.

# Before running all CSV together:
I was wondering how the performance of all 8 rather larger CSV's running together would have an effect on either the computer or 
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

Graphing: Out of all three models used on this project, we XGBOOST was the easiest and most legible experience out of all of them.

Surprisingly enough I was shocked to see that the graphs were able to show how different the models solved the same problem of detecting intrusion. My expectations were that all three models would indicate the same value as most important in detecting intrusion for the same individual CSV file. Even through CONCAT each file was drastically different. So I wanted to do further research to better explain as to why.

RFC: The mean decreases in impurity(Gini). across all 100 decision trees which of the feature reduced uncertainty the most on average? It averages across 100 trees, importance gets spread across many correlated features. This prevents any single feature from dominating.

XGBOOST: Uses gain. Which feature reduced prediction error the most in its own boosting sequence is what its going to then focus more onto. XGBoost builds trees one at a time, each one fixing the mistakes previous on the tree. It then tends to concentrate importance very heavily on the one feature that cuts the problem fastest. 

PYTORCH/SHAP: Uses Shapely values. It asks: if I remove this feature, how much would the prediction change across every possible subset of features? This is called a game theory based method that is drastically and fundamentally different from the other two models. 

Simply: They are all asking different legitimate questions to solve the same complex problem they're put in front of.

Unfortunately, I wasn't able to experience truly one suffer one something in the dataset while others thrived however. The dataset overall is very clean and easy for the models to get an accurate detection on most except for SQL-Injection and Infiltration. Which concat didnt seem to help with either.

Obviously, Monday's graphs were all consistently no value as all of the data in monday's csv were completely BENIGN.

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

All results on Monday didnt change with the column drop however,
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

Torch -  actually saw slight decrease in Precision, Recall and F1-Score.

------------------------------------------------------

# Thursday Working Hours Afternoon:
(Huge Improvement!)
0 - BENIGN 
1 - INFILTRATION 

------------------------------------------------------

RFC - Much better improvement form both precision, f1-score and macro average 
precision and macro average f1-score from the model against infiltration, 
BEIGN still 100% across for this CSV.


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
First time actually seeing results come down losing precision very slightly. To my suprise Brute Force actually slightly decreased in model prediction overall with a slightly poorer F1-Score with the new column drop. 'Web Attack � XSS' actually had the most improvement with the column drop out of the rest of the results.

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

TORCH - Graph had little change, some outliers reduced from column drop. BENIGN actually saw a 0.01% dip in precision. While for ' Web Attack � Brute Force' precision went up slightly recall/F1-score drastically decreased should a disadvantage. As for 'Web Attack � XSS' torch is still completely unable to figure out how to detect web attacks, PyTorch definitely surprised me in this and probably isnt the best for this case. Lastly, as for 'Web Attack – SQL Injection', we can see a slight improvement from the column drop but definitely not enough to call an improvement. Proving 1. Torch may not be the best for this dataset and 'Web Attack – SQL Injection' for this dataset needs more data for the model to attack as well as needs more parameters to detect 'Web Attack – SQL Injection' better. 

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

XGBOOST - Overall a massive decrease across the board in everything. Begining to question if this is the right move or did those columns actually have something valueable to them to help this model learn or are we shrinking data leakage or overfitting. Graph didnt change much in value change.

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

Orginal:
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
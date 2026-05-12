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
Discovery: Once I loaded the files to the dataset I first noticed only 8 files to the dataset.
These data sets were rather larger than most.


Analysis: All 8 files were explaining the days of the week Monday, Tuesday, Wednesday, Thursday, Friday.
However not Saturday or Sunday, suggesting that this data set is only referring to an average workweek excluding weekends.


Concern: A potential attack doesn't just come from an average work week. Potential attacks are always 24/7.
Understanding this is only recorded previous data I wonder how this would effect understanding weekend traffic
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
2. Compared to monday that was all BENIGN I began to see more and more potential and intimate attacks.
(DdoS), (Brute Force), (PortScan), (DoS Hulk), (DoS GoldenEye) (DoS slowloris), (DoS Slowhttptest), (Heartbleed)
3. Wednesday had some of the most interesting attacks and labels compared to the rest of the days. (692703) values.
I certainly feel as if this one will be the largest of the rest.


Analysis: The next step is to predict how well a ML model can predict such attacks based on using the the dataset provided.


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
ensured that my X and Y values were in the correct position in my 'TrainTestSplit' model. Came back good. Then made sure my
X_train and X_test values were both coming back as '<class 'numpy.ndarray'>' to ensure there was no class error issue. There wasn't.


2. I was expecting more of a delay in my outputs when testing the results of my models. The slowest at 58.6 seconds and the shortest
being Monday at 1.2 seconds. I can certainly predict that when putting the models together using 'concat' the model prediction is going
to take much longer, also limiting the accuracy of 'Random Forest Tree' and 'XGBOOST' will increase the odds of my prediction but make the process
drastically slower to output.


Analysis: So far Random Forest Tree has been able to accurate predict potential threats based on traffic information to determine what is an attack
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
'Web Attack � Sql Injection' from my observation based on the recall scores being the lowest, it's a sign that the actual attacks are being constantly missed, its directly from both not enough data to fight against it and that the data doesn't
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
Seeing biggest issue on Thusday's files, file: 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' and Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv ' both SQL-Injection, and 'Infiltration' my reasoning is because there isn't enough
data on these attacks for the model to truly understand them yet/the parameters on the dataset for both SQL injection and Infiltration are so minute that it's hard to predict when the model displays such little difference compared to BENIGN more data could help this result.


concat data with all 8 files may help finding more evidence on these two parameters become detectable but im not too hopeful.


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
#  PYTORCH STRESS - Nivida CPU vs MAC GPU via MPS
Date: May 1st, 2026


Goal: Start up pytorch for each individual CSV and compare.
2nd Goal: Understanding computer internal architecture (creates massive efficiency)

# PYTORCH 
Pytorch is some of the latest modeling open source deep learning framework to date being used on some of the biggest deep learning framework trends to today such as sensors on cars like stop assist, lane assist, and self driving (computer vision), image generation and speech recognition. This uses a multi dimensional arrays (tensors) AI platform (deep neural network) using high performance parallel computing from both the CPU and the GPU 

The biggest focus to what people love about using it in models is its optimization to improve its statistical modeling while on run time, something I was expecting to see more in XGBOOST. This is called (Dynamic Computation Graph) where  Directed Acyclic Graph (DAG) that has functions focus on memorizing executed operations on the tensors allowing you to change size, operation and shape while on each iteration.

# UNEXPECTED FIND
When running these rather massively larger datasets:

When running these rather larger datasets on something much more elaborate such as Pytorch compared to RFC or XGBOOST, my computer was noticeably getting hotter, certainly not in a concerning way or in anyway begining to bottleneck but noticeably hotter. I did notice that Pytorch was doing what I thought I would see in XGBOOST where the model performance would drastically improve as each fold progressed. Coming from my results especially with the later days in the week such as 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' or file 'Thur_WH_M_TORCH' it really wanted nothing to do with 'SQL-Injection' getting a pretty consistent '0.0' across the board. Overall PYTORCH wasn't more successful than the rest, but still consistently got what I believe were more accurate and honest responses. When models predict 100% caught other than on 'Monday's' 100% BENIGN file I'm skeptical to want to believe it where PYTORCH was consistently more around the range of 70-90% accuracy on most thing's if not 100% I'm certainly hoping to see PYTORCH win the end of the race.

# Further Research
This is probably still the same speculation as the rest of them where my biggest concerns are that the models will weight the results in an unfair biased sample or scope bias way were it'll see it mostly see that 'BENIGN' is much more massive then anything else. When the model see this it'll understand that being biased to 'BENIGN' will result in a better precision but lack in recall.

# Before running all CSV together:
I was wondering how the performance of all 8 rather larger CSV's running together would have an effect on either the computer or 
the performance of the model. So I began to research for efficiencies in my pytorch code. It so happens that I was utilizing the code 'NeuralNet(input_size, num_classes)' which is technically correct for the idea of NVIDIA's CUDA GPU design. However this severely bottlenecks macs performance. By simply adding '.todevice()' we get mac's full potential. See when we want to utilize both the CPU and Gpu power from NVIDIA's CUDA design the CPU and GPU are not connected and the code understands this however for a macbook their all together on one logic board system. When running Pytorch on mac without '.to(device)' my GPU isnt working putting all the power on the CPU's cores alone. Pretty impressive the macbook was able to still do the data but a simple extra heat on my lap had me thinking to ask why?


----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

#  CONCAT FILES
Date: May 2nd, 2026

Concat did not help SQL-Injection which proves my theory that this isnt a modeling problem however is a data problem. With 2.8 million rows of data SQL-Injection is just so rare and the dataset shows such little difference in change that its almost impossible for the model to predict. Even proven before that dropna was simply only dropping values that were inf from the values, nothing of value that could benefit the data to better predicting SQL-Injection. However I did notice that, infiltration did go up and improve slightly with concat getting more access of data did infact improve it's chances in the model to be detected.

----------------------------------------------------------------------------------------------------------------------------------

Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

#  CSV/CONCAT Graphs
Date: May 5th, 2026

Graphing: Out of all three models used on this project, we XGBOOST was the easiest and most legable experinnce out of all of them.

Surprisingly enough I was shocked to see that the graphs were able to show how different the models solved the same problem, dectecting intrusion. My expectations were that all three models would indicate the same value as most important in detecting intrusion for the same individual CSV file. Even through CONCAT each file was drastically different. So I wanted to do further research to better explain as to why.

RFC: The mean decreases in impurity(Gini). across all 100 decision trees which of the feature reduced uncertiantity the most on average? It averages across 100 trees, importance gets spread across many correlated features. This prevents any single feature from dominating.

XGBOOST: Uses gain. Which feature reduced prediction error the most in its own boosting sequence is what its going to then focus more onto. XGBOOST builds tress one at a time, each one fixing the mistakes previous on the tree. It then tends to concentrate importance very heavily on the one feature that cuts the problem fastest. 

PYTORCH/SHAP: Uses Shapely values. It askes if I remove this feature, how much would the prediction change across every possible subset of features? This is called a game theory based method that is drastically and fundementally different from the other two models. 

Simply: They are all asking different legitimate questions to solve the same complex problem their put in front of.

Unfortuntately, I wasnt able to experience truly one suffer one something in the dataset while others thrived however. The dataset overall is very clean and easy for the models to get an accurate detection on most except for SQL-Injection and Infiltration. Which concat didnt seem to help with either.

Obviously, Monday's graphs were all consistently no value as all of the data in monday's csv were completely BENIGN.

Most important column: 

Monday: Doesnt have a most column all is BEIGN

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
RFC - init_Win_bytes_foward
XGBOOST - Bwd IAT Min
TORCH/SHAP - Flow Duration

Friday Afternoon P:
RFC -  Total Length of Fwd Packets
XGBOOST - Total Length of FWD Packet
TORCH/SHAP - Flow Duration

Friday Afternoion D:
RFC - Avg Fwd Segment Size
XGBOOST - Fwd Packet Length Mean 
TORCH/SHAP - Flow Duration

RFC - More diverse than Torch but mainly likes packet movement
XGBOOST - Most Diverse than all of them
Torch loved only really Destination Port/Flow Duration

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
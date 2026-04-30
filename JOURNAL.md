# Project Journal: CIC-IDS-2017 Analysis

Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

# Enviornment Setup & Security
Date: April 24, 2026

Goal: Initalize a professional Git repository with an .env safely and securely.

# Interuptions
Problems: Standard issues, update Python, VS Code.
Solution: Restarting enviorment, force update VS Code through website.

# Observation
Scoping DataSet:
Discovery: Once I loaded the files to the dataset I first noticed only 8 files to the dataset. 
These data sets were rather larger than most.

Analysis: All 8 files were explaining the days of the week Monday, Tuesday, Wednesday, Thursday, Friday.
However not Saturday or Sunday, suggesting that this data set is only referring to an average workweek excluding weekends.

Concern: A potential attack doesnt just come from an average work week. Potential attacks are always 24/7.
 Understanding this is only recorded previous data I wonder how this would effect understanding weekend traffic 
 and potential attacks. 
(Sample Bias)

----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

# Monday_WorkingHours
Date: April 24, 2026

Goal: Observe the first CSV file, see what is avaliable to take from the dataset.

# Observation
1. Dataset: (529918 rows x  79 columns) Dataset shows each port and network traffic going through the dataset.
BENIGN value count 529918/529918
2. Dataset shows each port traffic by number, as well as package size 
(Total Length of Fwd Packets) / (Total Length of Bwd Packets) and Idle Mean
and if traffic flow caused delay. This is great as these values can potentially show us DDoS attacks
and any signs of delays.
3. Noticed the dataset doesnt have times stamps, however does have 'Flow Duration', 'Flow IAT Mean, 'Fwd IAT Total' which show us the actual duration of how long the conversation lasted within the network. (Helps defend against DDoS attacks.)


Analysis:
Lable value count: Label BENIGN 529918
BENIGN vallue is reported 529918/529918 no malious/dangerous network traffic was reported on monday's csv
This proves that the monday csv is more of an intro to the dataset, no value's missing, no intrusions, completely clean.

Concerns:
As much as I love 'Flow Duration', 'Flow IAT Mean, 'Fwd IAT Total', this dataset would be alot more significantly impactful 
against attacks if we had actual timestamps to work with. Timestamps can help us accurately spot 'temporal pattern analysis'. Where we can spot and location potential patterns and determine when were most likely to be attacked.
----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

#  Observe Monday-Friday

Goal: Open, Compare and Observe each CSV file seperately, organize each file in it's own designated folder based on the day.

#  Observation
1. First I noticed how big these files were seperated let alone all together.
2. Compared to monday that was all BENIGN I began to see more and more potential and imtiment attacks.
(DdoS), (Brute Force), (PortScan), (DoS Hulk), (DoS GoldenEye) (DoS slowloris), (DoS Slowhttptest), (Heartbleed)
3. Wednesday had some of the most interesting attacks and labels compared to the rest of the days. (692703) values.
I certainly feel as if this one will be the largest of the rest.

Analysis: The next step is to pedict how well a ML model can predict such attacks based on using the the dataset provided.

----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

# ML Monday-Friday
Date: April 26, 2026

Goal: Simple Random Forest Tree (Mon-Fri) comparison.

# Observation
1. I was not expecting a 'Random Forest Tree' method would be so accurate in its perdictions. At first Monday seemed
to experience a perfect result predicting rate of a 100%. I first believed it to be accruate due to Monday beeing
entirely BENIGN, so I went foward with Tuesday to see if the same anomoly would continue. Tuesday also came in at 100%
accuracy. At first I thought I was experencing 'data leakage' with how well the model was originally doing. I first
ensured that my X and Y values were in the correct position in my 'TrainTestSplit' model. Came back good. Then made sure my 
X_train and X_test values were both coming back as '<class 'numpy.ndarray'>' to ensure there was no class error issue. There wasnt.

2. I was expecting more of a delay in my outputs when testing the results of my models. The slowest at 58.6 seconds and the shortest 
being Monday at 1.2 seconds. I can certainly perdict that when putting the models together using 'concat' the model prediction is going
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
1. First observation was XGBOOST speed was much faster than RFC whcih was the exactly opposite of what I was expecting for this dataset.
the fastest being 0.8 seconds ('Monday-WorkingHours.pcap_ISCX.csv') XGBOOST compared to RFC with 1.5 seconds.

2. XGBOOST was for the most part on part with RFC in these datasets, however I actually saw significant reductions in proability when 
it came to the hardest data set. 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' main issues being 
'Web Attack � Sql Injection' from my observation based on the recall scores being the lowest, its a sign that the actual attacks are being constantly missed, its directly from both not enough data to fight against it and that the data doesnt
drastically change enough for the data to truly respond against it.

3. Infiltration however, actually improved slightly better compared the RFC while using XGBOOST. 

4. Surprisingly enough, heartbleed on 'Wednesday-workingHours.pcap_ISCX.csv' only has 11 cases in that entire dataset however both 
RFC and XGBOOST was able to detect it in each model so well.
Conclusion on heartbleed: 
Even though its only 11 cases, from futher investigation on 'Wednesday-workingHours.pcap_ISCX.csv' heartbleed
only seems to attack port 444 with zero variation to other ports. this is becuase heart bleed is a bug in SSL/TLS encryption. It sends a small "heartbeat" request to a server but lies about how big it is, tricking the server to send back more data than it should. This leaks the server memory which may contain passwords, keys and sensitive data. This is why websites show look into becoming SSL (Secure Socket Layer) which not only protects the website but its users as well. 

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

Goal: Investigate, SQL-Injection/Infiltration issues.

# Observation: 
Seeing biggest issue on Thusday's files, file: 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' and Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv ' both SQL-Injection, and 'Infiltration' my reasoning is becuase there isnt enough
data on these attacks for the model to truly understand them yet/the parameters on the dataset for both SQL injection and , Infilteration are so minut that its hard to predict when the model displays such little different compared to BENIGN more data could help this result.

concat data with all 8 files may help finding more evidence on these two parameters become detectable but im not too hopeful.

dropna was one of my biggest concerns for deleteing too much data that might actually support things like 'Infilteration' and 'SQL-Injection' being detectable however coming from diving into what we were dropping. 'Rows before: 529918 Rows after: 529481' 

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
See if 5 extra folds helps model predict better results. 

#  Observation:
Overall I was anticipating to either see the model really reflect drastically different results between the 5 folded models especially keeping it at the 80/20 level but shuffling it through 5 different ways to experience new in different data or at least see a gradual improvement as it went on through each fold. Instead it was rather consistent espeically with most of the data being pretting high and consistent throughout most data sets I was more so really paying attention to the difficult csv's such as 'Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv' which is definetly been the hardest for the model.


----------------------------------------------------------------------------------------------------------------------------------
Author: Antonio Gonzalez
Environment: Python 3.13 | VS Code | Kagglehub

#  INDEX.MD CREATED 
Date: April 30, 2026

 Goal: Write through an index to navigate code to user's more easily.


----------------------------------------------------------------------------------------------------------------------------------
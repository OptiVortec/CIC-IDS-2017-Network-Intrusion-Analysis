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
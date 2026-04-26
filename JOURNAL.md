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
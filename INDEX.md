#  Index


## Attacks Observed


BENIGN - Most of the data in any of the datasets
Is completely normal traffic deemed to not be an invasive attack.


----


DDoS - Distributed Denial of Service - DDoS floods the network or server with an overwhelming amount of traffic rendering it unable to respond to legitimate requests. Tries to force the server or network to read so much incoming traffic at once it clogs it entirely for real traffic to get through.


Models Responses: Easily detectable through abnormal flow duration and packet counts. Detects immediately.


----


SQL-Injection - A web attack where malicious SQL code is inserted into input fields to manipulate a database. One of the hardest attacks to detect in this dataset due to very few samples (130) and subtle differences from normal traffic.


Solutions: Either more data needs to be collected against this attack or more parameters that show the intensity of this malicious attack needs
to be exposed to the model.


----


Infiltration - An attacker that has gained access to the network and is quietly moving through it. Designed to blend in with normal BENIGN traffic making it extremely difficult for models to detect. Low sample count contributes to poor detection rates.


Solutions: Same as 'SQL-Injection' either more data needs to be collected against this attack or more parameters that show the intensity of this malicious attack needs to be exposed to the model.


----


Heartbleed - User to website/network: when idling computer to network sends a heartbeat to network saying it still exists on the network. This helps with things like staying logged in and not becoming logged out for too much idle time. Heartbleed is when the attacker mimics the heartbleed intercepting the network. When the attack reaches the network it sends information back out which can be things like (keys) to keep in the account or full passwords which can then be taken advantage of.


Model's Response: It sees that port 443 is typically the only port it attacks and rather than the data flowing through multiple ports at once/ heartbleed sends a bunch of abnormal data to just this one port practically catching it every time.


Attack Port: 443


Solutions: SSL encryption (Secure Socket Layer) if not possible or too many users an idle time duration that kicks the user from the network can help reduce user count to help SSL as well as protect the user's data.
----
FTP-Patator - A brute force attack targeting FTP (File Transfer Protocol) servers. The attacker repeatedly tries username and password combinations to gain unauthorized access to file transfer services.


Solutions: Two Party Authentication has gotten extremely popular over the recent years for this type of reason. This is also why we have timeout sessions for multiple attempts at login failures.


----


SSH-Patator - Same Brute force methods as FTP-Patator but targeting SSH (Secure Shell) connections. SSH is used for remote server access making this a high value target for attackers. SSH is very common among IT/CyberSecurity departments to use constantly on a day to day basis.


----


DoS Hulk - A denial of service attack that generates requests to overwhelm a web server and bypass caching mechanisms.


----


DoS GoldenEye - A targeted denial of service attack that keeps HTTP connections open indefinitely exhausting the server's own connection pool.


----


DoS Slowloris - Sends partial HTTP requests very slowly keeping connections open as long as possible, tying up the server without sending much of any traffic.


----


DoS Slowhttptest - Similar to Slowloris but it targets the HTTP POST requests, slowly sending data to keep connections open and exhaust servers resources.




----


Web Attack - Brute Force - Much more aggressive then the rest. It repeatedly tries different usernames and password combinations until landing on the right combination to break into an account. This is the same idea as trying to use every number possible on a physical combination lock until you get the right combination.


Models Response: Brute Force is extremely slow, easily detectable, easily preventable.


Solution: Simply why we have timeout sessions against logins after too many attempts have been made.


----


Web Attack - XSS - Cross Site Scripting. This injects malicious scripts into the web pages that become executed by the other users browsers, trying to potentially steal session cookies or redirecting users to something malicious.


----


PortScan - This is like someone either going door to door seeing which door is open like to a house or to a car. It maps out which ports on a network are open and listening. Its main purpose is a reconnaissance step before the larger attack begins, it helps the bigger attack find the vulnerability.


-----


Bot - Automated malicious traffic from a compromised machine of a botnet, this is used to carry out attacks, send spam, or exfiltrate data.


----------------------------------------------------------------------------------------------------------------------------------


Models:


Random Forest Classification (RFC) - An ensemble model that builds multiple decision trees and combines their results for a final prediction. Highly accurate and robust for this dataset, however noticeably slower than XGBOOST even when utilizing StratifiedKFold on XGBOOST.


XGBOOST - A gradient boosting model that builds trees sequentially, each tree correcting the errors of the last. Significantly faster than RFC on this dataset. Both XGBOOST and Random Forest were equally comparable for the most part in results. However struggled more on things Random Forest struggled on.


PyTorch - A deep learning framework using multi-dimensional arrays (tensors) and dynamic computation graphs. Trains neural networks layer by layer, updating weights through backpropagation. Uses Apple Silicon MPS (or NVIDIA CUDA) for GPU acceleration. Feature importance is explained using SHAP (SHapley Additive exPlanations), a game-theory based method that measures each feature's marginal contribution to predictions. Generally more honest on difficult minority classes, though slower to converge than tree-based models on tabular data.


----------------------------------------------------------------------------------------------------------------------------------
Files - 
Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv
Monday-WorkingHours.pcap_ISCX.csv
Friday-WorkingHours-Morning.pcap_ISCX.csv
Friday-WorkingHours-Afternoon-PortScan.pcap_ISCX.csv
Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv
Tuesday-WorkingHours.pcap_ISCX.csv
Wednesday-workingHours.pcap_ISCX.csv
Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv


-----------------------------------------------------------------------------------------------------------------------------
# EACH CATAGORY OF DATA IN DATASET.
## SUMMARY
Basic Flow: 	Identifying the target (Port) and volume.
IAT:	        Distinguishing between automated bots and humans.
TCP Flags:	    Detecting "Handshake" abuse (SYN Floods/Port Scans).
Packet Stats:	Finding hidden scripts (SQLi) in large packet payloads.
Active/Idle:	Identifying persistent threats that "hide" by going quiet.
-----------------------------------------------------------------------------------------------------------------------------
# Basic Flow: 

Destination Port - Which port traffic is trying to reach.

Flow Duration - Total connection of all the packets beginning to end. 

Total Fwd Packets - Total count of packets sent from source to destination to source forward.

Total Backward Packets - Total count of packets sent from source to destination to source backward.

Total Length of Fwd Packets - Total size (bytes) and payload sent in forward direction

Total Length of Bwd Packets - Total size (bytes) and payload sent in back direction

-----------------------------------------------------------------------------------------------------------------------------
# Packet Length Statistics:

Fwd Packet Length Max -  Max measure size of forward individual packets. 

Fwd Packet Length Min - Min measure size of forward individual packets.

Fwd Packet Length Mean - The average forward packet size.

Fwd Packet Length Std - Standard deviation of forward packet size.

Bwd Packet Length Max -  Max measure size of backward  individual packets. 

Bwd Packet Length Min - Min measure size of backward individual packets.

Bwd Packet Length Mean - The average backward packet size.

Bwd Packet Length Std - Standard deviation of backward packet size.

Flow Bytes/s - Overall Speed of the connection

Flow Packets/s - Overall Speed of the connection

-----------------------------------------------------------------------------------------------------------------------------
# Inter-Arrival Time (IAT)
## Critical for DDoS and Brute Force.

 (bots have very consistent perfectly timed IAT while humans are much more random)

Flow IAT Mean -  Average Time elapsed between two consecutive packets sent in the flow.

Flow IAT Std - Standard deviation elapsed between two consecutive packets sent in the flow.

Flow IAT Max - Max elapsed between two consecutive packets sent in the flow.

Flow IAT Min - Min elapsed between two consecutive packets sent in the flow.        

Fwd IAT Total - A total measure of timing rhythm of forward packets going in. 

Fwd IAT Mean - A mean average measure of timing rhythm of forward packets going in. 

Fwd IAT Std - Standard deviation measure of timing rhythm of forward packets going in. 

Fwd IAT Max - The max measure of timing rhythm of forward packets going in.              

Fwd IAT Min - The min measure of timing rhythm of forward packets going in. 

Bwd IAT Total - A total measure of timing rhythm of backward packets going in.

Bwd IAT Mean - A mean average measure of timing rhythm of backward packets going in. 

Bwd IAT Std - Standard deviation measure of timing rhythm of backward packets going in. 

Bwd IAT Max - The max measure of timing rhythm of backward packets going in. 

Bwd IAT Min - The min measure of timing rhythm of backward packets going in. 

-----------------------------------------------------------------------------------------------------------------------------
# TCP Flags  (Instruction Manual)

TCP flags are single-bit filters telling the receiving computer exactly how to handle the incoming packet.

# Unsure at this moment

Fwd PSH Flags -  Packets forward with push flag, tells receiver to process data immediately rather than buffering.

Bwd PSH Flags - Packets backward with push flag, tells receiver to process data immediately rather than buffering.

Fwd URG Flags - Packets forward with urgent flag, signals the specific incoming data within the data should be prioritized by the receiving app.

Bwd URG Flags - Packets backward with urgent flag, signals the specific incoming data within the data should be prioritized by the receiving app.

Fwd Header Length - Total forward size of bytes from TCP/IP headers. (If unusually large could be potentially a 'Protocol Overhead' or hidden data in header)

Bwd Header Length - Total backward size of bytes from TCP/IP headers.

Fwd Packets/s - Number of forward packets being sent per second

Bwd Packets/s -  Number of backward packets being sent per second

Min Packet Length - The smallest packets seen in the entire traffic flow                    (MIN)

Max Packet Length - The largest packets seen in the entire traffic flow                     (MAX)

Packet Length Mean - The average packets seen in the entire traffic flow                    (MEAN)

Packet Length Std - The standard deviation of packets seen in the entire traffic flow       (STD)

-----------------------------------------------------------------------------------------------------------------------------
# Advanced Flags and Ratios

FIN Flag Count - Measures how many times these "handshakes" signals are sent. This is the finished signal to close connection (If FIN is high without previous flow, potentially 'Port Scan)

SYN Flag Count - A massive spike in SYN without matching ACK is a classic sign of a SYN Flood attack. 

ACK Flag Count - 'Acknowledgement' Used to confirm packet was received.

RST Flag Count - 'RESET' Forced kill connection. (Either Error or closed port.)
 Signals used to push data immediately, mark it as urgent or reset a connection that has an error.

PSH Flag Count - Specific congestion of priority flags (PUSH FLAG). Used to manage network traffic jams

URG Flag Count - Specific congestion of priority flags (URGENT FLAG). Used to manage network traffic jams

CWE Flag Count -  'Congestion Window Reduce' 
(High CWE during DDoS attack shows network infrastructure is struggling to keep up with volume.)

ECE Flag Count - 'Explicit Congestion Notification' 
(High ECE during DDoS attack shows network infrastructure is struggling to keep up with volume.) 

Down/Up Ratio - Mathematical Ratio of download to upload ratio. 

-----------------------------------------------------------------------------------------------------------------------------
# Bulk Transfer Metrics

Average Packet Size - The average size of all packets.

Avg Bwd Segment Size - The average size of segments observed backward direction

Fwd Avg Bytes/Bulk - Average forward bytes per bulk period.

Fwd Avg Packets/Bulk - Average forward packets sent per bulk.

Fwd Avg Bulk Rate - Average forward transfer rate (speed) during bulk burst.

Bwd Avg Bytes/Bulk -  Average backward bytes per bulk period.

Bwd Avg Packets/Bulk - Average backward packets sent per bulk.

Bwd Avg Bulk Rate - Average backward transfer rate (speed) during bulk burst.

-----------------------------------------------------------------------------------------------------------------------------
# RECEIVE AND TRANSACTIONS

Subflow Fwd Packets - Tracks smaller forward subflow data that was once single larger transactions. (PACKETS)

Subflow Fwd Bytes - Tracks smaller forward subflow data that was once single larger transactions. (BYTES)

Subflow Bwd Packets - Tracks smaller backward subflow data that was once single larger transactions. (PACKETS)

Subflow Bwd Bytes - Tracks smaller backward subflow data that was once single larger transactions. (BYTES)


Init_Win_bytes_forward - The number of bytes forward the sender is willing to receive before an actual acknowledgement. 
(Often targeted in Buffer Overflow and window scaling attacks)

Init_Win_bytes_backward - The number of bytes backward the sender is willing to receive before an actual acknowledgement. 

-----------------------------------------------------------------------------------------------------------------------------
# Unsorted Technical Essentials

act_data_pkt_fwd - The forward direction of counts of packets that actually contain payload data.

min_seg_size_forward - The smallest segment size being observed in the forward direction 
(Crucial potentially attacks from small segments to bypass firewalls or IDS systems.)

-----------------------------------------------------------------------------------------------------------------------------
# Active Idle Times

-Activity-
Active Mean - Average flow traffic  of activity before going idle. (MEAN)

Active Std - The standard deviation of flow traffic of activity before going idle. (STD)

Active Max - The max of flow traffic of activity before going idle. (MAX)

Active Min - The min of flow traffic of activity before going idle. (MIN)

-IDLE-

Idle Mean - The average flow of idle before becoming active again. (MEAN)

Idle Std - The standard deviation flow of idle before becoming active again. (STD)

Idle Max - The max flow of idle before becoming active again. (MAX)

Idle Min - The min flow of idle before becoming active again. (MIN)

Label - The ground truth



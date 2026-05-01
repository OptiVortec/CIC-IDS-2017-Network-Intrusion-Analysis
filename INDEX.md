#  Index


## Attacks Observed


BENIGN - Most of the data in any of the datasets
Is completely normal traffic deemed to not be an invasive attack.


----


DDos - Distributed Denial of Service - DDoS floods the network or server with an overwhelming amount of traffic rendering it unable to respond to legitimate requests. Tries to force the server or network to read so much incoming traffic at once it clogs it entirely for real traffic to get through.


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


Model's Response: It sees that port 444 is typically the only port it attacks and rather than the data flowing through multiple ports at once/ heartbleed sends a bunch of abnormal data to just this one port practically catching it every time.


Attack Port: 444/443


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


Dos Slowlories - Sends partial HTTP requests very slowly keeping connections open as long as possible, tying up the server without sending much of any traffic.


----


DoS Slowhttptest - Similar to Slowloris but it targets the HTTP POST requests, slowly sending data to keep connections open and exhaust servers resources.




----


Web Attack - Brute Force - Much more aggressive then the rest. It repeatedly tires to different usernames and password combinations until landing on the right combination to break into an account. This is the same idea as trying to use every number possible on a physical combination lock until you get the right combination.


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


Random Forest Classification (RFC) - An ensemble model that builds multiple decision trees and combines thier results for a final prediciton. Highly accurate and robust for this dataset, however noticeably slower than XGBOOST even when utilizing StratifiedKFold on XGBOOST.


XGBOOST - A gradient boosting model that builds trees sequentially, each tree correcting the errors of the last. Significantly faster than RFC on this dataset. Both XGBOOST and Random Forest were equally comparable for the most part in results. However struggled more on things Random Forest struggled on.


Pytorch -




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



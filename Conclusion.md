# Project Conclusion: CIC-IDS-2017 Network Intrusion Detection System

**Author:** Antonio Gonzalez
**Environment:** Python 3.13 | VS Code | Kagglehub
**Models:** Random Forest Classifier | XGBoost | PyTorch (Neural Network)
**Dataset:** CIC-IDS-2017 — 2.83 million rows | 79 features | 15 attack types

---

## Overview

This project implemented and compared three machine learning models — Random Forest Classifier (RFC), XGBoost, and a PyTorch neural network — to detect network intrusion attacks using the Canadian Institute for Cybersecurity's CIC-IDS-2017 dataset. The dataset spans a simulated workweek (Monday through Friday) and covers 15 distinct attack types ranging from DDoS and Brute Force to SQL Injection and Infiltration.

The primary objectives were:

1. Classify network traffic as BENIGN or a specific attack type
2. Compare model accuracy, speed, and behavior across all three approaches
3. Identify which network traffic features were most critical for detection
4. Investigate which destination ports were most targeted by each attack
5. Determine the limitations of the models when faced with rare, low-sample attacks

---

## Model Performance Summary

### Random Forest Classifier (RFC)
RFC consistently achieved 99–100% accuracy across most attack types. Its strength lies in its ensemble nature — combining 100 decision trees to produce a robust, stable prediction. Monday's all-BENIGN dataset served as a negative control, confirming the model does not hallucinate attacks when none are present. RFC was the slowest of the three models but the most interpretable through standard feature importance (Mean Decrease in Impurity).

### XGBoost
XGBoost matched RFC in accuracy while being significantly faster — as low as 0.8 seconds on Monday compared to RFC's 1.5 seconds. StratifiedKFold cross-validation (5 folds) was applied to ensure class distributions were maintained across splits, particularly important given the severe class imbalance present in Thursday's Web Attack datasets. XGBoost's gain-based feature importance tended to concentrate heavily on a single dominant feature per dataset, whereas RFC spread importance more evenly across correlated features.

### PyTorch (Neural Network)
PyTorch used a three-layer neural network (input → 128 → 64 → output classes) trained with CrossEntropyLoss and the Adam optimizer across 10 epochs. Apple Silicon MPS GPU acceleration was applied to maximize performance on the MacBook. SHAP (SHapley Additive exPlanations) via DeepExplainer was used to produce model-agnostic feature importance visualizations.

PyTorch was the most honest model on difficult minority classes. While RFC and XGBoost often scored 100% on well-represented attacks, PyTorch consistently reported 70–90% accuracy, which in most cases was a more accurate reflection of the model's true confidence. For SQL Injection and Infiltration — the two hardest attacks — PyTorch scored 0.0 on SQL Injection (consistent with the other models) and showed marginal improvement on Infiltration.

---

## Key Findings

### 1. Attack Detectability Is Driven by Sample Size and Feature Distinctiveness

The clearest finding across all three models was that detection quality correlates directly with how many samples an attack type has and how distinctively its network features differ from BENIGN traffic.

| Attack | Detection | Reason |
|---|---|---|
| DDoS, PortScan, DoS Hulk | ~100% all models | High volume, extremely distinctive traffic patterns |
| FTP-Patator, SSH-Patator | ~100% all models | Exclusively target ports 21 and 22 with repetitive login attempts |
| Heartbleed | ~100% all models | Exclusively uses port 444, no variation |
| Brute Force (Web) | ~76–80% | Moderate samples (1,507), slow and repetitive but detectable |
| Infiltration | ~74–89% | Only 36 samples, designed to blend with BENIGN |
| SQL Injection | ~35–43% | Only 21 samples, near-identical traffic signatures to BENIGN |

### 2. SQL Injection Is a Data Problem, Not a Model Problem

All three models struggled with SQL Injection across every CSV and the CONCAT dataset. Investigation confirmed this is not caused by data leakage, incorrect preprocessing, or model weakness. The root cause is a class imbalance ratio of approximately 8,000:1 (BENIGN vs. SQL Injection) combined with network-level traffic that is nearly indistinguishable from normal activity. More labeled SQL Injection samples or additional network parameters capturing payload-level data would be required to improve detection.

### 3. Concatenating All CSVs Helped Infiltration, Not SQL Injection

Running all 8 CSV files through a single CONCAT model (2.83 million rows) slightly improved Infiltration detection by exposing the model to more positive samples. SQL Injection saw no improvement, confirming the issue is intrinsic to the rarity and subtlety of the attack in this dataset, not a function of training set size.

### 4. Feature Importance Differs Between Models by Design

RFC, XGBoost, and PyTorch/SHAP each define "importance" differently, which is why they identify different top features for the same CSV:

- **RFC** uses Mean Decrease in Impurity — importance is averaged and spread across correlated features
- **XGBoost** uses gain — importance concentrates heavily on the single most discriminative feature
- **SHAP** uses Shapley values — measures each feature's marginal contribution across all possible subsets

All three approaches are answering a legitimately different question about the same data. This is not a flaw — it reflects the nature of each algorithm and is most valuable when used together for cross-validation of findings.

### 5. Column Drop Experiment: Features Should Not Be Dropped

A controlled experiment was run dropping 7 potentially redundant columns across all models and days. Results showed no consistent improvement and slight regression in the CONCAT dataset and the most statistically reliable test, and the conclusion was that these columns carry real predictive signal and should be retained.

The sole exception is `Fwd Header Length.1`, a true duplicate column created by pandas when the same column name appears twice in the source CSV. This column is always removed as it provides no additional information.

Note: A case sensitivity bug in the drop list caused only 4 of the 7 intended columns to actually drop. The failed drops were identified, the experiment was archived under `Drop_Column_FAILED/`, and the main notebooks were corrected.

### 6. Destination Port Analysis

A detailed destination port investigation was conducted across all attack types in the CONCAT dataset, revealing clear port targeting patterns:

| Attack | Primary Port | Notes |
|---|---|---|
| BENIGN | 53 (DNS) | Normal internet browsing traffic |
| FTP-Patator | 21 (Legacy FTP) | Port should be closed — outdated protocol |
| SSH-Patator | 22 (SSH) | Requires 2FA and Fail2ban at minimum |
| Heartbleed | 444 | Precise surgical strike, not a flood |
| DDoS | 80 (HTTP) | Avoids encryption to maximize flood speed |
| DoS Slowloris / Slowhttptest / Hulk / GoldenEye | 80 (HTTP) | All DoS variants target the same HTTP entry point |
| Web Attacks (Brute Force, XSS, SQL Injection) | 80 (HTTP) | All web-based attacks through the standard HTTP port |
| PortScan | 80 (most hit) | Reconnaissance only — all ports probed, cannot be stopped |
| Bot | 8080 (HTTP alt) | Botnet C2 communication, foundation for larger attacks |
| Infiltration | 444 | C2 communication, lateral movement inside the network |

---

## Limitations

**Sample Bias:** The dataset covers Monday through Friday only. Weekend traffic patterns and potential weekend-specific attacks are not represented. Attacks do not follow business hours.

**No Timestamps:** The dataset contains flow duration metrics but no actual timestamps, preventing temporal pattern analysis that could identify when attacks are most likely to occur.

**Class Imbalance:** BENIGN traffic constitutes the vast majority of all datasets. Models trained without balancing strategies will inherently be biased toward BENIGN predictions, reducing recall on minority attack classes. This is most visible on SQL Injection and Infiltration.

**Lab-Generated Data:** CIC-IDS-2017 was generated in a controlled lab environment. Real-world network traffic is noisier, more varied, and may not reflect the clean separation between attack and BENIGN traffic observed here.

---

## Technical Skills Demonstrated

- **Data Pipeline:** Kaggle API integration, multi-file concatenation, whitespace normalization, infinity and NaN handling
- **Preprocessing:** Label encoding, StandardScaler (properly fit on training data only to prevent leakage), StratifiedKFold cross-validation
- **Machine Learning:** Random Forest, XGBoost with gradient boosting, deep neural networks with PyTorch
- **Explainability:** SHAP DeepExplainer for neural network feature attribution
- **GPU Optimization:** Apple Silicon MPS device detection and utilization for PyTorch training
- **Experiment Tracking:** Version-controlled experiment history (Drop_Column_FAILED archive), structured JOURNAL documenting observations, hypotheses, and conclusions
- **Security Domain Knowledge:** Attack mechanics, port analysis, and layered defense strategies for each attack type identified in the dataset

---

## Final Thoughts

The most important lesson from this project is that machine learning model performance is only as good as the data it trains on. RFC and XGBoost are capable of near-perfect detection on attacks with sufficient samples and distinctive signatures. However, for attacks like SQL Injection and Infiltration — which are specifically designed to be subtle and blend into normal traffic — no amount of model tuning compensates for a lack of labeled data.

A real-world Intrusion Detection System would require continuous retraining on fresh labeled data, anomaly detection methods that do not rely solely on known attack signatures, and integration with endpoint and behavioral monitoring that network flow data alone cannot provide.

This project served as a strong foundation for understanding both the power and the boundaries of supervised machine learning in a cybersecurity context.

---

*See JOURNAL.md for the full research log, INDEX.md for dataset and model documentation, and the individual day folders for all model notebooks.*

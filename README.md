# Network Intrusion Detection System
### ML Analysis of the CIC-IDS-2017 Dataset

**Author:** Antonio Gonzalez
**GitHub:** [github.com/OptiVortec](https://github.com/OptiVortec)

---

## Overview

This project implements and compares three machine learning models — **Random Forest Classifier (RFC)**, **XGBoost**, and a **PyTorch neural network** — to detect and classify network intrusion attacks using the Canadian Institute for Cybersecurity's CIC-IDS-2017 dataset.

The dataset simulates a full workweek (Monday–Friday) of enterprise network traffic, containing over **2.83 million flow records** across **8 CSV files**, covering **15 distinct attack types** alongside normal (BENIGN) traffic. Each model was applied to every individual CSV file and to a full concatenated dataset, producing a complete multi-model, multi-day comparison.

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Python 3.13 | Core language |
| Pandas / NumPy | Data loading, cleaning, preprocessing |
| Scikit-learn | RFC, StandardScaler, StratifiedKFold, LabelEncoder, classification_report |
| XGBoost | Gradient boosting classifier |
| PyTorch | Neural network training (MPS/GPU accelerated) |
| SHAP | Neural network explainability (DeepExplainer) |
| Matplotlib | Feature importance visualization |
| Kagglehub | Dataset download via Kaggle API |
| Git / GitHub | Version control and portfolio hosting |

---

## Dataset

**Source:** [CIC-IDS-2017 — Kaggle](https://www.kaggle.com/datasets/chethuhn/network-intrusion-dataset)
**Original:** Canadian Institute for Cybersecurity, University of New Brunswick

| CSV File | Day | Attack Types | Rows |
|---|---|---|---|
| Monday-WorkingHours.pcap_ISCX.csv | Monday | BENIGN only (negative control) | 529,918 |
| Tuesday-WorkingHours.pcap_ISCX.csv | Tuesday | FTP-Patator, SSH-Patator | 445,909 |
| Wednesday-workingHours.pcap_ISCX.csv | Wednesday | DoS Hulk, DoS GoldenEye, DoS Slowloris, DoS Slowhttptest, Heartbleed | 692,703 |
| Thursday-WorkingHours-Morning-WebAttacks.pcap_ISCX.csv | Thursday AM | Web Attack – Brute Force, Web Attack – XSS, Web Attack – SQL Injection | 170,366 |
| Thursday-WorkingHours-Afternoon-Infilteration.pcap_ISCX.csv | Thursday PM | Infiltration | 288,602 |
| Friday-WorkingHours-Morning.pcap_ISCX.csv | Friday AM | Bot | 191,033 |
| Friday-WorkingHours-Afternoon-PortScan.pcap_ISCX.csv | Friday PM | PortScan | 286,467 |
| Friday-WorkingHours-Afternoon-DDos.pcap_ISCX.csv | Friday PM | DDoS | 225,745 |

**Total (CONCAT):** ~2.83 million rows | 79 features | 15 attack labels

---

## Models

### Random Forest Classifier (RFC)
An ensemble of 100 decision trees. Feature importance is measured using Mean Decrease in Impurity (Gini), which distributes importance across correlated features. Slowest of the three models but highly interpretable.

### XGBoost
A sequential gradient boosting model where each tree corrects the errors of the previous. Uses StratifiedKFold (5 folds) for cross-validation. Feature importance measured by gain — concentrates heavily on the single most discriminative feature. Significantly faster than RFC.

### PyTorch Neural Network
A fully connected 3-layer network (input → 128 → 64 → output classes) trained with CrossEntropyLoss and the Adam optimizer over 10 epochs. **Apple Silicon MPS GPU acceleration** applied via `.to(device)`. Feature importance explained using **SHAP DeepExplainer** (Shapley values). Most honest on difficult minority classes.

---

## Results Summary

| Attack | RFC | XGBoost | PyTorch |
|---|---|---|---|
| BENIGN (Monday baseline) | 100% | 100% | 100% |
| FTP-Patator | ~100% | ~100% | 98–99% |
| SSH-Patator | ~100% | ~100% | 96–98% |
| DoS Hulk / GoldenEye / Slowloris / Slowhttptest | ~100% | ~100% | ~100% |
| Heartbleed | ~100% | ~100% | ~100% |
| DDoS | ~100% | ~100% | ~100% |
| PortScan | ~100% | ~100% | ~100% |
| Bot | ~99% | ~100% | 76–89% |
| Web Attack – Brute Force | ~77% | ~79% | ~71% |
| Web Attack – XSS | ~33% | ~67–89% | ~0% |
| Web Attack – SQL Injection | ~39–41% | ~37–43% | ~0% |
| Infiltration | ~74–78% | ~60–86% | ~67–71% |

> **Note:** SQL Injection (21 samples) and Infiltration (36 samples) underperform due to extreme class imbalance — not model weakness. This is confirmed by the CONCAT experiment where adding 2.83M rows of data improved Infiltration slightly but not SQL Injection.

---

## Key Findings

1. **Attack detection quality is driven by sample size and feature distinctiveness.** Models reliably detect high-volume, clearly-patterned attacks. Rare, subtle attacks (SQL Injection, Infiltration) require more labeled data, not better models.

2. **SQL Injection is a data problem, not a model problem.** All three models scored 0.0 recall on SQL Injection in CONCAT. The ~8,000:1 class imbalance combined with near-identical network signatures to BENIGN traffic makes this attack class undetectable from flow-level features alone.

3. **XGBoost is significantly faster than RFC** with equal or better accuracy on most attack types.

4. **PyTorch is the most honest model on minority classes.** RFC and XGBoost often show inflated confidence; PyTorch typically reports 70–90% on hard cases rather than a misleading 100%.

5. **Feature importance differs between models by design:**
   - RFC (MDI) spreads importance across correlated features
   - XGBoost (gain) concentrates on the single strongest discriminator
   - SHAP measures marginal contribution — a fundamentally different question

6. **Destination port analysis** revealed consistent attack-specific port targeting: FTP-Patator → port 21, SSH-Patator → port 22, all web attacks → port 80, Heartbleed → port 444, Infiltration C2 → port 444, DDoS → port 80 (avoids encryption for maximum flood speed).

---

## Project Structure

```
CIC_IDS_2017_FOLD/
│
├── README.md               ← You are here
├── INDEX.md                ← Attack dictionary, feature glossary, model descriptions
├── JOURNAL.md              ← Full dated research log (April–May 2026)
├── Conclusion.md           ← Portfolio conclusion with findings and limitations
├── CIC_IDS_2017.ipynb      ← Data loading and preprocessing entry point
│
├── Monday_Folder/
│   ├── Monday_RFC/         Mon_WH_RFC.ipynb
│   ├── Monday_XGBOOST/     Mon_WH_XBOOST.ipynb
│   └── Monday_TORCH/       Mon_WH_TORCH.ipynb
│
├── Tuesday_Folder/
│   ├── Tuesday_RFC/        Tuesday_WorkingHours.ipynb
│   ├── Tuesday_XGBOOST/    Tue_WH_XGBOOST.ipynb
│   └── Tuesday_TORCH/      Tue_WH_TORCH.ipynb
│
├── Wednesday_Folder/
│   ├── Wednesday_RFC/      Wednesday_workingHours.ipynb
│   ├── Wednesday_XGBOOST/  Wed_WH_XGBOOST.ipynb
│   └── Wednesday_TORCH/    Wed_WH_TORCH.ipynb
│
├── Thursday_Folder/
│   ├── Thursday_RFC/       Thur_WH_M_RFC.ipynb  |  Thur_WH_A_RFC.ipynb
│   ├── Thursday_XGBOOST/   Thur_WH_M_XGBOOST.ipynb  |  Thur_WH_A_XGBOOST.ipynb
│   └── Thursday_TORCH/     Thur_WH_M_TORCH.ipynb  |  Thur_WH_A_TORCH.ipynb
│
├── Friday_Folder/
│   ├── Friday_RFC/         Fri_WH_M_RFC.ipynb  |  Fri_WH_A_D_RFC.ipynb  |  Fri_WH_A_PS_RFC.ipynb
│   ├── Friday_XGBOOST/     Fri_WH_M_XGBOOST.ipynb  |  Fri_WH_A_D_XGBOOST.ipynb  |  Fri_WH_A_PS_XGBOOST.ipynb
│   └── Friday_TORCH/       Fri_WH_M_TORCH.ipynb  |  Fri_WH_A_D_TORCH.ipynb  |  Fri_WH_A_PS_TORCH.ipynb
│
├── CONCAT/
│   ├── concat_RFC.ipynb        ← All 8 CSVs combined, RFC
│   ├── concat_XGBOOST.ipynb    ← All 8 CSVs combined, XGBoost
│   └── concat_TORCH.ipynb      ← All 8 CSVs combined, PyTorch
│
└── Drop_Column_FAILED/     ← Archived experiment: column drop showed no improvement
```

### File Naming Convention

```
DAY _ TIME OF DAY _ ATTACK TYPE _ MODEL.ipynb

Fri_WH_A_D_RFC.ipynb
 │  │ │  │   └─────  Model: RFC
 │  │ │  └────────── Attack: D = DDoS
 │  │ └───────────── Time: A = Afternoon
 │  └─────────────── Period: WH = Working Hours
 └────────────────── Day: Fri = Friday

Thur_WH_M = Thursday Morning   |   Thur_WH_A = Thursday Afternoon
Fri_WH_A_PS = Friday Afternoon PortScan   |   Fri_WH_A_D = Friday Afternoon DDoS
```

---

## Experiment Archive

`Drop_Column_FAILED/` contains copies of all notebooks from a controlled experiment testing the removal of 7 potentially redundant columns. Results showed no consistent improvement and slight regression in the CONCAT model — the most statistically reliable test. Columns were retained in the main notebooks. See **JOURNAL.md** (May 13th entry) and **Conclusion.md** for full analysis.

---

## Documentation

| File | Contents |
|---|---|
| [JOURNAL.md](JOURNAL.md) | Dated research log covering environment setup through final port analysis. Includes observations, hypotheses, dead ends, and conclusions for every phase of the project. |
| [INDEX.md](INDEX.md) | Complete reference: all 15 attack type descriptions with detection notes and solutions; all 79 dataset features explained by category; model comparison. |
| [Conclusion.md](Conclusion.md) | Full project conclusion covering model performance, key findings, limitations, and technical skills demonstrated. |

---

## How to Run

1. Clone the repository
2. Set up a virtual environment and install dependencies:
```bash
pip install pandas numpy scikit-learn xgboost torch kagglehub shap matplotlib
```
3. Add your Kaggle API credentials to a `.env` file:
```
KAGGLE_USERNAME=your_username
KAGGLE_KEY=your_key
```
4. Open `CIC_IDS_2017.ipynb` first to load and verify the dataset
5. Run any day/model notebook — Monday is the best starting point as it contains the most detailed code comments

---

## Limitations

- Dataset covers Monday–Friday only — weekend traffic and weekend-specific attacks are not represented (sample bias)
- No timestamps in the dataset — temporal pattern analysis is not possible
- Lab-generated data — real-world traffic is noisier and attack signatures may differ
- Severe class imbalance on SQL Injection (21 samples) and Infiltration (36 samples) limits detection regardless of model

---

*CIC-IDS-2017 dataset provided by the Canadian Institute for Cybersecurity, University of New Brunswick.*

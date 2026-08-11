# Decoding Customer Value: A SQL-Driven Retention Strategy

> **Is the business building a loyal customer base — or subsidizing bargain hunters?**  
> An end-to-end customer intelligence project for a D2C fashion brand, built across Python, SQL, and Power BI.

---

## Project Overview

A direct-to-consumer fashion brand with 3,900 customers runs a promotional discount program but has no structured way to understand who their customers actually are. This project builds that intelligence layer from scratch — defining loyalty, segmenting customers, mapping geographic demand, and prescribing a data-backed retention strategy.

**Central question answered:**  
*Are current promotional loops building genuine loyalty, or are they over-subsidizing low-margin, high-churn bargain hunters?*

**Verdict:** 43% of customers are fully promo-dependent and show zero incremental loyalty gain over organic buyers. Only 14% of the customer base qualifies as genuinely Loyal. 24.3% of the brand's highest-value Gold-tier customers are actively dissatisfied — a silent attrition crisis hiding in plain sight.

---

## Repository Structure

```
d2c-customer-intelligence-retention-strategy/
│
├── Python_FeatureEngineering/
│   ├── featureeng.ipynb          # Data cleaning & feature engineering
│   ├── customers_enriched.csv    # Enriched dataset (3,900 rows x 26 columns)
│   └── Dataset.csv               # Raw input data
│
├── SQL_BusinessQueries/
│   ├── queries.sql               # 5 business segmentation queries
│   ├── sql_analysis_report.pdf   # Query results and interpretation
│   ├── Q1_segment_comparison.csv
│   ├── Q2_category_loyalty.csv
│   ├── Q3_top10_organic_states.csv
│   ├── Q3_bottom5_promoDriven_states.csv
│   ├── Q4_churn_risk_profile.csv
│   ├── Q4_high_churn_by_segment.csv
│   ├── Q5_ICP_overall_profile.csv
│   ├── Q5_ICP_top_locations.csv
│   ├── Q5_ICP_top_categories.csv
│   ├── Q5_ICP_top_payment_methods.csv
│   └── Q5_ICP_top_seasons.csv
│
├── PowerBi_Dashboard/
│   └── dashboard.pbix            # 4-panel interactive founder dashboard
│
├── data_dictionary.txt           # Feature definitions and formulas
├── Executive_Summary.pdf         # 1-page founder-facing summary
├── Retention_Playbook.pdf        # Full strategic recommendations
└── README.md
```

---

## Methodology

### Phase 1 — Data Preparation & Feature Engineering
**Tools:** Python, pandas, NumPy, Scikit-learn

The raw dataset contained 18 columns with no loyalty score, no churn label, and no customer segments. Every analytical concept had to be constructed from available variables.

8 behavioral features engineered from scratch:

| Feature | Type | Description |
|---|---|---|
| `customer_segment` | Categorical | Loyal / Regular / Discount Driven / New Customer |
| `value_tier` | Categorical | Bronze / Silver / Gold (composite LTV proxy) |
| `satisfaction_flag` | Categorical | Low / Mid / High (percentile-based thresholds) |
| `loyalty_score` | Float 0-1 | Behavioral loyalty — history + frequency + subscription |
| `loyalty_label` | Categorical | Low / Mid / High loyalty |
| `churn_risk` | Categorical | Low / Medium / High (3-signal behavioral proxy) |
| `high_value_at_risk` | Binary | Gold tier + Low satisfaction = silent attrition flag |
| `frequency_rank` | Integer | Numeric encoding of purchase frequency (1-7) |

**Key methodological decisions:**
- Two competing loyalty definitions (behavioral vs. commitment) tested against three validation metrics; Definition A selected on r=0.75 correlation with purchase history
- Churn risk proxy built from first principles — no churn label exists in the data
- All thresholds justified by data distribution (percentile-based), not arbitrary cutoffs
- Loyalty definition selection grounded in predictive logic per project brief requirements

---

### Phase 2 — Customer Segmentation & SQL Analysis
**Tools:** SQLite

5 business queries written to answer the brand's core strategic questions:

| Query | Business Question |
|---|---|
| Q1 | What separates genuinely loyal customers from discount-driven ones? |
| Q2 | Which product categories attract sticky vs. one-time buyers? |
| Q3 | Which states signal organic demand vs. discount-driven volume? |
| Q4 | Who are the highest churn risk customers and what do they look like? |
| Q5 | What does the brand's ideal customer profile look like? |

**Selected findings:**
- Kansas: 24% discount rate, organic index 219.9 — highest organic demand state
- Indiana: 57% discount rate, organic index 101.7 — most promo-dependent state
- 252 of 441 High churn risk customers (57%) are Discount Driven
- Ideal customer: age 44.7, $77.80 avg spend, 44.5 previous purchases, Nevada/Arizona/Pennsylvania

---

### Phase 3 — Founder Dashboard & Retention Playbook
**Tools:** Power BI Desktop

**4-panel interactive dashboard:**
- **Customer Pyramid** — value tier distribution across all segments
- **Promo vs. Retention** — loyalty score gap between Loyal and Discount Driven segments
- **Geographic Opportunity Map** — state-level organic demand index (green = organic, red = promo-dependent)
- **Category Funnel** — purchase history depth by category x value tier

**Retention Playbook outputs:**
- Promotional sunset plan (3-phase, 90-day rollout targeting 593 Discount Driven customers)
- Ideal customer profile for acquisition targeting
- 3 guardrail KPIs to monitor during promotional reduction

---

## Key Findings

```
43%     of customers are fully promo-dependent
14%     of customers are genuinely Loyal (buy without any discount)
24.3%   of Gold-tier customers are dissatisfied — zero are Low churn risk
57%     of High churn risk customers are Discount Driven
$82.73  average spend of Gold-tier customers
Kansas  lowest discount rate in dataset (24%) — top organic demand hub
Indiana highest discount rate (57%) — most promo-dependent state
```

---

## Strategic Recommendations

**Promotional Sunset Plan**  
Phase out discounts for customers exceeding 13 lifetime purchases (Q25 threshold) with promo dependency > 0.75. At this stage, buying habits are entrenched — continued discounts subsidize established users rather than converting new ones. Projected outcome: 15-20% volume contraction from price-sensitive churn, offset by immediate gross margin recovery.

**High-Value At-Risk Intervention**  
Deploy dedicated outreach to the 316 Gold-tier customers registering low satisfaction. These customers spend $82.73 on average but are silently at risk — none fall in the Low churn risk category. Standard automated promotions must be paused; high-touch VIP intervention required before total churn occurs.

**Geographic Budget Reallocation**  
Shift 40% of paid media spend away from low organic index states (Indiana, Oregon) into high organic demand hubs (Kansas, Arizona, Alaska) where customers buy at full retail value without discount incentives.

---

## Tech Stack

| Tool | Purpose |
|---|---|
| Python (pandas, NumPy) | Data cleaning, feature engineering |
| Scikit-learn (MinMaxScaler) | Feature normalization |
| SQLite | Customer segmentation queries |
| Power BI Desktop | Interactive founder dashboard |

---

## Limitations

- Dataset is cross-sectional — no timestamps, so purchase frequency is proxied via the `frequency_of_purchases` column rather than computed from transaction dates
- `discount_applied` and `promo_code_used` are perfectly correlated in this dataset (r=1.0), limiting independent analysis of each signal
- Review ratings show near-zero correlation with spend or loyalty metrics — satisfaction alone is a weak retention signal in this dataset
- All churn and loyalty metrics are behavioral proxies; no ground truth labels exist

---

## Author

**Priyal Singh**  
B.Tech, Metallurgical & Materials Engineering — IIT Roorkee  

# Nudie Juice – In-Store Execution Analytics Dashboard

A Metabase dashboard analysing in-store execution and perfect store compliance 
for Nudie Juice across IGA stores in Australia.

> **Disclaimer:** This dashboard and underlying data are synthetic and created 
> for portfolio purposes only. Brand names are used for realism only and this 
> project has no affiliation with Nudie Juice or any parent company.

---

## Objective

To track and analyse in-store execution quality for Nudie Juice across IGA retail 
stores in Australia — identifying compliance gaps, zone penetration rates, SKU 
availability and pricing consistency across store zones. Findings are designed to 
inform field sales prioritisation and perfect store strategy.

---

## Tools & Workflow

| Step | Tool | Purpose |
|---|---|---|
| 1 | Excel | Data validation and quality checks on raw shopper data |
| 2 | SQL | Data extraction, filtering and aggregation |
| 3 | Metabase | Dashboard design and client-ready reporting |

---

## Dashboard Overview

| Section | What it covers |
|---|---|
| Perfect Store Compliance | Compliant vs non-compliant store count across 536 IGA stores |
| Penetration in Store Zones | Main beverage fridge and off-location penetration by store |
| SKU Availability Across Zones | Individual SKU presence across main fridge and off-location |
| Price Ticket Execution | Average price by zone and pricing disparity across locations |

---

## Dashboard

Full dashboard export available here: [Nudie Juice – Compliance Check at IGA](https://raw.githubusercontent.com/asthachhabra-01/Nudie-Juice-Execution-Analytics-Dashboard/main/assets/Metabase%20-%20Nudie%20-%20Compliance%20Check%20at%20IGA.pdf)
---

### Perfect Store Compliance & Location Map

---

## Key Insights

**1. Perfect store compliance is critically low**
Only 4.66% of the 536 surveyed IGA stores met perfect store compliance criteria —
flagging an immediate priority for the field sales team heading into the next cycle.

**2. Off-location is outperforming the main fridge**
Off-location placement (40.67%) exceeds main beverage fridge presence (27.05%) —
Nudie Juice is winning secondary placement but underperforming in the primary cold 
zone where most beverage purchase decisions are made.

**3. Multi-execution presence is a key growth lever**
64.4% of stores have only one execution or display. Driving multi-execution presence 
is an immediate commercial opportunity to increase in-store visibility and conversion.

**4. Energy Tropical SKU is underperforming**
Core SKUs achieve over 84% availability across both zones. Nudie Energy Tropical 60ml 
lags at 75.66% in the main fridge — flagging a potential ranging or replenishment 
issue worth investigating.

**5. Pricing disparity exists in 1 in 8 stores**
87.18% of stores maintain consistent pricing across zones at an average of A$4.99. 
The 12.82% showing disparity warrants follow-up to ensure shelf ticket accuracy and 
avoid shopper confusion.

---

## SQL Queries

SQL queries powering this dashboard are available in [`queries.sql`](./queries.sql) 
with comments explaining the business logic behind each one.

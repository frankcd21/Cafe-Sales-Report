## Project Background
The Café Sales Analytics initiative was launched to provide executive leadership with clear, data‑driven insights into our retail café’s performance. By combining transaction‑level data with visual dashboards, the goal is to:
- Uncover top‑performing products and under‑leveraged opportunities
- Reveal seasonal and regional sales patterns
- Equip leadership with actionable recommendations to drive revenue growth, increase and retain customerbase and optimize inventory

An interactive Tableau Dashboard can be found [here](https://public.tableau.com/shared/ZD7WZCG4J?:display_count=n&:origin=viz_share_link)

The SQL queries used to prep, clean, and prepare the data can be found here: [here](https://github.com/frankcd21/Cafe-Sales-Report/blob/1faf55bfa911fb7be4dac344ef01e7f8901cfa48/cafe_cleaned_data.sql)


## Data Stucture Overview
 ![Clean Fact Table](https://raw.githubusercontent.com/frankcd21/Cafe-Sales-Report/841bc9f596ed4b0548cd4aba2b0075bf5fd2d772/test/Clean_cafe_data_ftable.jpg) 

Total Row Count - 10,000

Columns of Interest:

item, quantity, price_per_unit, total_spent



## Executive Summary


![Cafe Sales Dashboard](https://raw.githubusercontent.com/frankcd21/Cafe-Sales-Report/197f6fa3f1e8a4a8ce9e178419f0441745756bea/test/Cafe_Sales_Dashboard_img.png)
[Link to Dashboard](https://public.tableau.com/shared/ZD7WZCG4J?:display_count=n&:origin=viz_share_link)
- $80K Total Revenue over the year period, driven primarily by premium items.
- Top 3 Products (Salad, Sandwich, Smoothie) contributed  nearly 52% of total sales.
- Post‑January Decline: Revenue dipped nearly 40 percent after January indicating a holiday trend
- Price Sensitivity: Lower‑priced items (Tea, Cookies) show high transaction volume but low per‑unit revenue

**Recommendations**
1. *Premium Product Leadership*
Finding: Salads and Sandwiches, despite higher price points, outperformed expectations by driving the largest revenue share.
Implication: Reinforce premium pricing strategy; consider limited‑time flavors to maintain interest.

2. *Seasonal Demand Fluctuations*
Finding: A sharp drop in February (~40% vs. January) aligns with post‑holiday behavior.
Implication: Introduce targeted promotions or loyalty incentives in Q1 to maintain Janurary's momentum.

3. *Bundling and Upsell Potential*
Finding: Tea and Cookies exhibit volume but return the least amount of sales.
Implication: Create “add‑on” bundles (e.g., Tea + Biscuit at a slight discount) to lift average ticket size or reduce the amount of lower value items being sold to optimize inventory

4. *More Accurate Data Collecting*
Finding: The dataset revealed significant missing values in key operational fields, including location (in‑store vs. online) and payment method (cash vs. card). These data points are critical for understanding channel performance, customer preferences, and transactional behaviors.
Implication: Improving data capture at the point of sale is essential to unlocking deeper analytics. Enhanced visibility could support decisions around store layout, digital strategy, and payment infrastructure.
Strategic Opportunity: Consider launching a customer‑facing app or loyalty system that not only captures transaction metadata but also enhances customer retention through personalization and incentives.




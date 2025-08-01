# SQL-Covid-Exploration

This project is a beginner SQL analysis where I explored COVID-19 data using Microsoft SQL Server. I used SQL queries to find insights such as total deaths, infection rates, and vaccination trends across countries and continents. The goal was to improve my SQL skills by working with real-world datasets and practicing with tools like CTEs, temp tables, views, and window functions.

## 🔧 Tools Used

- Microsoft SQL Server Management Studio (SSMS)
- T-SQL
- Public COVID-19 dataset (Deaths and Vaccinations)

## 📊 Key Features

- Analyzed total cases vs total deaths to calculate mortality rate
- Measured what percentage of each country’s population got infected
- Identified countries and continents with the highest death counts
- Tracked vaccination progress using rolling totals
- Created CTEs and temp tables to simplify complex queries
- Built a SQL view (`PercentPopulationVaccinated`) to store data for future visualization

## ▶️ How to Run This Project

1. Open the `.sql` file in SQL Server Management Studio.
2. Make sure the `PortfolioProject` database is set up with the appropriate tables:
   - `CovidDeaths`
   - `CovidVaccinations`
3. Run the queries section by section to follow the exploration process.
4. Modify any WHERE clauses to explore different countries or continents.

## 📚 Learning Takeaways

Through this project, I learned how to:

- Write clean, readable SQL for real-world data analysis
- Use SQL joins to combine datasets
- Apply window functions like `SUM() OVER` for cumulative totals
- Create and use common table expressions (CTEs)
- Store query results in temp tables and views for reuse
- Gain insights from large public health datasets

## 📊 Visualization

Check out the interactive Tableau dashboard that visualizes the results of this SQL exploration:  
👉 https://public.tableau.com/app/profile/edward.truong/viz/2021CovidDashboard_17511583960440/Dashboard1?publish=yes

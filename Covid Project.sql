\

--SELECT *
--FROM PortfolioProject..CovidVaccinations
--ORDERBY 3,4;

-- DATA SET THAT I AM WORKING WITH 

SELECT location, date, total_cases, new_cases,total_deaths,population
FROM PortfolioProject..CovidDeaths
ORDER BY 1,2;

-- TOTAL CASES VS TOTAL DEATHS
-- SHOWS LIKELIHOOD OF DYING IF YOU CATCH COVID IN CANADA
SELECT location, date, total_cases,	total_deaths, (total_deaths/total_cases) * 100 AS Death_percentage
FROM PortfolioProject..CovidDeaths
WHERE location = 'CANADA'
AND continent IS NOT NULL
ORDER BY 1,2;

-- TOTAL CASES VS POPULATION
-- Shows what percentage of population that got Covid
SELECT location, date, population, total_cases, (total_cases/population) * 100 AS PercentagePopulationInfected
FROM PortfolioProject..CovidDeaths
WHERE location = 'Canada'
AND continent IS NOT NULL
ORDER BY 1,2;


-- Looking at country with highest infection rate compared to population
SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population)) * 100 AS PercentagePopulationInfected
FROM PortfolioProject..CovidDeaths
--WHERE location = 'Canada'
WHERE continent IS NOT NULL
GROUP BY location, populatioN
ORDER BY PercentagePopulationInfected DESC;


-- Showing Countries with Highest Death Count per Population
SELECT location, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location = 'Canada'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;


--LET'S BREAK THINGS DOWN  BY CONTINENT

-- Showing Contient with rthe highest death count per population
SELECT continent, MAX(total_deaths) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--WHERE location = 'Canada'
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC;



-- GLOBAL NUMBERS
SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths,  SUM(CAST(new_deaths AS INT)) / SUM(new_cases) * 100 AS death_percentage
FROM PortfolioProject..CovidDeaths
--WHERE location = 'CANADA'
WHERE continent IS NOT NULL
ORDER BY 1,2;


-- TOTAL POPULATION vs VACCINATIONS
SELECT death.continent, 
		death.location, 
		death.date, 
		death.population,
		vac.new_vaccinations,
		SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) AS RollingPeopleVaccinated
--		,(RollingPeopleVaccinated / population) * 100
FROM PortfolioProject..CovidDeaths death
JOIN PortfolioProject..CovidVaccinations vac
	ON death.location = vac.location
	AND death.date = vac.date
WHERE death.continent IS NOT NULL
ORDER BY 2,3

-- USE CTE
WITH PopvsVac (continent, location, date, population, new_vaccination, RollingPeopleVaccinated)
AS
(
SELECT death.continent, 
		death.location, 
		death.date, 
		death.population,
		vac.new_vaccinations,
		SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) AS RollingPeopleVaccinated
--		,(RollingPeopleVaccinated / population) * 100
FROM PortfolioProject..CovidDeaths death
JOIN PortfolioProject..CovidVaccinations vac
	ON death.location = vac.location
	AND death.date = vac.date
WHERE death.continent IS NOT NULL
--ORDER BY 2,3
)
Select *,
		(RollingPeopleVaccinated / CAST(population AS FLOAT)) * 100
FROM PopvsVac

-- TEMP TABLE
DROP TABLE IF exists #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccination numeric,
RollingPeopleVaccinated numeric
)

INSERT INTO #PercentPopulationVaccinated
SELECT death.continent, 
		death.location, 
		death.date, 
		death.population,
		vac.new_vaccinations,
		SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) AS RollingPeopleVaccinated
--		,(RollingPeopleVaccinated / population) * 100
FROM PortfolioProject..CovidDeaths death
JOIN PortfolioProject..CovidVaccinations vac
	ON death.location = vac.location
	AND death.date = vac.date
WHERE death.continent IS NOT NULL
--ORDER BY 2,3

Select *,
		(RollingPeopleVaccinated / population) * 100
FROM #PercentPopulationVaccinated


-- Creating view to store data for later visualization
CREATE VIEW PercentPopulationVaccinated AS
SELECT death.continent, 
		death.location, 
		death.date, 
		death.population,
		vac.new_vaccinations,
		SUM(CONVERT(INT,vac.new_vaccinations)) OVER (PARTITION BY death.location ORDER BY death.location, death.date) AS RollingPeopleVaccinated
--		,(RollingPeopleVaccinated / population) * 100
FROM PortfolioProject..CovidDeaths death
JOIN PortfolioProject..CovidVaccinations vac
	ON death.location = vac.location
	AND death.date = vac.date;
WHERE death.continent IS NOT NULL
--ORDER BY 2,3


Select *
FROM PercentPopulationVaccinated 
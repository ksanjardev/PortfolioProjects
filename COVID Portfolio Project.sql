SELECT *
FROM [PortfolioProject].[dbo].[CovidDeaths]
order by 3,4

--SELECT *
--FROM [PortfolioProject].[dbo].[CovidVaccinations]
--order by 3,4


-- Select Data that we are going to be using
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
order by 1,2


-- Looking at Total Cases vs Total Deaths
-- Shows the likelihod of dying if you contract in your country
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases) *100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
Where location like '%Uzbekistan%'
order by 1,2


-- Looking at Total Cases vs Population
-- Shows what percentage of population get Covid

SELECT Location, date, population, total_cases, (total_cases/population) *100 as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--Where location like '%uzb%'
order by 1,2


-- Looking countries with highest Infection Rate compared to Population
SELECT Location, population, MAX(total_cases) as HigesInfectionCount, MAX((total_cases/population)) *100 
as PercentPopulationInfected
FROM PortfolioProject..CovidDeaths
--Where location like '%uzb%'
Group by location, population
order by PercentPopulationInfected desc


-- Showing Countires with Higheset Death Count per Population
SELECT Location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like '%uzb%'
where continent is not null
Group by location
order by TotalDeathCount desc



-- LET'S BREAK THINGS DOWN BY CONTINENT
-- Showing continents with the highest death count per population
SELECT continent, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
--Where location like '%uzb%'
where continent is not null
Group by continent
order by TotalDeathCount desc


-- GLOBAL NUMBERS 
SELECT  Sum(new_cases) as total_cases, Sum(cast(new_deaths as int)) as total_deaths, Sum(cast(new_deaths as int))/ Sum(new_cases) * 100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--Where location like '%Uzbekistan%'
Where continent is not null
--Group by date
order by 1,2



-- Looking at Total Population vs Vacciantions
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(int, vac.new_vaccinations)) 
OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3

-- USE CTE

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated) as 
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(int, vac.new_vaccinations)) 
OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population) * 100
From PopvsVac



-- TEMP TABLE 
Drop Table if exists #PercentPopulationVaccinated
Create table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vacciantions numeric,
RollingPeopleVaccinated numeric
)


Insert into #PercentPopulationVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(int, vac.new_vaccinations)) 
OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
--Where dea.continent is not null
--order by 2,3


Select *, (RollingPeopleVaccinated/Population) * 100
From #PercentPopulationVaccinated





-- Creating View to store data for later visualizations
Create View PercentPopulationVaccinated as 
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(Convert(int, vac.new_vaccinations)) 
OVER (Partition by dea.location order by dea.location, dea.date) as RollingPeopleVaccinated
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

Select *
From PercentPopulationVaccinated

Select * 
From PotfolioProject..CovidDeaths
Where continent is not null
order by 3,4

--select data that i am going to be using

Select Location,date,total_cases,new_cases,total_deaths,population
From PotfolioProject..CovidDeaths
order by 3,4

--Looking at total cases vs total deaths
--shows likelihood of dying if you contract covid in your country
Select Location , date, total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From PotfolioProject..CovidDeaths
Where location like '%states%'
and continent is not null
order by 1,2

--looking at total cases vs population
--shows what percentage of population got covid

Select Location,date,Population,total_cases,(total_cases/population)*100 as DeathPercentage
From PotfolioProject..CovidDeaths
Where continent is not null
order by 1,2


--looking at countries with highest infection rate compared to population

Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/population)*100 as PercentPolutionInfected
From PotfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by Location,Population
order by PercentPolutionInfected desc

--showing countries with highest death count per population

Select Location, MAX(cast(total_deaths as int)) as TotalDeathcount
From PotfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by Location
order by TotalDeathcount desc

--let`s break things down by continent

Select continent, MAX(cast(total_deaths as int)) as TotalDeathcount
From PotfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by continent
order by TotalDeathcount desc

--showing continents with the highest death count per population

Select continent, MAX(cast(total_deaths as int)) as TotalDeathcount
From PotfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
Group by continent
order by TotalDeathcount desc

--GLOBAL NUMBERS

Select SUM(new_cases) as TotalCases,SUM(cast(new_deaths as int)) as TotalDeaths,SUM(cast(new_deaths as int))/SUM(cast(new_cases as int))*100 as DeathPercentage
From PotfolioProject..CovidDeaths
--Where location like '%states%'
Where continent is not null
--Group by date
order by 1,2

--looking at total population vs vaccinations

Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations )) OVER (Partition by dea.Location Order by dea.location,
dea.Date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
From PotfolioProject..CovidDeaths dea
join PotfolioProject..CovidVaccinations vac
    on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
order by 2,3


---USE CTE

With Popvsvac (Continent , Location , Date , Population,New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations )) OVER (Partition by dea.Location Order by dea.location,
dea.Date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
From PotfolioProject..CovidDeaths dea
join PotfolioProject..CovidVaccinations vac
    on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3
)
Select *,(RollingPeopleVaccinated/Population)*100
From Popvsvac

--TEMP TABLE
DROP table if exists #PercentPopulationVaccinated
Create Table #PercentPopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeoplevaccinated numeric
)
Insert into #PercentPopulationVaccinated
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations )) OVER (Partition by dea.Location Order by dea.location,
dea.Date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
From PotfolioProject..CovidDeaths dea
join PotfolioProject..CovidVaccinations vac
    on dea.location = vac.location
	and dea.date = vac.date
--Where dea.continent is not null
--order by 2,3

Select *,(RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


Create View percentPopulationVaccinated as
Select dea.continent,dea.location,dea.date,dea.population,vac.new_vaccinations
,SUM(CONVERT(int,vac.new_vaccinations )) OVER (Partition by dea.Location Order by dea.location,
dea.Date) as RollingPeopleVaccinated
--,(RollingPeopleVaccinated/population)*100
From PotfolioProject..CovidDeaths dea
join PotfolioProject..CovidVaccinations vac
    on dea.location = vac.location
	and dea.date = vac.date
Where dea.continent is not null
--order by 2,3

Select * 
From
PercentPopulationVaccinated
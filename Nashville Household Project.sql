/*

Cleaning Data in SQL Queries

*/

Select * 
From PortfolioProject..NashvilleHousing

--------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

Select SaleDateConverted --Convert(date,SaleDate)
From PortfolioProject..NashvilleHousing

Update NashvilleHousing
SET SaleDate = CONVERT(Date, SaleDate)

Alter Table NashvilleHousing
Add SaleDateConverted Date;

Update NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)


 --------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address data

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
Join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null
	


Update a
Set a.PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
From PortfolioProject..NashvilleHousing a
Join PortfolioProject..NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null
	



--------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into Individual Columns (Address, City, State)


Select PropertyAddress 
From PortfolioProject..NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as Address 
From PortfolioProject..NashvilleHousing

Alter Table NashvilleHousing
Alter Column PropertySplitAddress Nvarchar(255) 

Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

--- for city
Alter Table NashvilleHousing
Add PropertySplitCity Nvarchar(255) 

Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))

---OwnerAddress separation

Select OwnerAddress
From NashvilleHousing

Select 
PARSENAME(Replace(OwnerAddress, ',', '.'),3),
PARSENAME(Replace(OwnerAddress, ',', '.'),2),
PARSENAME(Replace(OwnerAddress, ',', '.'),1)
From NashvilleHousing

Alter Table NashvilleHousing
Add OwnerSplitAddress Nvarchar(255)

Alter Table NashvilleHousing
Add OwnerSplitCity Nvarchar(255)

Alter Table NashvilleHousing
Add OwnerSplitState Nvarchar(255)

Update NashvilleHousing
Set OwnerSplitAddress = PARSENAME(Replace(OwnerAddress, ',', '.'),3),
OwnerSplitCity = PARSENAME(Replace(OwnerAddress, ',', '.'),2),
OwnerSplitState = PARSENAME(Replace(OwnerAddress, ',', '.'),1)


--------------------------------------------------------------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

Select Distinct(SoldAsVacant),Count(SoldAsVacant)
From NashvilleHousing
Group by SoldAsVacant
order by 2


Select SoldAsVacant,
Case When SoldAsVacant = 'Y' THEN 'Yes'
When SoldAsVacant = 'N' THEN 'No'
Else SoldAsVacant
End
From NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = Case When SoldAsVacant = 'Y' THEN 'Yes'
When SoldAsVacant = 'N' THEN 'No'
Else SoldAsVacant
End


-----------------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates
WITH RowNumCTE As (
	Select *,
	ROW_NUMBER() OVER (
	Partition By ParcelID, 
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 Order by 
				 UniqueID) row_num
From NashvilleHousing
)

--Delete 
Select *
From RowNumCTE
where row_num > 1


---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns


Select *
from NashvilleHousing

Alter Table NashvilleHousing
Drop Column OwnerAddress, TaxDistrict, PropertyAddress

-----------------------------------------------------------------------------------------------

--- Additional Data Cleaning => Only Identify Value Anomaly of Total Value != LandValue + BuildingValue

Select ISNULL(LandValue, -1) as lv, ISNULL(BuildingValue, -1) as bv, ISNULL(TotalValue, -1) as tv
From NashvilleHousing

Update NashvilleHousing
Set LandValue = ISNULL(LandValue, 0),
BuildingValue = ISNULL(BuildingValue, 0),
TotalValue= ISNULL(TotalValue, 0)

-- Create DiscrepancyAmount => the diff between TotalValue and Land+Building values
Select TotalValue - (LandValue + BuildingValue) as DiscrepancyAmount
From NashvilleHousing

Alter Table NashvilleHousing
Add DiscrepancyAmount int

Update NashvilleHousing
Set DiscrepancyAmount = TotalValue - (LandValue + BuildingValue)

Select TotalValue, LandValue, BuildingValue, (LandValue + BuildingValue) as LandBuildingValues 
From NashvilleHousing
Where TotalValue <> LandValue + BuildingValue


-----------------------------------------------------------------------------------------------
--- Group YearBuilt by date range


WITH CategorizedEra As(
Select SalePrice,
	Case When CAST(YearBuilt as Int) < 1980 Then 'Built Before 1980'
		When CAST(YearBuilt as Int) Between 1980 and 2000 Then 'Built 1980-2000'
		When CAST(YearBuilt as Int) > 2000 Then 'Built After 2000'
		Else 'Unknown Era'
		End as PropertyEra
From NashvilleHousing
)


Select AVG(SalePrice) as AvgSalePrice, PropertyEra
From CategorizedEra
Group By PropertyEra
Order by AvgSalePrice DESC

-----------------------------------------------------------------------------------------------

--- Importing Data using OPENROWSET and BULK INSERT	

--  More advanced and looks cooler, but have to configure server appropriately to do correctly
--  Wanted to provide this in case you wanted to try it


--sp_configure 'show advanced options', 1;
--RECONFIGURE;
--GO
--sp_configure 'Ad Hoc Distributed Queries', 1;
--RECONFIGURE;
--GO


--USE PortfolioProject 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'AllowInProcess', 1 

--GO 

--EXEC master.dbo.sp_MSset_oledb_prop N'Microsoft.ACE.OLEDB.12.0', N'DynamicParameters', 1 

--GO 


---- Using BULK INSERT

--USE PortfolioProject;
--GO
--BULK INSERT nashvilleHousing FROM 'C:\Temp\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv'
--   WITH (
--      FIELDTERMINATOR = ',',
--      ROWTERMINATOR = '\n'
--);
--GO


---- Using OPENROWSET
--USE PortfolioProject;
--GO
--SELECT * INTO nashvilleHousing
--FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
--    'Excel 12.0; Database=C:\Users\alexf\OneDrive\Documents\SQL Server Management Studio\Nashville Housing Data for Data Cleaning Project.csv', [Sheet1$]);
--GO


















/*PROYECTO AREA DE VENTAS ETL EN LA OLTP ADVENTUREWORK2019*/

-- Visusalizacion Tabla Producto
--(ProductName,ProductModel,ProductNumber,makeflag, FinishedGoods ,Color,size,sizeUnitMeasure,
-- Weight,weightUnitMeasure,Class,Style,SellstarDateKey,SellEndDatekey,DiscontinueDateKey,ProductCategoryName,ProductSubCategoryName)

select p.[Name] as ProductName,
pm.[Name] as ProductModel,
p.ProductNumber,
p.MakeFlag,
p.FinishedGoodsFlag,
p.Color,
p.Size,
p.SizeUnitMeasureCode,
p.[Weight],
p.WeightUnitMeasureCode,
p.Class,
p.Style,
p.SellStartDate,
p.SellEndDate,
p.DiscontinuedDate,
ca.[Name] as ProductCategoryName,
sca.[Name] as ProductSubCategoryName
from[Production].[Product] as p
inner join [Production].[ProductModel] pm 
on p.ProductModelID = pm.ProductModelID
inner join [Production].[ProductSubcategory] sca
on p.ProductSubcategoryID =sca.ProductSubcategoryID 
inner join [Production].[ProductCategory] ca
on ca.ProductCategoryID = sca.ProductCategoryID

--- vista DIM_sales Territory

--(Territory,CountryRegionCode,TerritoryGroup,ModifiedDateID)


select T.[Name] as Territory,
T.CountryRegionCode,
T.[Group] as TerritoryGroup,
T.ModifiedDate
from [Sales].[SalesTerritory] as T


-- Vista  DIM_ADDRES
--(AddresLine1,AddresLine2,City,PostalCode,SpatialLocation,StateProvinceID,AddressType,ModifiedDateID)

select pa.AddressLine1,
pa.AddressLine2,
pa.City,
pa.PostalCode,
pa.SpatialLocation,
pa.StateProvinceID,
atp.[Name] as AddressType,
pa.ModifiedDate
from [Person].[Address] as pa
inner join [Person].[BusinessEntityAddress] as ba
on ba.AddressID = pa.AddressID
inner join [Person].[AddressType] as atp
on atp.AddressTypeID = ba.AddressTypeID 


-- visualizcion DIM_shipmethod

--(ShipmentMethod)

select sp.[Name] as  ShipmentMethod
from [Purchasing].[ShipMethod] sp

-- Visuslaizcion DIM_SpecialOffer

--(Description,Type,Category,StarDateID,EndDateID)

select SF.[Description],
SF.[Type],
SF.[Category],
SF.StartDate as StarDateID,
SF.EndDate as EndDateID
from [Sales].[SpecialOffer] SF


--Visualizacion Sales_Person 
--(FirstName,MiddleName,LastName,FullName,Territory,CountryRegionCode,TerriroryGroup)

select pp.FirstName,
pp.MiddleName,
pp.LastName,
concat_ws(' ',pp.FirstName,pp.LastName) as NombreCompleto,
st.[Name] as Territory,
st.CountryRegionCode,
st.[Group]  as TerriroryGroup
from  [Sales].[SalesPerson] sp
inner join [Person].[Person]  pp
on sp.BusinessEntityID = pp.BusinessEntityID
inner join [Sales].[SalesTerritory] st
on st.TerritoryID = sp.TerritoryID


--Visualizacion  Customer 
--(StoreName,Territory,CountryRegionCode,TerritoryGroup,SalesRepName,ModifiedDateID)

select 
sto.[Name] as StoreName,
st.[Name] as Territory,
st.CountryRegionCode,
st.[Group]  as TerriroryGroup,
concat_ws(' ',pp.FirstName,pp.LastName) as NombreCompleto,
soh.ModifiedDate
from  [Sales].[SalesPerson] sp
inner join [Person].[Person]  pp
on sp.BusinessEntityID = pp.BusinessEntityID
inner join [Sales].[SalesTerritory] st
on st.TerritoryID = sp.TerritoryID
inner join [Sales].[SalesOrderHeader] soh
on soh.TerritoryID = st.TerritoryID
inner join [Sales].[Store] sto
on soh.SalesPersonID = sto.SalesPersonID


--- Visualizacion DIM_SPECIALOFFER
--(Description,Type,Category,StarDateID,EndDateID)

select
so.Description,
so.Type,
so.Category,
so.StartDate as StarDateID,
so.EndDate as EndDateID
from [Sales].[SpecialOffer] so

-- Visualizacion DIM_DATE

select Convert (date,da.ModifiedDate) as Date
from [Sales].[SalesOrderDetail] da

--visualizacion de la tabla Fact_SalesOrdersDetail


select 
od.SalesOrderDetailID,
od.SalesOrderID,
od.ProductID,
od.SpecialOfferID,
soh.[Status] as SalesOrderstatus,
soh.OnlineOrderFlag,
soh.AccountNumber,
soh.CustomerID,
soh.SalesPersonID,
soh.TerritoryID,
soh.BillToAddressID,
soh.ShipToAddressID,
soh.ShipMethodID,
od.ModifiedDate,
soh.OrderDate,
soh.DueDate,
soh.ShipDate,
soh.ModifiedDate,
od.OrderQty as Quantity,
od.UnitPrice, 
od.UnitPriceDiscount,
od.LineTotal,
soh.SubTotal,
soh.TaxAmt,
soh.Freight,
soh.TotalDue
from [Sales].[SalesOrderDetail] od
inner join [Sales].[SalesOrderHeader] soh
on od.SalesOrderID = soh.SalesOrderID

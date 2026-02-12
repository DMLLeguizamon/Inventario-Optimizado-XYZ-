-- ============================================
-- PROYECTO: Manufacturing Company Database
-- Descripción: Sistema de gestión de inventario, ventas y compras
-- ============================================

-- ============================================
-- PARTE 1: CREACIÓN DE LA BASE DE DATOS
-- ============================================

CREATE DATABASE ManufacturingCompany;
GO

USE ManufacturingCompany;
GO

-- ============================================
-- PARTE 2: CREACIÓN DE TABLAS MAESTRAS
-- ============================================

-- Tabla: Proveedor (Catálogo de proveedores)
CREATE TABLE dbo.Proveedor (
    VendorNumber INT NOT NULL,
    VendorName NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Proveedor PRIMARY KEY (VendorNumber)
);
GO

-- Tabla: Stores (Catálogo de tiendas/sucursales)
CREATE TABLE dbo.Stores (
    StoreID INT NOT NULL,
    StoreName NVARCHAR(100) NOT NULL,
    City NVARCHAR(50) NULL,
    CONSTRAINT PK_Stores PRIMARY KEY (StoreID)
);
GO

-- Tabla: Brands (Catálogo de productos/bebidas)
CREATE TABLE dbo.Brands (
    BrandID INT NOT NULL,
    BrandDescription NVARCHAR(200) NOT NULL,
    Size NVARCHAR(20) NULL,
    Volume INT NULL,
    Classification INT NULL,
    RetailPrice DECIMAL(10,2) NULL,
    PurchasePrice DECIMAL(10,2) NULL,
    VendorNumber INT NULL,
    CONSTRAINT PK_Brands PRIMARY KEY (BrandID),
    CONSTRAINT FK_Brands_Proveedor FOREIGN KEY (VendorNumber)
        REFERENCES dbo.Proveedor(VendorNumber)
);
GO

-- ============================================
-- PARTE 3: CREACIÓN DE TABLAS TRANSACCIONALES
-- ============================================

-- Tabla: Inventory (Registro de inventarios inicial y final)
CREATE TABLE dbo.Inventory (
    InventoryID NVARCHAR(100) NOT NULL,
    StoreID INT NOT NULL,
    BrandID INT NOT NULL,
    OnHandBegin INT NULL,
    OnHandEnd INT NULL,
    StartDate DATE NULL,
    EndDate DATE NULL,
    CONSTRAINT PK_Inventory PRIMARY KEY (InventoryID),
    CONSTRAINT FK_Inventory_Stores FOREIGN KEY (StoreID)
        REFERENCES dbo.Stores(StoreID),
    CONSTRAINT FK_Inventory_Brands FOREIGN KEY (BrandID)
        REFERENCES dbo.Brands(BrandID)
);
GO

-- Tabla: Purchases (Registro de compras a proveedores)
CREATE TABLE dbo.Purchases (
    PurchaseID INT IDENTITY(1,1) NOT NULL,
    InventoryID NVARCHAR(100) NULL,
    StoreID INT NULL,
    BrandID INT NULL,
    VendorNumber INT NULL,
    Freight DECIMAL(10,2) NULL,
    Approval NVARCHAR(100) NULL,
    PONumber INT NULL,
    PODate DATE NULL,
    ReceivingDate DATE NULL,
    InvoiceDate DATE NULL,
    PayDate DATE NULL,
    PurchasePrice DECIMAL(10,2) NULL,
    Quantity INT NULL,
    Dollars DECIMAL(10,2) NULL,
    Classification INT NULL,
    CONSTRAINT PK_Purchases PRIMARY KEY (PurchaseID),
    CONSTRAINT FK_Purchases_Stores FOREIGN KEY (StoreID)
        REFERENCES dbo.Stores(StoreID),
    CONSTRAINT FK_Purchases_Brands FOREIGN KEY (BrandID)
        REFERENCES dbo.Brands(BrandID),
    CONSTRAINT FK_Purchases_Proveedor FOREIGN KEY (VendorNumber)
        REFERENCES dbo.Proveedor(VendorNumber),
    CONSTRAINT FK_Purchases_Inventory FOREIGN KEY (InventoryID)
        REFERENCES dbo.Inventory(InventoryID)
);
GO

-- Tabla: SalesDetail (Registro de ventas realizadas)
CREATE TABLE dbo.SalesDetail (
    SaleID INT IDENTITY(1,1) NOT NULL,
    InventoryID NVARCHAR(100) NULL,
    StoreID INT NULL,
    BrandID INT NULL,
    VendorNumber INT NULL,
    SalesQuantity INT NULL,
    SalesDollars DECIMAL(10,2) NULL,
    SalesPrice DECIMAL(10,2) NULL,
    SalesDate DATE NULL,
    Volume INT NULL,
    Classification INT NULL,
    ExciseTax DECIMAL(10,2) NULL,
    CONSTRAINT PK_SalesDetail PRIMARY KEY (SaleID),
    CONSTRAINT FK_SalesDetail_Stores FOREIGN KEY (StoreID)
        REFERENCES dbo.Stores(StoreID),
    CONSTRAINT FK_SalesDetail_Brands FOREIGN KEY (BrandID)
        REFERENCES dbo.Brands(BrandID),
    CONSTRAINT FK_SalesDetail_Proveedor FOREIGN KEY (VendorNumber)
        REFERENCES dbo.Proveedor(VendorNumber),
    CONSTRAINT FK_SalesDetail_Inventory FOREIGN KEY (InventoryID)
        REFERENCES dbo.Inventory(InventoryID)
);
GO

-- ============================================
-- PARTE 4: CARGA DE DATOS - TABLAS MAESTRAS
-- ============================================

-- ============================================
-- CARGA 1: PROVEEDOR
-- ============================================

IF OBJECT_ID('tempdb..#TempVendors') IS NOT NULL DROP TABLE #TempVendors;

CREATE TABLE #TempVendors (
    VendorNumber VARCHAR(50),
    VendorName VARCHAR(500),
    InvoiceDate VARCHAR(50),
    PONumber VARCHAR(50),
    PODate VARCHAR(50),
    PayDate VARCHAR(50),
    Quantity VARCHAR(50),
    Dollars VARCHAR(50),
    Freight VARCHAR(50),
    Approval VARCHAR(200)
);
GO

BULK INSERT #TempVendors
FROM "C:\Users\legui\OneDrive\Escritorio\Repositorio Inventory\base de datos\DataSet\InvoicePurchases12312016.csv"
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    FORMAT = 'CSV'
);
GO

INSERT INTO dbo.Proveedor (VendorNumber, VendorName)
SELECT 
    CAST(VendorNumber AS INT),
    MAX(VendorName)
FROM #TempVendors
WHERE VendorNumber IS NOT NULL
  AND LTRIM(RTRIM(VendorNumber)) <> ''
GROUP BY CAST(VendorNumber AS INT);
GO

DROP TABLE #TempVendors;
GO

PRINT 'Proveedores cargados: ' + CAST((SELECT COUNT(*) FROM dbo.Proveedor) AS VARCHAR);
GO

-- ============================================
-- CARGA 2: STORES
-- ============================================

IF OBJECT_ID('tempdb..#TempStores') IS NOT NULL DROP TABLE #TempStores;

CREATE TABLE #TempStores (
    InventoryId VARCHAR(200),
    Store VARCHAR(50),
    City VARCHAR(200),
    Brand VARCHAR(50),
    Description VARCHAR(500),
    Size VARCHAR(50),
    onHand VARCHAR(50),
    Price VARCHAR(50),
    startDate VARCHAR(50)
);
GO

BULK INSERT #TempStores
FROM 'C:\ManufacturingCompany\DATASET INVENTORY\BegInvFINAL12312016.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    FORMAT = 'CSV'
);
GO

INSERT INTO dbo.Stores (StoreID, StoreName, City)
SELECT DISTINCT
    CAST(Store AS INT),
    City,
    City
FROM #TempStores
WHERE Store IS NOT NULL
ORDER BY CAST(Store AS INT);
GO

DROP TABLE #TempStores;
GO

PRINT 'Tiendas cargadas: ' + CAST((SELECT COUNT(*) FROM dbo.Stores) AS VARCHAR);
GO

-- ============================================
-- CARGA 3: BRANDS
-- ============================================

IF OBJECT_ID('tempdb..#TempBrands') IS NOT NULL DROP TABLE #TempBrands;

CREATE TABLE #TempBrands (
    Brand VARCHAR(50),
    Description VARCHAR(500),
    Price VARCHAR(50),
    Size VARCHAR(50),
    Volume VARCHAR(50),
    Classification VARCHAR(50),
    PurchasePrice VARCHAR(50),
    VendorNumber VARCHAR(50),
    VendorName VARCHAR(200)
);
GO

BULK INSERT #TempBrands
FROM 'C:\ManufacturingCompany\DATASET INVENTORY\2017PurchasePricesDec.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    KEEPNULLS,
    FORMAT = 'CSV'
);
GO

INSERT INTO dbo.Brands (
    BrandID,
    BrandDescription,
    Size,
    Volume,
    Classification,
    RetailPrice,
    PurchasePrice,
    VendorNumber
)
SELECT 
    TRY_CAST(b.Brand AS INT),
    COALESCE(NULLIF(LTRIM(RTRIM(b.Description)), ''), 'Unknown'),
    b.Size,
    TRY_CAST(TRY_CAST(b.Volume AS DECIMAL(10,2)) AS INT),
    TRY_CAST(b.Classification AS INT),
    TRY_CAST(b.Price AS DECIMAL(10,2)),
    TRY_CAST(b.PurchasePrice AS DECIMAL(10,2)),
    TRY_CAST(b.VendorNumber AS INT)
FROM #TempBrands b
INNER JOIN dbo.Proveedor p ON TRY_CAST(b.VendorNumber AS INT) = p.VendorNumber
WHERE TRY_CAST(b.Brand AS INT) IS NOT NULL;
GO

DROP TABLE #TempBrands;
GO

PRINT 'Productos cargados: ' + CAST((SELECT COUNT(*) FROM dbo.Brands) AS VARCHAR);
GO

-- ============================================
-- PARTE 5: CARGA DE DATOS - TABLAS TRANSACCIONALES
-- ============================================

-- ============================================
-- CARGA 4: INVENTORY
-- ============================================

IF OBJECT_ID('tempdb..#TempBegInv') IS NOT NULL DROP TABLE #TempBegInv;
IF OBJECT_ID('tempdb..#TempEndInv') IS NOT NULL DROP TABLE #TempEndInv;

CREATE TABLE #TempBegInv (
    InventoryId VARCHAR(200),
    Store VARCHAR(50),
    City VARCHAR(100),
    Brand VARCHAR(50),
    Description VARCHAR(500),
    Size VARCHAR(50),
    onHand VARCHAR(50),
    Price VARCHAR(50),
    startDate VARCHAR(50)
);

CREATE TABLE #TempEndInv (
    InventoryId VARCHAR(200),
    Store VARCHAR(50),
    City VARCHAR(100),
    Brand VARCHAR(50),
    Description VARCHAR(500),
    Size VARCHAR(50),
    onHand VARCHAR(50),
    Price VARCHAR(50),
    endDate VARCHAR(50)
);
GO

BULK INSERT #TempBegInv
FROM 'C:\ManufacturingCompany\DATASET INVENTORY\BegInvFINAL12312016.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    KEEPNULLS,
    FORMAT = 'CSV'
);
GO

BULK INSERT #TempEndInv
FROM 'C:\ManufacturingCompany\DATASET INVENTORY\EndInvFINAL12312016.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    KEEPNULLS,
    FORMAT = 'CSV'
);
GO

INSERT INTO dbo.Inventory (
    InventoryID,
    StoreID,
    BrandID,
    OnHandBegin,
    OnHandEnd,
    StartDate,
    EndDate
)
SELECT
    COALESCE(b.InventoryId, e.InventoryId),
    s.StoreID,
    br.BrandID,
    TRY_CAST(b.onHand AS INT),
    TRY_CAST(e.onHand AS INT),
    TRY_CONVERT(DATE, b.startDate),
    TRY_CONVERT(DATE, e.endDate)
FROM #TempBegInv b
FULL OUTER JOIN #TempEndInv e ON b.InventoryId = e.InventoryId
INNER JOIN dbo.Stores s ON s.StoreID = TRY_CAST(COALESCE(b.Store, e.Store) AS INT)
INNER JOIN dbo.Brands br ON br.BrandID = TRY_CAST(COALESCE(b.Brand, e.Brand) AS INT)
WHERE COALESCE(b.InventoryId, e.InventoryId) IS NOT NULL
  AND COALESCE(b.InventoryId, e.InventoryId) <> '';
GO

DROP TABLE #TempBegInv;
DROP TABLE #TempEndInv;
GO

PRINT 'Registros de inventario cargados: ' + CAST((SELECT COUNT(*) FROM dbo.Inventory) AS VARCHAR);
GO

-- ============================================
-- CARGA 5: SALESDETAIL
-- ============================================

ALTER DATABASE ManufacturingCompanyDB SET RECOVERY SIMPLE;
GO

IF OBJECT_ID('tempdb..#TempSales') IS NOT NULL DROP TABLE #TempSales;

CREATE TABLE #TempSales (
    InventoryId VARCHAR(200),
    Store VARCHAR(50),
    Brand VARCHAR(50),
    Description VARCHAR(500),
    Size VARCHAR(50),
    SalesQuantity VARCHAR(50),
    SalesDollars VARCHAR(50),
    SalesPrice VARCHAR(50),
    SalesDate VARCHAR(50),
    Volume VARCHAR(50),
    Classification VARCHAR(50),
    ExciseTax VARCHAR(50),
    VendorNo VARCHAR(50),
    VendorName VARCHAR(200)
);
GO

BULK INSERT #TempSales
FROM 'C:\ManufacturingCompany\DATASET INVENTORY\SalesFINAL12312016.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    KEEPNULLS,
    FORMAT = 'CSV'
);
GO

DECLARE @BatchSize INT = 25000;
DECLARE @ProcessedSales INT = 0;

WHILE EXISTS (SELECT 1 FROM #TempSales)
BEGIN
    BEGIN TRANSACTION;

    INSERT INTO dbo.SalesDetail (
        InventoryID,
        StoreID,
        BrandID,
        VendorNumber,
        SalesQuantity,
        SalesDollars,
        SalesPrice,
        SalesDate,
        Volume,
        Classification,
        ExciseTax
    )
    SELECT TOP (@BatchSize)
        s.InventoryId,
        st.StoreID,
        b.BrandID,
        v.VendorNumber,
        TRY_CAST(s.SalesQuantity AS INT),
        TRY_CAST(s.SalesDollars AS DECIMAL(10,2)),
        TRY_CAST(s.SalesPrice AS DECIMAL(10,2)),
        TRY_CONVERT(DATE, s.SalesDate),
        TRY_CAST(s.Volume AS INT),
        TRY_CAST(s.Classification AS INT),
        TRY_CAST(s.ExciseTax AS DECIMAL(10,2))
    FROM #TempSales s
    INNER JOIN dbo.Inventory i ON i.InventoryID = s.InventoryId
    INNER JOIN dbo.Stores st ON st.StoreID = TRY_CAST(s.Store AS INT)
    INNER JOIN dbo.Brands b ON b.BrandID = TRY_CAST(s.Brand AS INT)
    INNER JOIN dbo.Proveedor v ON v.VendorNumber = TRY_CAST(s.VendorNo AS INT)
    WHERE s.InventoryId IS NOT NULL AND s.InventoryId <> '';

    COMMIT TRANSACTION;

    DELETE TOP (@BatchSize) FROM #TempSales WHERE InventoryId IS NOT NULL;
    
    SET @ProcessedSales = @ProcessedSales + @BatchSize;
    PRINT 'Ventas procesadas: ' + CAST(@ProcessedSales AS VARCHAR);
END
GO

DROP TABLE #TempSales;
GO

PRINT 'Total ventas cargadas: ' + CAST((SELECT COUNT(*) FROM dbo.SalesDetail) AS VARCHAR);
GO

-- ============================================
-- CARGA 6: PURCHASES
-- ============================================

IF OBJECT_ID('dbo.TempPurchases') IS NOT NULL DROP TABLE dbo.TempPurchases;

CREATE TABLE dbo.TempPurchases (
    InventoryId VARCHAR(200),
    Store VARCHAR(50),
    Brand VARCHAR(50),
    Description VARCHAR(500),
    Size VARCHAR(50),
    VendorNumber VARCHAR(50),
    VendorName VARCHAR(200),
    PONumber VARCHAR(50),
    PODate VARCHAR(50),
    ReceivingDate VARCHAR(50),
    InvoiceDate VARCHAR(50),
    PayDate VARCHAR(50),
    PurchasePrice VARCHAR(50),
    Quantity VARCHAR(50),
    Dollars VARCHAR(50),
    Classification VARCHAR(50)
);
GO

BULK INSERT dbo.TempPurchases
FROM 'C:\ManufacturingCompany\DATASET INVENTORY\PurchasesFINAL12312016.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK,
    FORMAT = 'CSV',
    BATCHSIZE = 50000
);
GO

ALTER TABLE dbo.Purchases NOCHECK CONSTRAINT ALL;
GO

DECLARE @i INT = 0;
DECLARE @total INT;
SELECT @total = COUNT(*) FROM dbo.TempPurchases;

WHILE @i < @total
BEGIN
    INSERT INTO dbo.Purchases (
        InventoryID,
        StoreID,
        BrandID,
        VendorNumber,
        PONumber,
        PODate,
        ReceivingDate,
        InvoiceDate,
        PayDate,
        PurchasePrice,
        Quantity,
        Dollars,
        Classification
    )
    SELECT TOP 50000
        InventoryId,
        CASE WHEN Store = '' OR Store IS NULL THEN NULL ELSE CAST(Store AS INT) END,
        CASE WHEN Brand = '' OR Brand IS NULL THEN NULL ELSE CAST(Brand AS INT) END,
        CASE WHEN VendorNumber = '' OR VendorNumber IS NULL THEN NULL ELSE CAST(VendorNumber AS INT) END,
        CASE WHEN PONumber = '' OR PONumber IS NULL THEN NULL ELSE CAST(PONumber AS INT) END,
        TRY_CONVERT(DATE, PODate),
        TRY_CONVERT(DATE, ReceivingDate),
        TRY_CONVERT(DATE, InvoiceDate),
        TRY_CONVERT(DATE, PayDate),
        CASE WHEN PurchasePrice = '' OR PurchasePrice IS NULL THEN NULL ELSE CAST(PurchasePrice AS DECIMAL(10,2)) END,
        CASE WHEN Quantity = '' OR Quantity IS NULL THEN NULL ELSE CAST(Quantity AS INT) END,
        CASE WHEN Dollars = '' OR Dollars IS NULL THEN NULL ELSE CAST(Dollars AS DECIMAL(10,2)) END,
        CASE WHEN Classification = '' OR Classification IS NULL THEN NULL ELSE CAST(Classification AS INT) END
    FROM dbo.TempPurchases
    WHERE InventoryId IS NOT NULL AND InventoryId != '';
    
    DELETE TOP (50000) FROM dbo.TempPurchases;
    CHECKPOINT;
    
    SET @i = @i + 50000;
    PRINT 'Procesados: ' + CAST(@i AS VARCHAR) + ' de ' + CAST(@total AS VARCHAR);
END
GO

ALTER TABLE dbo.Purchases CHECK CONSTRAINT ALL;
GO

DROP TABLE dbo.TempPurchases;
GO

PRINT 'Total compras cargadas: ' + CAST((SELECT COUNT(*) FROM dbo.Purchases) AS VARCHAR);
GO

ALTER DATABASE ManufacturingCompanyDB SET RECOVERY FULL;
GO

-- ============================================
-- VERIFICACIÓN FINAL
-- ============================================

PRINT '';
PRINT '============================================';
PRINT '     RESUMEN DE CARGA COMPLETADA';
PRINT '============================================';
PRINT '';
PRINT 'Tablas Maestras:';
PRINT '  - Proveedor: ' + CAST((SELECT COUNT(*) FROM dbo.Proveedor) AS VARCHAR) + ' registros';
PRINT '  - Stores: ' + CAST((SELECT COUNT(*) FROM dbo.Stores) AS VARCHAR) + ' registros';
PRINT '  - Brands: ' + CAST((SELECT COUNT(*) FROM dbo.Brands) AS VARCHAR) + ' registros';
PRINT '';
PRINT 'Tablas Transaccionales:';
PRINT '  - Inventory: ' + CAST((SELECT COUNT(*) FROM dbo.Inventory) AS VARCHAR) + ' registros';
PRINT '  - SalesDetail: ' + CAST((SELECT COUNT(*) FROM dbo.SalesDetail) AS VARCHAR) + ' registros';
PRINT '  - Purchases: ' + CAST((SELECT COUNT(*) FROM dbo.Purchases) AS VARCHAR) + ' registros';
PRINT '';
PRINT '============================================';
PRINT 'Base de datos lista para análisis';
PRINT '============================================';
GO

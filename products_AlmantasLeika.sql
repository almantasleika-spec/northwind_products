
-- Northwind products lentelė

-- 1. Išveskite visus produktus iš lentelės Products.

/*SELECT *
FROM products;*/

-- 2. Išveskite produktus, kurių kaina (UnitPrice) didesnė nei 50.

/*SELECT *
FROM products
WHERE UnitPrice > 50
ORDER BY UnitPrice DESC;*/

-- 3. Išveskite produktus, kurie yra nebeparduodami (Discontinued).

/*SELECT *
FROM products
WHERE Discontinued = 'y';*/

-- 4. Išveskite produktus, kurių pavadinime yra žodis "dried".

/*SELECT *
FROM products
WHERE ProductName LIKE '%dried%';*/

-- 5. Išveskite produktus, kurie yra nebegaminami (Discontinued) bet dar yra pardavime (in stock).

/*SELECT *
FROM products
WHERE Discontinued = 'y' AND UnitsInStock != 0;*/

-- 6. Išveskite produktus, kurių kaina yra tarp 20 ir 40.

/*SELECT *
FROM products
WHERE UnitPrice BETWEEN 20 AND 40
ORDER BY UnitPrice DESC;*/

-- 7. Išveskite produktus, kurie yra arba neparduodami, arba jų kaina mažesnė nei 10.

/*SELECT *
FROM products
WHERE Discontinued = 'y'
	OR UnitPrice < 10;
ORDER BY UnitPrice DESC*/

-- 8. Išveskite visus produktus, kurių kategorijos ID yra 1, 2 arba 3 (naudojant IN).

/*SELECT *
FROM products
WHERE CategoryID IN (1, 2, 3)
ORDER BY CategoryID;*/

-- 9. Išveskite produktus, kurie neturi nurodyto tiekėjo.

/*SELECT *
FROM products
WHERE SupplierID IS NULL;*/

-- 10. Išveskite 5 brangiausius produktus pagal UnitPrice.

/*SELECT *
FROM products
ORDER BY UnitPrice DESC
LIMIT 5;*/

-- 11. Išveskite mažiausią ir didžiausią produkto kainą.

/*SELECT 
	MIN(UnitPrice) MinPrice,
    MAX(UnitPrice) MaxPrice
FROM products;*/

-- 12. Suskaičiuokite, kiek yra neparduodamų produktų.

/*SELECT 
	COUNT (Discontinued) neparduodami
FROM products
WHERE Discontinued = 'y';*/

-- 13. Išveskite vidutinę produkto kainą tarp visų produktų.

/*SELECT 
	ROUND(AVG(UnitPrice), 2) AvgUnitPrice
FROM products;*/
	
-- 14. Suskaičiuokite, kiek yra produktų kiekvienoje kategorijoje.

/*SELECT
	CategoryID,
    COUNT(ProductID) NoProduct
FROM products
GROUP BY CategoryID;*/

-- 15. Išveskite kategorijas, kuriose yra daugiau nei 10 produktų.

/*SELECT
	CategoryID,
    COUNT(ProductID) NoProduct
FROM products
GROUP BY CategoryID
HAVING NoProduct > 10;*/

-- 16. Išveskite kategorijas, kurių vidutinė produkto kaina didesnė nei 30.

/*SELECT
	CategoryID,
    ROUND(AVG(UnitPrice), 2) AvgUnitPrice
FROM products
GROUP BY CategoryID
HAVING AvgUnitPrice > 30;*/
    
-- 17. Išveskite tiekėjus (SupplierID), kurių produktų kiekis sandėlyje viršija 500 vnt. (bendras kiekis per visus jų produktus).

/*SELECT 
	SupplierID,
    SUM(UnitsInStock) UnitsInStock   
FROM products
GROUP BY SupplierID
HAVING UnitsInStock > 200;*/
  
-- 18. Išveskite produktus, kurie yra pigesni nei vidutinė visų produktų kaina.

/*SELECT
	ProductName,
    UnitPrice
FROM products
HAVING UnitPrice < (
	SELECT AVG(UnitPrice) 
	FROM products)
ORDER BY UnitPrice DESC; */

-- 19. Išveskite brangiausią produktą kiekvienoje kategorijoje (naudojant GROUP BY ir MAX).

/*WITH maxunitprice AS (
	SELECT 
		CategoryID,
		MAX(UnitPrice) AS MaxPrice
	FROM products
    GROUP BY CategoryID
)
SELECT
	products.ProductName,
    products.CategoryID,
    products.UnitPrice
FROM products
JOIN maxunitprice
ON products.CategoryID = maxunitprice.CategoryID
AND products.UnitPrice = maxunitprice.MaxPrice;*/

-- 20. Išveskite produktus, kurių tiekimo kiekis (UnitsOnOrder) yra didžiausias.

/*SELECT *
FROM products
WHERE UnitsOnOrder != 0
ORDER BY UnitsOnOrder DESC;*/ 

-- 21. Išveskite produktus, kurių sandėlyje yra mažiau nei užsakytų vienetų (unitsinstock < unitsonorder).

/*SELECT *
FROM products
WHERE UnitsInStock < UnitsOnOrder
ORDER BY UnitsOnOrder DESC;*/

-- 22. Išveskite kategorijos ID, kuriai priklauso daugiausiai produktų.

/*SELECT
	CategoryID,
	COUNT(ProductID) NoProducts
FROM Products
GROUP BY CategoryID
ORDER BY NoProducts DESC
LIMIT 1;*/

-- 23. Išveskite tiekėjų ID, kurie tiekia tik produktus, kurių kaina mažesnė nei visų produktų vidutinė kaina.

/*SELECT
	SupplierID
FROM products
WHERE UnitPrice < (
	SELECT AVG(UnitPrice)
    FROM products
    )
GROUP BY SupplierID;*/

-- 24. Išveskite 5 tiekėjus, kurių produktų kainų vidurkis yra aukščiausias, tačiau rodykite tik tiekėjus,
--     kurių visi produktai yra aktyvūs (discontinued = 'n') ir kurie tiekia bent 3 produktus.

/*SELECT
	SupplierID,
    COUNT(ProductID) NoProduct,
    ROUND(AVG(UnitPrice), 2) AvgPrice
FROM products
WHERE discontinued = 'n' 
GROUP BY SupplierID
HAVING COUNT(ProductID) > 3
ORDER BY AvgPrice DESC
LIMIT 5;*/


-- 25. Įterpkite naują produktą pavadinimu "Organic Honey", kainuojantį 15.50, kuris priklauso kategorijai 2,
--     turi 100 vnt. sandėlyje, 20 vnt. užsakyta ir tiekėją su ID 5.

/*INSERT INTO products (
    ProductName,
    SupplierID,
    CategoryID,
    QuantityPerUnit,
    UnitPrice,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued
	)
VALUES (
    'Organic Honey', 
    5,                
    2,                
    '100 units',      
    15.50,            
    100,              
    20,               
    0,                
    'n'               
	);*/

-- 26. Atlikite kainos pakeitimą visiems produktams, kurių tiekėjas yra 3 – padidinkite kainą 10%.

/*UPDATE products
SET UnitPrice = ROUND(UnitPrice * 1.1, 2)
WHERE SupplierID = 3;*/

-- 27. Nustatykite, kad visi produktai, kurių sandėlio likutis yra 0, būtų pažymėti kaip discontinued.

/*UPDATE products
SET Discontinued = 'y'
WHERE UnitsInStock = 0;*/

-- 28. Pašalinkite visus produktus, kurių kaina yra mažesnė nei 1 ir jie neturi sandėlio likučio bei nėra užsakyti. 

/*SET SQL_SAFE_UPDATES = 0;

DELETE FROM products
WHERE UnitPrice < 1
	AND UnitsInStock = 0
	AND UnitsOnOrder = 0;

SET SQL_SAFE_UPDATES = 1;*/

-- 29. Įterpkite 3 naujus testinius produktus  su skirtingomis kategorijomis ir kainomis,
--     kurie būtų naudojami testavimui (žodis Test pavadinime), ir pažymėkite juos kaip neparduodamus.

/*INSERT INTo products (
	ProductName,
    SupplierID,
    CategoryID,
    QuantityPerUnit,
    UnitPrice,
    UnitsInStock,
    UnitsOnOrder,
    ReorderLevel,
    Discontinued
    )
VALUES 
	('Test Product 1', 1, 1, '10 units', 5.00, 50, 0, 5, 'y'),
    ('Test Product 2', 2, 2, '20 units', 15.00, 25, 0, 5, 'y'),
    ('Test Product 3', 3, 3, '30 units', 25.00, 10, 0, 5, 'y');*/

-- 30. Pašalinkite visus produktus, kurių pavadinime yra žodis "Test".

/*DELETE FROM products
WHERE ProductName LIKE 'Test%';*/


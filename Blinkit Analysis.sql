-- To see the uploaded data
SELECT 
    *
FROM
    blinkit_data;
    
 -- To get the count of rows   
SELECT 
    COUNT(*)
FROM
    blinkit_data;

-- Handling data cleaning 
UPDATE blinkit_data
SET Item_Fat_Content = 
CASE 
WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
WHEN Item_Fat_Content = 'reg' THEN 'Regular'
ELSE Item_Fat_Content
END

-- To verify the changed values
SELECT DISTINCT
    (Item_Fat_Content)
FROM
    blinkit_data;

-- To get the total sales of 2022 in Million
SELECT 
    CONCAT(CAST(SUM(Total_Sales) / 1000000 AS DECIMAL (10 , 2 )),
            ' Million') AS Total_Sales_Millions
FROM
    blinkit_data
WHERE
    Outlet_Establishment_Year = 2022;

-- To get the average sales of 2022
SELECT 
    CAST(AVG(Total_Sales) AS DECIMAL (10 , 2 )) AS Avg_Sales
FROM
    blinkit_data
WHERE
    Outlet_Establishment_Year = 2022;
    
-- To identify the sales count in the year of 2022
SELECT 
    COUNT(*) AS No_Of_Items
FROM
    blinkit_data
WHERE
    Outlet_Establishment_Year = 2022;

-- To get the average rating
SELECT 
    CAST(AVG(Rating) AS DECIMAL (10 , 2 )) AS Avg_Rating
FROM
    blinkit_data;

-- To combine all the previous queries
SELECT 
    Item_Fat_Content,
    CONCAT(CAST(SUM(Total_Sales) / 1000 AS DECIMAL (10 , 2 )),
            ' K') AS Total_Sales_Thousands,
    CAST(AVG(Total_Sales) AS DECIMAL (10 , 2 )) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL (10 , 2 )) AS Avg_Rating
FROM
    blinkit_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousands DESC;

-- To get the top 5 Item types in sales
SELECT 
    Item_Type,
    CAST(SUM(Total_Sales) / 1000 AS DECIMAL (10 , 2 )) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL (10 , 2 )) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL (10 , 2 )) AS Avg_Rating
FROM
    blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC
LIMIT 5;

-- To get the bottom 5 Item types in sales
SELECT 
    Item_Type,
    CAST(SUM(Total_Sales) / 1000 AS DECIMAL (10 , 2 )) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL (10 , 2 )) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL (10 , 2 )) AS Avg_Rating
FROM
    blinkit_data
GROUP BY Item_Type
ORDER BY Total_Sales
LIMIT 5;

-- Fat Content by Outlet for Total Sales
SELECT 
    Outlet_Location_Type,
    CAST(SUM(CASE
            WHEN Item_Fat_Content = 'Low Fat' THEN Total_Sales
            ELSE 0
        END)
        AS DECIMAL (10 , 2 )) AS Low_Fat,
    CAST(SUM(CASE
            WHEN Item_Fat_Content = 'Regular' THEN Total_Sales
            ELSE 0
        END)
        AS DECIMAL (10 , 2 )) AS Regular
FROM
    blinkit_data
GROUP BY Outlet_Location_Type
ORDER BY Outlet_Location_Type;

-- Total, Average, Number of Sales and Average Rating by Outlet Establishment
SELECT 
    Outlet_Establishment_Year,
    CAST(SUM(Total_Sales) / 1000 AS DECIMAL (10 , 2 )) AS Total_Sales,
    CAST(AVG(Total_Sales) AS DECIMAL (10 , 2 )) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL (10 , 2 )) AS Avg_Rating
FROM
    blinkit_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year ASC;

-- Percentage of Sales by Outlet Size
SELECT Outlet_Size, CAST(SUM(Total_Sales) AS DECIMAL(10,2)) AS Total_Sales, CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM blinkit_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC;

-- Sales by Outlet Location
SELECT 
    Outlet_Location_Type,
    CAST(SUM(Total_Sales) / 1000 AS DECIMAL (10 , 2 )) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(Total_Sales) AS DECIMAL (10 , 2 )) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL (10 , 2 )) AS Avg_Rating
FROM
    blinkit_data
WHERE
	Outlet_Establishment_Year = 2022
GROUP BY Outlet_Location_Type
ORDER BY Total_Sales DESC;

-- All metrics with Outlet Type
SELECT 
    Outlet_Type,
    CAST(SUM(Total_Sales) / 1000 AS DECIMAL (10 , 2 )) AS Total_Sales,
    CAST((SUM(Total_Sales) * 100.0 / SUM(SUM(Total_Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
    CAST(AVG(Total_Sales) AS DECIMAL (10 , 2 )) AS Avg_Sales,
    COUNT(*) AS No_Of_Items,
    CAST(AVG(Rating) AS DECIMAL (10 , 2 )) AS Avg_Rating
FROM
    blinkit_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC;

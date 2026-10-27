SELECT COUNT(*) FROM singer
SELECT COUNT(*) FROM singer
SELECT Name, Country, Age FROM singer ORDER BY Age DESC
SELECT Name, Country, Age FROM singer ORDER BY Age DESC
SELECT AVG(Age), MIN(Age), MAX(Age) FROM singer WHERE Country = 'France'
SELECT AVG(Age), MIN(Age), MAX(Age) FROM singer WHERE Country = 'France'
SELECT T1.Name, T1.Song_release_year FROM singer AS T1 ORDER BY T1.Age LIMIT 1
SELECT Name, Song_release_year FROM singer ORDER BY Age LIMIT 1
SELECT DISTINCT Country FROM singer WHERE Age > 20
SELECT DISTINCT Country FROM singer WHERE Age > 20
SELECT Country, COUNT(Singer_ID) FROM singer GROUP BY Country
SELECT Country, COUNT(*) FROM singer GROUP BY Country
SELECT T1.Song_Name FROM singer AS T1 WHERE T1.Age > ( SELECT AVG(Age) FROM singer )
SELECT T1.Song_Name FROM singer AS T1 WHERE T1.Age > ( SELECT AVG(Age) FROM singer )
SELECT Location, Name FROM stadium WHERE Capacity BETWEEN 5000 AND 10000
SELECT Location, Name FROM stadium WHERE Capacity BETWEEN 5000 AND 10000
SELECT MAX(Capacity), AVG(Capacity) FROM stadium
SELECT AVG(Capacity), MAX(Capacity) FROM stadium
SELECT Name, Capacity FROM stadium ORDER BY Average DESC LIMIT 1
SELECT Name, Capacity FROM stadium ORDER BY Average DESC LIMIT 1
SELECT COUNT(concert_ID) FROM concert WHERE Year = '2014' OR Year = '2015'
SELECT COUNT(concert_ID) FROM concert WHERE Year = '2014' OR Year = '2015'
SELECT T1.Name, COUNT(T2.concert_ID) FROM stadium AS T1 INNER JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID GROUP BY T1.Name
SELECT T1.Name, COUNT(T2.concert_ID) FROM stadium AS T1 INNER JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID GROUP BY T1.Name
SELECT T1.Name, T1.Capacity FROM stadium AS T1 INNER JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T2.Year >= '2014' GROUP BY T1.Stadium_ID ORDER BY COUNT(T2.concert_ID) DESC LIMIT 1
SELECT T1.Name, T1.Capacity FROM stadium AS T1 INNER JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T2.Year > '2013' GROUP BY T1.Stadium_ID ORDER BY COUNT(T2.concert_ID) DESC LIMIT 1
SELECT Year FROM concert GROUP BY Year ORDER BY COUNT(*) DESC LIMIT 1
SELECT Year FROM concert GROUP BY Year ORDER BY COUNT(*) DESC LIMIT 1
SELECT Name FROM stadium WHERE Stadium_ID NOT IN ( SELECT Stadium_ID FROM concert )
SELECT Name FROM stadium WHERE Stadium_ID NOT IN (SELECT Stadium_ID FROM concert)
SELECT DISTINCT Country FROM singer WHERE Age > 40 INTERSECT SELECT DISTINCT Country FROM singer WHERE Age < 30
SELECT Name FROM stadium WHERE Stadium_ID NOT IN ( SELECT Stadium_ID FROM concert WHERE Year = '2014' )
SELECT Name FROM stadium WHERE Stadium_ID NOT IN (SELECT Stadium_ID FROM concert WHERE Year = '2014')
SELECT T1.concert_Name, T1.Theme, COUNT(T2.Singer_ID) AS NumberOfSingers FROM concert AS T1 INNER JOIN singer_in_concert AS T2 ON T1.concert_ID = T2.concert_ID GROUP BY T1.concert_ID
SELECT T1.concert_Name, T1.Theme, COUNT(T2.Singer_ID) AS NumberOfSingers FROM concert AS T1 INNER JOIN singer_in_concert AS T2 ON T1.concert_ID = T2.concert_ID GROUP BY T1.concert_ID
SELECT T1.Name, COUNT(T2.concert_ID) FROM singer AS T1 INNER JOIN singer_in_concert AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T1.Name
SELECT T1.Name, COUNT(T2.concert_ID) FROM singer AS T1 INNER JOIN singer_in_concert AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T1.Name
SELECT T1.Name FROM singer AS T1 INNER JOIN singer_in_concert AS T2 ON T1.Singer_ID = T2.Singer_ID INNER JOIN concert AS T3 ON T2.concert_ID = T3.concert_ID WHERE T3.Year = '2014'
SELECT T1.Name FROM singer AS T1 INNER JOIN singer_in_concert AS T2 ON T1.Singer_ID = T2.Singer_ID INNER JOIN concert AS T3 ON T2.concert_ID = T3.concert_ID WHERE T3.Year = '2014'
SELECT T1.Name, T1.Country FROM singer AS T1 WHERE T1.Song_Name LIKE '%Hey%'
SELECT Name, Country FROM singer WHERE Song_Name LIKE '%Hey%'
SELECT T1.Name, T1.Location FROM stadium AS T1 INNER JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T2.Year = '2014' INTERSECT SELECT T1.Name, T1.Location FROM stadium AS T1 INNER JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T2.Year = '2015'
SELECT T1.Name, T1.Location FROM stadium AS T1 INNER JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T2.Year = '2014' INTERSECT SELECT T1.Name, T1.Location FROM stadium AS T1 INNER JOIN concert AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T2.Year = '2015'
SELECT COUNT(T1.concert_ID) FROM concert AS T1 INNER JOIN stadium AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T2.Capacity = ( SELECT MAX(Capacity) FROM stadium )
SELECT COUNT(T1.concert_ID) FROM concert AS T1 INNER JOIN stadium AS T2 ON T1.Stadium_ID = T2.Stadium_ID WHERE T2.Capacity = ( SELECT MAX(Capacity) FROM stadium )
SELECT COUNT(*) FROM Pets WHERE weight > 10
SELECT COUNT(*) FROM Pets WHERE weight > 10
SELECT Weight FROM Pets WHERE PetType = 'Dog' ORDER BY pet_age LIMIT 1
SELECT T1.weight FROM Pets AS T1 INNER JOIN Has_Pet AS T2 ON T1.PetID = T2.PetID WHERE T1.PetType = 'Dog' ORDER BY T1.pet_age LIMIT 1
SELECT PetType, MAX(weight) FROM Pets GROUP BY PetType
SELECT PetType, MAX(weight) FROM Pets GROUP BY PetType
SELECT COUNT(T1.PetID) FROM Has_Pet AS T1 INNER JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T2.Age > 20
SELECT COUNT(T1.PetID) FROM Has_Pet AS T1 INNER JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T2.Age > 20
SELECT COUNT(T1.PetID) FROM Pets AS T1 INNER JOIN Has_Pet AS T2 ON T1.PetID = T2.PetID INNER JOIN Student AS T3 ON T2.StuID = T3.StuID WHERE T1.PetType = 'dog' AND T3.Sex = 'F'
SELECT COUNT(T1.PetID) FROM Pets AS T1 INNER JOIN Has_Pet AS T2 ON T1.PetID = T2.PetID INNER JOIN Student AS T3 ON T2.StuID = T3.StuID WHERE T1.PetType = 'dog' AND T3.Sex = 'f'
SELECT COUNT(DISTINCT PetType) FROM Pets
SELECT COUNT(DISTINCT PetType) FROM Pets
SELECT T1.Fname FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'cat' OR T3.PetType = 'dog'
SELECT T1.Fname FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'Cat' OR T3.PetType = 'Dog'
SELECT DISTINCT T1.Fname FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'cat' INTERSECT SELECT DISTINCT T1.Fname FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'dog'
SELECT DISTINCT T1.Fname FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'Cat' INTERSECT SELECT DISTINCT T1.Fname FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'Dog'
SELECT T1.Major, T1.Age FROM Student AS T1 WHERE T1.StuID NOT IN (SELECT StuID FROM Has_Pet WHERE PetID IN (SELECT PetID FROM Pets WHERE PetType = 'cat'))
SELECT T1.Major, T1.Age FROM Student AS T1 WHERE T1.StuID NOT IN ( SELECT StuID FROM Has_Pet WHERE PetID IN ( SELECT PetID FROM Pets WHERE PetType = 'cat' ) )
SELECT StuID FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet WHERE PetID IN (SELECT PetID FROM Pets WHERE PetType = 'cat'))
SELECT StuID FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet WHERE PetID IN (SELECT PetID FROM Pets WHERE PetType = 'cat'))
SELECT T1.Fname, T1.Age FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'Dog' AND NOT EXISTS (SELECT 1 FROM Has_Pet AS T4 INNER JOIN Pets AS T5 ON T4.PetID = T5.PetID WHERE T4.StuID = T1.StuID AND T5.PetType = 'Cat')
SELECT T1.Fname FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'Dog' AND NOT EXISTS (SELECT 1 FROM Has_Pet AS T4 INNER JOIN Pets AS T5 ON T4.PetID = T5.PetID WHERE T4.StuID = T1.StuID AND T5.PetType = 'Cat')
SELECT PetType, weight FROM Pets ORDER BY pet_age LIMIT 1
SELECT PetType, weight FROM Pets ORDER BY pet_age LIMIT 1
SELECT PetID, weight FROM Pets WHERE pet_age > 1
SELECT PetID, weight FROM Pets WHERE pet_age > 1
SELECT PetType, AVG(pet_age) AS average_age, MAX(pet_age) AS maximum_age FROM Pets GROUP BY PetType
SELECT PetType, AVG(pet_age) AS average_age, MAX(pet_age) AS maximum_age FROM Pets GROUP BY PetType
SELECT PetType, AVG(weight) FROM Pets GROUP BY PetType
SELECT PetType, AVG(weight) FROM Pets GROUP BY PetType
SELECT T1.Fname, T1.Age FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID
SELECT DISTINCT T1.Fname, T1.Age FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID
SELECT T1.PetID FROM Has_Pet AS T1 INNER JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T2.LName = 'Smith'
SELECT T1.PetID FROM Has_Pet AS T1 INNER JOIN Student AS T2 ON T1.StuID = T2.StuID WHERE T2.LName = 'Smith'
SELECT T1.StuID, COUNT(T2.PetID) AS num_pets FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID GROUP BY T1.StuID
SELECT T1.StuID, COUNT(T2.PetID) AS num_pets FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID GROUP BY T1.StuID
SELECT T1.Fname, T1.Sex FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID GROUP BY T1.StuID HAVING COUNT(T2.PetID) > 1
SELECT T1.Fname, T1.Sex FROM Student AS T1 JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID GROUP BY T1.StuID HAVING COUNT(T2.PetID) > 1
SELECT T1.LName FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'Cat' AND T3.pet_age = 3
SELECT T1.LName FROM Student AS T1 INNER JOIN Has_Pet AS T2 ON T1.StuID = T2.StuID INNER JOIN Pets AS T3 ON T2.PetID = T3.PetID WHERE T3.PetType = 'Cat' AND T3.pet_age = 3
SELECT AVG(Age) FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT AVG(Age) FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT COUNT(*) FROM continents
SELECT COUNT(*) FROM continents
SELECT T1.ContId, T1.Continent, COUNT(T2.CountryId) FROM continents AS T1 INNER JOIN countries AS T2 ON T1.ContId = T2.Continent GROUP BY T1.ContId
SELECT T1.ContId, T1.Continent, COUNT(T2.CountryId) FROM continents AS T1 INNER JOIN countries AS T2 ON T1.ContId = T2.Continent GROUP BY T1.ContId
SELECT COUNT(*) FROM countries
SELECT COUNT(*) FROM countries
SELECT T1.FullName, T1.Id, COUNT(T2.Model) FROM car_makers AS T1 INNER JOIN model_list AS T2 ON T1.Id = T2.Maker GROUP BY T1.Id
SELECT T1.FullName, T1.Id, COUNT(T2.Model) FROM car_makers AS T1 INNER JOIN model_list AS T2 ON T1.Id = T2.Maker GROUP BY T1.Id
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.Model INNER JOIN cars_data AS T3 ON T2.MakeId = T3.Id ORDER BY T3.Horsepower LIMIT 1
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.Model INNER JOIN cars_data AS T3 ON T2.MakeId = T3.Id ORDER BY T3.Horsepower LIMIT 1
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.Model INNER JOIN cars_data AS T3 ON T2.MakeId = T3.Id WHERE T3.Weight < ( SELECT AVG(Weight) FROM cars_data )
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.Model INNER JOIN cars_data AS T3 ON T2.MakeId = T3.Id WHERE T3.Weight < ( SELECT AVG(Weight) FROM cars_data )
SELECT DISTINCT T1.Maker FROM car_makers AS T1 INNER JOIN model_list AS T2 ON T1.Id = T2.Maker INNER JOIN car_names AS T3 ON T2.Model = T3.Model INNER JOIN cars_data AS T4 ON T3.MakeId = T4.Id WHERE T4.Year = 1970
SELECT DISTINCT T1.Maker FROM car_makers AS T1 INNER JOIN car_names AS T2 ON T1.Id = T2.Make INNER JOIN cars_data AS T3 ON T2.MakeId = T3.Id WHERE T3.Year = 1970
SELECT T1.Make, T2.Year FROM car_names AS T1 INNER JOIN cars_data AS T2 ON T1.MakeId = T2.Id ORDER BY T2.Year LIMIT 1
SELECT T1.Maker, T2.Year FROM car_makers AS T1 INNER JOIN car_names AS T3 ON T1.Id = T3.Make INNER JOIN cars_data AS T2 ON T3.MakeId = T2.Id ORDER BY T2.Year LIMIT 1
SELECT DISTINCT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.MakeId INNER JOIN cars_data AS T3 ON T2.MakeId = T3.Id WHERE T3.Year > 1980
SELECT DISTINCT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.MakeId INNER JOIN cars_data AS T3 ON T2.MakeId = T3.Id WHERE T3.Year > 1980
SELECT T1.Continent, COUNT(T2.CountryId) FROM continents AS T1 INNER JOIN countries AS T2 ON T1.ContId = T2.Continent INNER JOIN car_makers AS T3 ON T2.CountryId = T3.Country GROUP BY T1.Continent
SELECT T1.Continent, COUNT(T2.Country) AS NumberOfCarMakers FROM continents AS T1 INNER JOIN countries AS T2 ON T1.ContId = T2.Continent INNER JOIN car_makers AS T3 ON T2.CountryId = T3.Country GROUP BY T1.Continent
SELECT T1.CountryName FROM countries AS T1 INNER JOIN car_makers AS T2 ON T1.CountryId = T2.Country GROUP BY T1.CountryName ORDER BY COUNT(T2.Maker) DESC LIMIT 1
SELECT T1.CountryName FROM countries AS T1 INNER JOIN car_makers AS T2 ON T1.CountryId = T2.Country GROUP BY T1.CountryName ORDER BY COUNT(T2.Id) DESC LIMIT 1
SELECT COUNT(T1.Model), T2.FullName FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id GROUP BY T2.FullName
SELECT COUNT(T1.Model), T2.Id, T2.FullName FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id GROUP BY T2.Id
SELECT T1.Accelerate FROM cars_data AS T1 INNER JOIN car_names AS T2 ON T1.Id = T2.MakeId WHERE T2.Make = 'amc' AND T2.Model = 'hornet sportabout (sw)'
SELECT T1.Accelerate FROM cars_data AS T1 INNER JOIN car_names AS T2 ON T1.Id = T2.MakeId WHERE T2.Make = 'amc' AND T2.Model = 'hornet sportabout (sw)'
SELECT COUNT(Maker) FROM car_makers WHERE Country = (SELECT CountryId FROM countries WHERE CountryName = 'France')
SELECT COUNT(T1.Maker) FROM car_makers AS T1 INNER JOIN countries AS T2 ON T1.Country = T2.CountryId WHERE T2.CountryName = 'France'
SELECT COUNT(T1.Model) FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id WHERE T2.Country = ( SELECT CountryId FROM countries WHERE CountryName = 'USA' )
SELECT COUNT(T1.Model) FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id WHERE T2.Country = (SELECT CountryId FROM countries WHERE CountryName = 'United States')
SELECT avg(MPG) FROM cars_data WHERE Cylinders = 4
SELECT AVG(MPG) FROM cars_data WHERE Cylinders = 4
SELECT MIN(Weight) FROM cars_data WHERE Cylinders = 8 AND Year = 1974
SELECT MIN(Weight) FROM cars_data WHERE Cylinders = 8 AND Year = 1974
SELECT T1.Maker, T2.Model FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id
SELECT T1.Maker, T2.Model FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id
SELECT T1.CountryName, T1.CountryId FROM countries AS T1 INNER JOIN car_makers AS T2 ON T1.CountryId = T2.Country GROUP BY T1.CountryId
SELECT T1.CountryName, T1.CountryId FROM countries AS T1 INNER JOIN car_makers AS T2 ON T1.CountryId = T2.Country GROUP BY T1.CountryId
SELECT COUNT(T1.Id) FROM cars_data AS T1 WHERE T1.Horsepower > '150'
SELECT COUNT(T1.Id) FROM cars_data AS T1 WHERE T1.Horsepower > '150'
SELECT Year, AVG(Weight) FROM cars_data GROUP BY Year
SELECT AVG(Weight), Year FROM cars_data GROUP BY Year
SELECT T1.CountryName FROM countries AS T1 INNER JOIN car_makers AS T2 ON T1.CountryId = T2.Country INNER JOIN continents AS T3 ON T1.Continent = T3.ContId WHERE T3.Continent = 'Europe' GROUP BY T1.CountryName HAVING COUNT(T2.Maker) >= 3
SELECT T1.CountryName FROM countries AS T1 INNER JOIN car_makers AS T2 ON T1.CountryId = T2.Country WHERE T1.Continent IN ( SELECT ContId FROM continents WHERE Continent = 'Europe' ) GROUP BY T1.CountryName HAVING COUNT(T2.Maker) >= 3
SELECT MAX(T1.Horsepower), T3.Make FROM cars_data AS T1 INNER JOIN car_names AS T2 ON T1.Id = T2.MakeId INNER JOIN car_makers AS T3 ON T2.Make = T3.Maker WHERE T1.Cylinders = 3 GROUP BY T3.Make
SELECT T1.Horsepower, T2.Make FROM cars_data AS T1 INNER JOIN car_names AS T2 ON T1.Id = T2.MakeId WHERE T1.Cylinders = 3 ORDER BY T1.Horsepower DESC LIMIT 1
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.MakeId INNER JOIN cars_data AS T3 ON T2.Model = T3.Model ORDER BY T3.MPG DESC LIMIT 1
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.MakeId INNER JOIN cars_data AS T3 ON T2.Model = T3.Model ORDER BY T3.MPG DESC LIMIT 1
SELECT avg(Horsepower) FROM cars_data WHERE Year < 1980
SELECT avg(Horsepower) FROM cars_data WHERE Year < 1980
SELECT avg(T1.Edispl) FROM cars_data AS T1 INNER JOIN car_names AS T2 ON T1.Id = T2.MakeId INNER JOIN model_list AS T3 ON T2.Model = T3.Model WHERE T3.Model = 'volvo'
SELECT AVG(Edispl) FROM cars_data WHERE Make = "volvo"
SELECT Cylinders, MAX(Accelerate) FROM cars_data GROUP BY Cylinders
SELECT MAX(Accelerate) FROM cars_data GROUP BY Cylinders
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.Model = T2.Model GROUP BY T1.Model ORDER BY COUNT(T2.Make) DESC LIMIT 1
SELECT T1.Model FROM model_list AS T1 GROUP BY T1.Model ORDER BY COUNT(T1.Maker) DESC LIMIT 1
SELECT COUNT(Cylinders) FROM cars_data WHERE Cylinders > 4
SELECT COUNT(Cylinders) FROM cars_data WHERE Cylinders > 4
SELECT COUNT(T1.Id) FROM cars_data AS T1 WHERE T1.Year = 1980
SELECT COUNT(T1.Id) FROM cars_data AS T1 INNER JOIN car_names AS T2 ON T1.Id = T2.MakeId WHERE T1.Year = 1980
SELECT COUNT(T1.Model) FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id WHERE T2.FullName = 'American Motor Company'
SELECT COUNT(T1.Model) FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id WHERE T2.Maker = 'American Motor Company'
SELECT T1.FullName, T1.Id FROM car_makers AS T1 INNER JOIN model_list AS T2 ON T1.Id = T2.Maker GROUP BY T1.Id HAVING COUNT(T2.Model) > 3
SELECT T1.Maker, T1.Id FROM car_makers AS T1 INNER JOIN model_list AS T2 ON T1.Id = T2.Maker GROUP BY T1.Id HAVING COUNT(T2.Model) > 3
SELECT DISTINCT T1.Model FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id WHERE T2.FullName = 'General Motors' OR T2.FullName = 'Ford Motor Company' UNION SELECT T1.Model FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id INNER JOIN cars_data AS T3 ON T1.Model = T3.Id WHERE T2.FullName = 'General Motors' OR T2.FullName = 'Ford Motor Company' AND T3.Weight > 3500
SELECT DISTINCT T1.Model FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id WHERE T2.Maker = 'General Motors' OR T1.Maker IN ( SELECT Maker FROM model_list AS T3 INNER JOIN car_names AS T4 ON T3.Model = T4.Model INNER JOIN cars_data AS T5 ON T4.MakeId = T5.Id WHERE T5.Weight > 3500 )
SELECT Year FROM cars_data WHERE Weight BETWEEN 3000 AND 4000
SELECT DISTINCT Year FROM cars_data WHERE Weight < 4000 INTERSECT SELECT DISTINCT Year FROM cars_data WHERE Weight > 3000
SELECT Horsepower FROM cars_data ORDER BY Accelerate DESC LIMIT 1
SELECT Horsepower FROM cars_data ORDER BY Accelerate DESC LIMIT 1
SELECT T1.Cylinders FROM cars_data AS T1 INNER JOIN car_names AS T2 ON T1.Id = T2.MakeId INNER JOIN model_list AS T3 ON T2.Model = T3.Model WHERE T3.Model = 'volvo' ORDER BY T1.Accelerate LIMIT 1
SELECT T1.Cylinders FROM cars_data AS T1 INNER JOIN car_names AS T2 ON T1.Id = T2.MakeId INNER JOIN model_list AS T3 ON T2.Model = T3.Model INNER JOIN car_makers AS T4 ON T3.Maker = T4.Id WHERE T4.Maker = 'Volvo' ORDER BY T1.Accelerate LIMIT 1
SELECT COUNT(T1.Id) FROM cars_data AS T1 WHERE T1.Accelerate > ( SELECT MAX(Horsepower) FROM cars_data )
SELECT COUNT(T1.Id) FROM cars_data AS T1 WHERE T1.Accelerate > ( SELECT MAX(Horsepower) FROM cars_data )
SELECT COUNT(DISTINCT Country) FROM car_makers WHERE Country IS NOT NULL GROUP BY Country HAVING COUNT(*) > 2
SELECT COUNT(DISTINCT T1.CountryId) FROM countries AS T1 INNER JOIN car_makers AS T2 ON T1.CountryId = T2.Country GROUP BY T1.CountryId HAVING COUNT(T2.Id) > 2
SELECT COUNT(Cylinders) FROM cars_data WHERE Cylinders > 6
SELECT COUNT(Cylinders) FROM cars_data WHERE Cylinders > 6
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.Model INNER JOIN cars_data AS T3 ON T2.MakeId = T3.Id WHERE T3.Cylinders = 4 ORDER BY T3.Horsepower DESC LIMIT 1
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_names AS T2 ON T1.ModelId = T2.Model INNER JOIN cars_data AS T3 ON T2.MakeId = T3.Id WHERE T3.Cylinders = 4 ORDER BY T3.Horsepower DESC LIMIT 1
SELECT T1.MakeId, T1.Make FROM car_names AS T1 INNER JOIN cars_data AS T2 ON T1.MakeId = T2.Id WHERE T2.Horsepower > ( SELECT MIN(Horsepower) FROM cars_data ) AND T2.Cylinders <= 3
SELECT T1.MakeId, T1.Model FROM car_names AS T1 INNER JOIN cars_data AS T2 ON T1.MakeId = T2.Id WHERE T2.Horsepower < ( SELECT MIN(Horsepower) FROM cars_data ) AND T2.Cylinders < 4
SELECT MAX(MPG) FROM cars_data WHERE Cylinders = 8 OR Year < 1980
SELECT MAX(MPG) FROM cars_data WHERE Cylinders = 8 OR Year < 1980
SELECT T1.Model FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id INNER JOIN cars_data AS T3 ON T1.ModelId = T3.Id WHERE T3.Weight < 3500 AND T2.FullName != 'Ford Motor Company'
SELECT DISTINCT T1.Model FROM model_list AS T1 INNER JOIN car_makers AS T2 ON T1.Maker = T2.Id INNER JOIN cars_data AS T3 ON T1.ModelId = T3.Id WHERE T2.Maker <> 'Ford' AND T3.Weight < 3500
SELECT T1.CountryName FROM countries AS T1 WHERE T1.CountryId NOT IN ( SELECT Country FROM car_makers )
SELECT CountryName FROM countries WHERE CountryId NOT IN ( SELECT Country FROM car_makers )
SELECT T1.Id, T1.Maker FROM car_makers AS T1 INNER JOIN model_list AS T2 ON T1.Id = T2.Maker GROUP BY T1.Id HAVING COUNT(T2.Model) >= 2
SELECT T1.Id, T1.Maker FROM car_makers AS T1 INNER JOIN model_list AS T2 ON T1.Id = T2.Maker GROUP BY T1.Id HAVING COUNT(T2.Model) >= 2 AND ( SELECT COUNT(Id) FROM cars_data AS T3 WHERE T3.Id IN ( SELECT MakeId FROM car_names AS T4 WHERE T4.Make = T1.Maker ) ) > 3
SELECT T1.CountryId, T1.CountryName FROM countries AS T1 WHERE T1.CountryId IN ( SELECT T2.Country FROM car_makers AS T2 GROUP BY T2.Country HAVING COUNT(T2.Maker) > 3 ) OR T1.CountryId IN ( SELECT T3.Country FROM car_makers AS T3 INNER JOIN model_list AS T4 ON T3.Id = T4.Maker WHERE T4.Model = 'fiat' )
SELECT T1.CountryId, T1.CountryName FROM countries AS T1 INNER JOIN car_makers AS T2 ON T1.CountryId = T2.Country WHERE T2.Maker = 'fiat' OR ( SELECT COUNT(Maker) FROM car_makers WHERE Country = T1.CountryId ) > 3
SELECT Country FROM airlines WHERE Airline = 'JetBlue Airways'
SELECT Country FROM airlines WHERE Airline = 'Jetblue Airways'
SELECT Abbreviation FROM airlines WHERE Airline = 'JetBlue Airways'
SELECT Abbreviation FROM airlines WHERE Airline = 'Jetblue Airways'
SELECT Airline, Abbreviation FROM airlines WHERE Country = "USA"
SELECT Airline, Abbreviation FROM airlines WHERE Country = 'USA'
SELECT AirportCode, AirportName FROM airports WHERE City = "Anthony"
SELECT AirportCode, AirportName FROM airports WHERE City = 'Anthony'
SELECT COUNT(*) FROM airlines
SELECT COUNT(*) FROM airlines
SELECT COUNT(*) FROM airports
SELECT COUNT(*) FROM airports
SELECT COUNT(*) FROM flights
SELECT COUNT(*) FROM flights
SELECT Airline FROM airlines WHERE Abbreviation = 'UAL'
SELECT Airline FROM airlines WHERE Abbreviation = 'UAL'
SELECT COUNT(*) FROM airlines WHERE Country = 'USA'
SELECT COUNT(*) FROM airlines WHERE Country = 'USA'
SELECT City, Country FROM airports WHERE AirportName = "Alton Airport"
SELECT City, Country FROM airports WHERE AirportName = "Alton Airport"
SELECT AirportName FROM airports WHERE AirportCode = 'AKO'
SELECT AirportName FROM airports WHERE AirportCode = 'AKO'
SELECT AirportName FROM airports WHERE City = 'Aberdeen'
SELECT AirportName FROM airports WHERE City = 'Aberdeen'
SELECT COUNT(*) FROM flights WHERE SourceAirport = 'APG'
SELECT COUNT(*) FROM flights WHERE SourceAirport = 'APG'
SELECT COUNT(*) FROM flights WHERE DestAirport = 'ATO'
SELECT COUNT(*) FROM flights WHERE DestAirport = 'ATO'
SELECT COUNT(T1.FlightNo) FROM flights AS T1 INNER JOIN airports AS T2 ON T1.SourceAirport = T2.AirportCode WHERE T2.City = 'Aberdeen'
SELECT COUNT(*) FROM flights WHERE SourceAirport = 'ABR'
SELECT COUNT(*) FROM flights WHERE DestAirport IN (SELECT AirportCode FROM airports WHERE City = 'Aberdeen')
SELECT COUNT(*) FROM flights WHERE DestAirport = 'ABR'
SELECT COUNT(T1.FlightNo) FROM flights AS T1 INNER JOIN airports AS T2 ON T1.SourceAirport = T2.AirportCode INNER JOIN airports AS T3 ON T1.DestAirport = T3.AirportCode WHERE T2.City = 'Aberdeen' AND T3.City = 'Ashley'
SELECT COUNT(*) FROM flights WHERE SourceAirport = 'ABR' AND DestAirport = 'ALY'
SELECT COUNT(*) FROM flights WHERE Airline = (SELECT uid FROM airlines WHERE Airline = 'JetBlue Airways')
SELECT COUNT(*) FROM flights WHERE Airline = (SELECT uid FROM airlines WHERE Airline = 'Jetblue Airways')
SELECT COUNT(*) FROM flights WHERE Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND DestAirport = 'ASY'
SELECT COUNT(*) FROM flights WHERE Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND DestAirport = 'ASY'
SELECT COUNT(T1.FlightNo) FROM flights AS T1 INNER JOIN airlines AS T2 ON T1.Airline = T2.uid WHERE T2.Airline = 'United Airlines' AND T1.SourceAirport = 'AHD'
SELECT COUNT(*) FROM flights WHERE Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND SourceAirport = 'AHD'
SELECT COUNT(T1.FlightNo) FROM flights AS T1 INNER JOIN airlines AS T2 ON T1.Airline = T2.uid WHERE T2.Airline = 'United Airlines' AND T1.DestAirport IN (SELECT AirportCode FROM airports WHERE City = 'Aberdeen')
SELECT COUNT(*) FROM flights WHERE Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND DestAirport = 'ABR'
SELECT T1.City FROM airports AS T1 INNER JOIN flights AS T2 ON T1.AirportCode = T2.DestAirport GROUP BY T1.City ORDER BY COUNT(T2.FlightNo) DESC LIMIT 1
SELECT T1.City FROM airports AS T1 JOIN flights AS T2 ON T1.AirportCode = T2.DestAirport GROUP BY T1.City ORDER BY COUNT(T2.DestAirport) DESC LIMIT 1
SELECT T1.City FROM airports AS T1 JOIN flights AS T2 ON T1.AirportCode = T2.SourceAirport GROUP BY T1.City ORDER BY COUNT(T2.FlightNo) DESC LIMIT 1
SELECT City FROM airports GROUP BY City ORDER BY COUNT(*) DESC LIMIT 1
SELECT SourceAirport FROM flights GROUP BY SourceAirport ORDER BY COUNT(*) DESC LIMIT 1
SELECT SourceAirport FROM flights GROUP BY SourceAirport ORDER BY COUNT(*) DESC LIMIT 1
SELECT SourceAirport FROM flights GROUP BY SourceAirport ORDER BY COUNT(*) LIMIT 1
SELECT SourceAirport FROM flights GROUP BY SourceAirport ORDER BY COUNT(*) ASC LIMIT 1
SELECT Airline FROM flights GROUP BY Airline ORDER BY COUNT(*) DESC LIMIT 1
SELECT A.Airline FROM airlines AS A JOIN flights AS F ON A.uid = F.Airline GROUP BY A.Airline ORDER BY COUNT(F.FlightNo) DESC LIMIT 1
SELECT T1.Abbreviation, T1.Country FROM airlines AS T1 INNER JOIN flights AS T2 ON T1.uid = T2.Airline GROUP BY T1.uid ORDER BY COUNT(T2.FlightNo) LIMIT 1
SELECT T1.Abbreviation, T1.Country FROM airlines AS T1 INNER JOIN flights AS T2 ON T1.uid = T2.Airline GROUP BY T1.uid ORDER BY COUNT(T2.FlightNo) LIMIT 1
SELECT DISTINCT T1.Airline FROM flights AS T1 WHERE T1.SourceAirport = 'AHD'
SELECT DISTINCT T1.Airline FROM flights AS T1 WHERE T1.SourceAirport = 'AHD'
SELECT DISTINCT T1.Airline FROM flights AS T1 INNER JOIN airlines AS T2 ON T1.Airline = T2.uid WHERE T1.DestAirport = 'AHD'
SELECT DISTINCT T1.Airline FROM flights AS T1 WHERE T1.DestAirport = 'AHD'
SELECT DISTINCT T1.Airline FROM flights AS T1 WHERE T1.SourceAirport = 'APG' AND EXISTS (SELECT 1 FROM flights AS T2 WHERE T2.DestAirport = 'CVO' AND T2.Airline = T1.Airline)
SELECT DISTINCT T1.Airline FROM flights AS T1 WHERE T1.SourceAirport = 'APG' INTERSECT SELECT DISTINCT T1.Airline FROM flights AS T1 WHERE T1.SourceAirport = 'CVO'
SELECT DISTINCT T1.Airline FROM flights AS T1 WHERE T1.SourceAirport = 'CVO' AND T1.DestAirport <> 'APG'
SELECT DISTINCT T1.Airline FROM flights AS T1 WHERE T1.SourceAirport = 'CVO' AND T1.DestAirport <> 'APG'
SELECT Airline FROM flights GROUP BY Airline HAVING COUNT(*) >= 10
SELECT Airline FROM flights GROUP BY Airline HAVING COUNT(*) >= 10
SELECT A.Airline FROM airlines AS A JOIN flights AS F ON A.uid = F.Airline GROUP BY A.Airline HAVING COUNT(F.FlightNo) < 200
SELECT A.Airline FROM airlines AS A JOIN flights AS F ON A.uid = F.Airline GROUP BY A.Airline HAVING COUNT(F.FlightNo) < 200
SELECT FlightNo FROM flights WHERE Airline IN ( SELECT uid FROM airlines WHERE Airline = 'United Airlines' )
SELECT FlightNo FROM flights WHERE Airline IN ( SELECT uid FROM airlines WHERE Airline = 'United Airlines' )
SELECT FlightNo FROM flights WHERE SourceAirport = 'APG'
SELECT FlightNo FROM flights WHERE SourceAirport = 'APG'
SELECT FlightNo FROM flights WHERE DestAirport = 'APG'
SELECT FlightNo FROM flights WHERE DestAirport = 'APG'
SELECT T1.FlightNo FROM flights AS T1 INNER JOIN airports AS T2 ON T1.SourceAirport = T2.AirportCode WHERE T2.City = 'Aberdeen'
SELECT FlightNo FROM flights WHERE SourceAirport = ( SELECT AirportCode FROM airports WHERE City = 'Aberdeen' )
SELECT T1.FlightNo FROM flights AS T1 INNER JOIN airports AS T2 ON T1.DestAirport = T2.AirportCode WHERE T2.City = 'Aberdeen'
SELECT FlightNo FROM flights WHERE DestAirport = 'ABR'
SELECT COUNT(FlightNo) FROM flights WHERE DestAirport IN (SELECT AirportCode FROM airports WHERE City = 'Aberdeen' OR City = 'Abilene')
SELECT COUNT(FlightNo) FROM flights WHERE DestAirport IN ('ABR', 'ABI')
SELECT AirportName FROM airports WHERE AirportCode NOT IN (SELECT SourceAirport FROM flights) AND AirportCode NOT IN (SELECT DestAirport FROM flights)
SELECT AirportCode FROM airports WHERE AirportCode NOT IN (SELECT SourceAirport FROM flights UNION SELECT DestAirport FROM flights)
SELECT COUNT(*) FROM employee
SELECT COUNT(*) FROM employee
SELECT Name FROM employee ORDER BY Age ASC
SELECT Name FROM employee ORDER BY Age
SELECT City, COUNT(*) FROM employee GROUP BY City
SELECT City, COUNT(*) FROM employee GROUP BY City
SELECT City FROM employee WHERE Age < 30 GROUP BY City HAVING COUNT(*) > 1
SELECT City FROM employee WHERE Age < 30 GROUP BY City HAVING COUNT(*) > 1
SELECT Location, COUNT(*) FROM shop GROUP BY Location
SELECT Location, COUNT(*) FROM shop GROUP BY Location
SELECT T1.Manager_name, T1.District FROM shop AS T1 ORDER BY T1.Number_products DESC LIMIT 1
SELECT Manager_name, District FROM shop ORDER BY Number_products DESC LIMIT 1
SELECT MIN(Number_products), MAX(Number_products) FROM shop
SELECT MIN(Number_products), MAX(Number_products) FROM shop
SELECT Name, Location, District FROM shop ORDER BY Number_products DESC
SELECT Name, Location, District FROM shop ORDER BY Number_products DESC
SELECT Name FROM shop WHERE Number_products > (SELECT AVG(Number_products) FROM shop)
SELECT Name FROM shop WHERE Number_products > ( SELECT AVG(Number_products) FROM shop )
SELECT T1.Name FROM employee AS T1 INNER JOIN evaluation AS T2 ON T1.Employee_ID = T2.Employee_ID GROUP BY T1.Employee_ID ORDER BY COUNT(T2.Employee_ID) DESC LIMIT 1
SELECT T1.Name FROM employee AS T1 INNER JOIN evaluation AS T2 ON T1.Employee_ID = T2.Employee_ID GROUP BY T1.Employee_ID ORDER BY COUNT(T2.Employee_ID) DESC LIMIT 1
SELECT T1.Name FROM employee AS T1 INNER JOIN evaluation AS T2 ON T1.Employee_ID = T2.Employee_ID ORDER BY T2.Bonus DESC LIMIT 1
SELECT T1.Name FROM employee AS T1 INNER JOIN evaluation AS T2 ON T1.Employee_ID = T2.Employee_ID ORDER BY T2.Bonus DESC LIMIT 1
SELECT Name FROM employee WHERE Employee_ID NOT IN (SELECT Employee_ID FROM evaluation)
SELECT Name FROM employee WHERE Employee_ID NOT IN (SELECT Employee_ID FROM evaluation)
SELECT T1.Name FROM shop AS T1 INNER JOIN hiring AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Shop_ID ORDER BY COUNT(T2.Employee_ID) DESC LIMIT 1
SELECT T1.Name FROM shop AS T1 INNER JOIN hiring AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Shop_ID ORDER BY COUNT(T2.Employee_ID) DESC LIMIT 1
SELECT Name FROM shop WHERE Shop_ID NOT IN (SELECT Shop_ID FROM hiring)
SELECT Name FROM shop WHERE Shop_ID NOT IN ( SELECT Shop_ID FROM hiring )
SELECT T1.Name, COUNT(T2.Employee_ID) FROM shop AS T1 INNER JOIN hiring AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Name
SELECT T1.Name, COUNT(T2.Employee_ID) FROM shop AS T1 INNER JOIN hiring AS T2 ON T1.Shop_ID = T2.Shop_ID GROUP BY T1.Name
SELECT SUM(Bonus) FROM evaluation
SELECT SUM(Bonus) FROM evaluation
SELECT * FROM hiring
SELECT * FROM hiring
SELECT DISTINCT District FROM shop WHERE Number_products < 3000 INTERSECT SELECT DISTINCT District FROM shop WHERE Number_products > 10000
SELECT DISTINCT District FROM shop WHERE Number_products < 3000 INTERSECT SELECT DISTINCT District FROM shop WHERE Number_products > 10000
SELECT COUNT(DISTINCT Location) FROM shop
SELECT COUNT(DISTINCT Location) FROM shop
SELECT COUNT(*) FROM Documents
SELECT COUNT(*) FROM Documents
SELECT Document_ID, Document_Name, Document_Description FROM Documents
SELECT Document_ID, Document_Name, Document_Description FROM Documents
SELECT T1.Document_Name, T1.Template_ID FROM Documents AS T1 WHERE T1.Document_Description LIKE '%w%'
SELECT T1.Document_Name, T1.Template_ID FROM Documents AS T1 WHERE T1.Document_Description LIKE '%w%'
SELECT T1.Document_ID, T1.Template_ID, T1.Document_Description FROM Documents AS T1 WHERE T1.Document_Name = 'Robbin CV'
SELECT Document_ID, Template_ID, Document_Description FROM Documents WHERE Document_Name = 'Robbin CV'
SELECT COUNT(DISTINCT Template_ID) FROM Documents
SELECT COUNT(DISTINCT Template_ID) FROM Documents WHERE Template_ID IS NOT NULL
SELECT COUNT(T1.Document_ID) FROM Documents AS T1 INNER JOIN Templates AS T2 ON T1.Template_ID = T2.Template_ID INNER JOIN Ref_Template_Types AS T3 ON T2.Template_Type_Code = T3.Template_Type_Code WHERE T3.Template_Type_Code = 'PPT'
SELECT COUNT(T1.Document_ID) FROM Documents AS T1 INNER JOIN Templates AS T2 ON T1.Template_ID = T2.Template_ID INNER JOIN Ref_Template_Types AS T3 ON T2.Template_Type_Code = T3.Template_Type_Code WHERE T3.Template_Type_Description = 'PPT'
SELECT T.Template_ID, COUNT(D.Document_ID) AS NumberOfDocuments FROM Templates AS T JOIN Documents AS D ON T.Template_ID = D.Template_ID GROUP BY T.Template_ID
SELECT T1.Template_ID, COUNT(T1.Template_ID) AS Count FROM Documents AS T1 GROUP BY T1.Template_ID
SELECT T1.Template_ID, T1.Template_Type_Code FROM Templates AS T1 INNER JOIN Documents AS T2 ON T1.Template_ID = T2.Template_ID GROUP BY T1.Template_ID ORDER BY COUNT(T2.Document_ID) DESC LIMIT 1
SELECT T1.Template_ID, T1.Template_Type_Code FROM Templates AS T1 JOIN Documents AS T2 ON T1.Template_ID = T2.Template_ID GROUP BY T1.Template_ID ORDER BY COUNT(T2.Document_ID) DESC LIMIT 1
SELECT Template_ID FROM Templates WHERE Template_ID IN (SELECT Template_ID FROM Documents GROUP BY Template_ID HAVING COUNT(*) > 1)
SELECT Template_ID FROM Documents GROUP BY Template_ID HAVING COUNT(*) > 1
SELECT Template_ID FROM Templates WHERE Template_ID NOT IN (SELECT Template_ID FROM Documents)
SELECT Template_ID FROM Templates WHERE Template_ID NOT IN (SELECT Template_ID FROM Documents WHERE Template_ID IS NOT NULL)
SELECT COUNT(*) FROM Templates
SELECT COUNT(*) FROM Templates
SELECT Template_ID, Version_Number, Template_Type_Code FROM Templates
SELECT Template_ID, Version_Number, Template_Type_Code FROM Templates
SELECT DISTINCT Template_Type_Code FROM Templates
SELECT DISTINCT Template_Type_Code FROM Ref_Template_Types
SELECT Template_ID FROM Templates WHERE Template_Type_Code IN ('PP', 'PPT')
SELECT Template_ID FROM Templates WHERE Template_Type_Code IN ('PP', 'PPT')
SELECT COUNT(*) FROM Templates WHERE Template_Type_Code = 'CV'
SELECT COUNT(*) FROM Templates WHERE Template_Type_Code = (SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'CV')
SELECT Version_Number, Template_Type_Code FROM Templates WHERE Version_Number > 5
SELECT Version_Number, Template_Type_Code FROM Templates WHERE Version_Number > 5
SELECT T1.Template_Type_Code, COUNT(T2.Template_ID) AS NumberOfTemplates FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code GROUP BY T1.Template_Type_Code
SELECT T1.Template_Type_Code, COUNT(T2.Template_ID) AS Template_Count FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code GROUP BY T1.Template_Type_Code
SELECT T1.Template_Type_Code FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code GROUP BY T1.Template_Type_Code ORDER BY COUNT(T2.Template_ID) DESC LIMIT 1
SELECT Template_Type_Code FROM Templates GROUP BY Template_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT Template_Type_Code FROM Templates GROUP BY Template_Type_Code HAVING COUNT(Template_ID) < 3
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Code NOT IN ( SELECT Template_Type_Code FROM Templates GROUP BY Template_Type_Code HAVING COUNT(*) >= 3 )
SELECT MIN(Version_Number), Template_Type_Code FROM Templates
SELECT T1.Version_Number, T1.Template_Type_Code FROM Templates AS T1 ORDER BY T1.Version_Number LIMIT 1
SELECT T1.Template_Type_Code FROM Templates AS T1 INNER JOIN Documents AS T2 ON T1.Template_ID = T2.Template_ID WHERE T2.Document_Name = 'Data base'
SELECT T1.Template_Type_Code FROM Templates AS T1 INNER JOIN Documents AS T2 ON T1.Template_ID = T2.Template_ID WHERE T2.Document_Name = 'Data base'
SELECT T1.Document_Name FROM Documents AS T1 INNER JOIN Templates AS T2 ON T1.Template_ID = T2.Template_ID INNER JOIN Ref_Template_Types AS T3 ON T2.Template_Type_Code = T3.Template_Type_Code WHERE T3.Template_Type_Code = 'BK'
SELECT T1.Document_Name FROM Documents AS T1 INNER JOIN Templates AS T2 ON T1.Template_ID = T2.Template_ID WHERE T2.Template_Type_Code = 'BK'
SELECT T1.Template_Type_Code, COUNT(T2.Document_ID) AS NumberOfDocuments FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T3 ON T1.Template_Type_Code = T3.Template_Type_Code INNER JOIN Documents AS T2 ON T3.Template_ID = T2.Template_ID GROUP BY T1.Template_Type_Code
SELECT T1.Template_Type_Code, COUNT(T2.Document_ID) AS NumberOfDocuments FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T3 ON T1.Template_Type_Code = T3.Template_Type_Code INNER JOIN Documents AS T2 ON T3.Template_ID = T2.Template_ID GROUP BY T1.Template_Type_Code
SELECT T1.Template_Type_Code FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code INNER JOIN Documents AS T3 ON T2.Template_ID = T3.Template_ID GROUP BY T1.Template_Type_Code ORDER BY COUNT(T3.Document_ID) DESC LIMIT 1
SELECT T1.Template_Type_Code FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code INNER JOIN Documents AS T3 ON T2.Template_ID = T3.Template_ID GROUP BY T1.Template_Type_Code ORDER BY COUNT(T3.Document_ID) DESC LIMIT 1
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Code NOT IN (SELECT Template_Type_Code FROM Templates WHERE Template_ID IN (SELECT Template_ID FROM Documents))
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Code NOT IN (SELECT Template_Type_Code FROM Templates WHERE Template_ID IN (SELECT Template_ID FROM Documents))
SELECT Template_Type_Code, Template_Type_Description FROM Ref_Template_Types
SELECT Template_Type_Code, Template_Type_Description FROM Ref_Template_Types
SELECT Template_Type_Description FROM Ref_Template_Types WHERE Template_Type_Code = 'AD'
SELECT Template_Type_Description FROM Ref_Template_Types WHERE Template_Type_Code = 'AD'
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = "Book"
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'Book'
SELECT DISTINCT T1.Template_Type_Description FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code INNER JOIN Documents AS T3 ON T2.Template_ID = T3.Template_ID
SELECT DISTINCT T1.Template_Type_Description FROM Ref_Template_Types AS T1 INNER JOIN Templates AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code INNER JOIN Documents AS T3 ON T2.Template_ID = T3.Template_ID
SELECT T1.Template_ID FROM Templates AS T1 INNER JOIN Ref_Template_Types AS T2 ON T1.Template_Type_Code = T2.Template_Type_Code WHERE T2.Template_Type_Description = 'Presentation'
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'Presentation'
SELECT COUNT(*) FROM Paragraphs
SELECT COUNT(*) FROM Paragraphs
SELECT COUNT(T1.Paragraph_ID) FROM Paragraphs AS T1 INNER JOIN Documents AS T2 ON T1.Document_ID = T2.Document_ID WHERE T2.Document_Name = 'Summer Show'
SELECT COUNT(T1.Paragraph_ID) FROM Paragraphs AS T1 INNER JOIN Documents AS T2 ON T1.Document_ID = T2.Document_ID WHERE T2.Document_Name = 'Summer Show'
SELECT Paragraph_Text FROM Paragraphs WHERE Paragraph_Text = 'Korea '
SELECT T1.Paragraph_Text FROM Paragraphs AS T1 WHERE T1.Paragraph_Text LIKE '%Korea %'
SELECT T1.Paragraph_ID, T1.Paragraph_Text FROM Paragraphs AS T1 INNER JOIN Documents AS T2 ON T1.Document_ID = T2.Document_ID WHERE T2.Document_Name = 'Welcome to NY'
SELECT T1.Paragraph_ID, T1.Paragraph_Text FROM Paragraphs AS T1 INNER JOIN Documents AS T2 ON T1.Document_ID = T2.Document_ID WHERE T2.Document_Name = 'Welcome to NY'
SELECT T1.Paragraph_Text FROM Paragraphs AS T1 INNER JOIN Documents AS T2 ON T1.Document_ID = T2.Document_ID WHERE T2.Document_Name = 'Customer reviews'
SELECT T1.Paragraph_Text FROM Paragraphs AS T1 INNER JOIN Documents AS T2 ON T1.Document_ID = T2.Document_ID WHERE T2.Document_Name = 'Customer reviews'
SELECT T1.Document_ID, COUNT(T2.Paragraph_ID) AS Number_of_Paragraphs FROM Documents AS T1 INNER JOIN Paragraphs AS T2 ON T1.Document_ID = T2.Document_ID GROUP BY T1.Document_ID ORDER BY T1.Document_ID
SELECT T1.Document_ID, COUNT(T2.Paragraph_ID) AS Number_Of_Paragraphs FROM Documents AS T1 INNER JOIN Paragraphs AS T2 ON T1.Document_ID = T2.Document_ID GROUP BY T1.Document_ID ORDER BY T1.Document_ID
SELECT D.Document_ID, D.Document_Name, COUNT(P.Paragraph_ID) AS Number_of_Paragraphs FROM Documents AS D JOIN Paragraphs AS P ON D.Document_ID = P.Document_ID GROUP BY D.Document_ID, D.Document_Name
SELECT D.Document_ID, D.Document_Name, COUNT(P.Paragraph_ID) AS Number_of_Paragraphs FROM Documents AS D JOIN Paragraphs AS P ON D.Document_ID = P.Document_ID GROUP BY D.Document_ID, D.Document_Name
SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(*) >= 2
SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(*) >= 2
SELECT T1.Document_ID, T1.Document_Name FROM Documents AS T1 INNER JOIN Paragraphs AS T2 ON T1.Document_ID = T2.Document_ID GROUP BY T1.Document_ID ORDER BY COUNT(T2.Paragraph_ID) DESC LIMIT 1
SELECT T1.Document_ID, T1.Document_Name FROM Documents AS T1 INNER JOIN Paragraphs AS T2 ON T1.Document_ID = T2.Document_ID GROUP BY T1.Document_ID ORDER BY COUNT(T2.Paragraph_ID) DESC LIMIT 1
SELECT Document_ID FROM Documents GROUP BY Document_ID JOIN ( SELECT Document_ID, COUNT(*) AS ParagraphCount FROM Paragraphs GROUP BY Document_ID ) AS ParagraphCounts ON Documents.Document_ID = ParagraphCounts.Document_ID ORDER BY ParagraphCount LIMIT 1
SELECT Document_ID FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Document_ID ORDER BY COUNT(Paragraph_ID) LIMIT 1
SELECT Document_ID FROM Documents WHERE Document_ID IN ( SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(*) BETWEEN 1 AND 2 )
SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(*) BETWEEN 1 AND 2
SELECT DISTINCT T1.Document_ID FROM Paragraphs AS T1 INNER JOIN Paragraphs AS T2 ON T1.Document_ID = T2.Document_ID WHERE T1.Paragraph_Text = 'Brazil' AND T2.Paragraph_Text = 'Ireland'
SELECT DISTINCT T1.Document_ID FROM Documents AS T1 INNER JOIN Paragraphs AS T2 ON T1.Document_ID = T2.Document_ID WHERE T2.Paragraph_Text = 'Brazil' INTERSECT SELECT DISTINCT T1.Document_ID FROM Documents AS T1 INNER JOIN Paragraphs AS T2 ON T1.Document_ID = T2.Document_ID WHERE T2.Paragraph_Text = 'Ireland'
SELECT COUNT(*) FROM teacher
SELECT COUNT(*) FROM teacher
SELECT Name FROM teacher ORDER BY Age ASC
SELECT Name FROM teacher ORDER BY Age ASC
SELECT Age, Hometown FROM teacher
SELECT Age, Hometown FROM teacher
SELECT Name FROM teacher WHERE Hometown != 'Little Lever Urban District'
SELECT Name FROM teacher WHERE Hometown != 'Little Lever Urban District'
SELECT Name FROM teacher WHERE Age = '32' OR Age = '33'
SELECT Name FROM teacher WHERE Age = '32' OR Age = '33'
SELECT Hometown FROM teacher ORDER BY Age ASC LIMIT 1
SELECT Hometown FROM teacher ORDER BY Age ASC LIMIT 1
SELECT Hometown, COUNT(Teacher_ID) FROM teacher GROUP BY Hometown
SELECT Hometown, COUNT(Teacher_ID) FROM teacher GROUP BY Hometown
SELECT Hometown FROM teacher GROUP BY Hometown ORDER BY COUNT(*) DESC LIMIT 1
SELECT Hometown FROM teacher GROUP BY Hometown ORDER BY COUNT(*) DESC LIMIT 1
SELECT Hometown FROM teacher GROUP BY Hometown HAVING COUNT(*) >= 2
SELECT Hometown FROM teacher GROUP BY Hometown HAVING COUNT(*) >= 2
SELECT T.Name, C.Course FROM teacher AS T JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID JOIN course AS C ON CA.Course_ID = C.Course_ID
SELECT T.Name, C.Course FROM teacher AS T JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID JOIN course AS C ON CA.Course_ID = C.Course_ID
SELECT T.Name, C.Course FROM teacher AS T JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID JOIN course AS C ON CA.Course_ID = C.Course_ID ORDER BY T.Name
SELECT T.Name, C.Course FROM teacher AS T JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID JOIN course AS C ON CA.Course_ID = C.Course_ID ORDER BY T.Name
SELECT T.Name FROM teacher AS T JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID JOIN course AS C ON CA.Course_ID = C.Course_ID WHERE C.Course = 'Math'
SELECT T.Name FROM teacher AS T JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID JOIN course AS C ON CA.Course_ID = C.Course_ID WHERE C.Course = 'Math'
SELECT T.Name, COUNT(CA.Course_ID) FROM teacher AS T INNER JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID GROUP BY T.Name
SELECT T.Name, COUNT(CA.Course_ID) AS num_courses FROM teacher AS T JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID GROUP BY T.Name
SELECT T.Name FROM teacher AS T JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID GROUP BY T.Teacher_ID HAVING COUNT(CA.Course_ID) >= 2
SELECT T.Name FROM teacher AS T JOIN course_arrange AS CA ON T.Teacher_ID = CA.Teacher_ID GROUP BY T.Teacher_ID HAVING COUNT(CA.Course_ID) >= 2
SELECT Name FROM teacher WHERE Teacher_ID NOT IN (SELECT Teacher_ID FROM course_arrange)
SELECT T.Name FROM teacher AS T WHERE T.Teacher_ID NOT IN (SELECT Teacher_ID FROM course_arrange)
SELECT COUNT(ID) FROM visitor WHERE Age < 30
SELECT Name FROM visitor WHERE Level_of_membership > 4 ORDER BY Level_of_membership DESC
SELECT AVG(Age) FROM visitor WHERE Level_of_membership <= 4
SELECT Name, Level_of_membership FROM visitor WHERE Level_of_membership > 4 ORDER BY Age DESC
SELECT Museum_ID, Name FROM museum ORDER BY Num_of_Staff DESC LIMIT 1
SELECT AVG(Num_of_Staff) FROM museum WHERE Open_Year < '2009'
SELECT Open_Year, Num_of_Staff FROM museum WHERE Name = 'Plaza Museum'
SELECT Name FROM museum WHERE Num_of_Staff > (SELECT MIN(Num_of_Staff) FROM museum WHERE Open_Year > '2010')
SELECT T1.ID, T1.Name, T1.Age FROM visitor AS T1 INNER JOIN visit AS T2 ON T1.ID = T2.visitor_ID GROUP BY T1.ID HAVING COUNT(T2.Museum_ID) > 1
SELECT T1.ID, T1.Name, T1.Level_of_membership FROM visitor AS T1 INNER JOIN visit AS T2 ON T1.ID = T2.visitor_ID ORDER BY T2.Total_spent DESC LIMIT 1
SELECT T1.Museum_ID, T1.Name FROM museum AS T1 INNER JOIN visit AS T2 ON T1.Museum_ID = T2.Museum_ID GROUP BY T1.Museum_ID ORDER BY SUM(T2.Num_of_Ticket) DESC LIMIT 1
SELECT T1.Name FROM museum AS T1 WHERE T1.Museum_ID NOT IN ( SELECT Museum_ID FROM visit )
SELECT T1.Name, T1.Age FROM visitor AS T1 INNER JOIN visit AS T2 ON T1.ID = T2.visitor_ID ORDER BY T2.Num_of_Ticket DESC LIMIT 1
SELECT AVG(Num_of_Ticket), MAX(Num_of_Ticket) FROM visit
SELECT SUM(T1.Num_of_Ticket * T2.Total_spent) FROM visit AS T1 INNER JOIN visitor AS T2 ON T1.visitor_ID = T2.ID WHERE T2.Level_of_membership = 1
SELECT DISTINCT T1.Name FROM visitor AS T1 INNER JOIN visit AS T2 ON T1.ID = T2.visitor_ID INNER JOIN museum AS T3 ON T2.Museum_ID = T3.Museum_ID WHERE T3.Open_Year < '2009' INTERSECT SELECT DISTINCT T1.Name FROM visitor AS T1 INNER JOIN visit AS T2 ON T1.ID = T2.visitor_ID INNER JOIN museum AS T3 ON T2.Museum_ID = T3.Museum_ID WHERE T3.Open_Year > '2011'
SELECT COUNT(DISTINCT T1.visitor_ID) FROM visit AS T1 INNER JOIN museum AS T2 ON T1.Museum_ID = T2.Museum_ID WHERE T2.Open_Year <= '2010'
SELECT COUNT(*) FROM museum WHERE Open_Year > '2013' OR Open_Year < '2008'
SELECT COUNT(*) FROM players
SELECT COUNT(*) FROM players
SELECT COUNT(*) FROM matches
SELECT COUNT(*) FROM matches
SELECT first_name, birth_date FROM players WHERE country_code = 'USA'
SELECT first_name, birth_date FROM players WHERE country_code = 'USA'
SELECT AVG(loser_age) AS average_loser_age, AVG(winner_age) AS average_winner_age FROM matches
SELECT AVG(loser_age) AS average_loser_age, AVG(winner_age) AS average_winner_age FROM matches
SELECT AVG(winner_rank) FROM matches
SELECT AVG(winner_rank) FROM matches
SELECT MAX(loser_rank) FROM matches
SELECT MIN(loser_rank) FROM matches
SELECT COUNT(DISTINCT country_code) FROM players
SELECT COUNT(DISTINCT country_code) FROM players
SELECT COUNT(DISTINCT loser_name) FROM matches
SELECT COUNT(DISTINCT loser_name) FROM matches
SELECT tourney_name FROM matches GROUP BY tourney_name HAVING COUNT(*) > 10
SELECT tourney_name FROM matches GROUP BY tourney_name HAVING COUNT(*) > 10
SELECT DISTINCT T1.first_name, T1.last_name FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id WHERE T2.year = 2013 INTERSECT SELECT DISTINCT T1.first_name, T1.last_name FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id WHERE T2.year = 2016
SELECT DISTINCT T1.first_name, T1.last_name FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id WHERE T2.year = 2013 INTERSECT SELECT DISTINCT T1.first_name, T1.last_name FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id WHERE T2.year = 2016
SELECT COUNT(match_num) FROM matches WHERE year = 2013 OR year = 2016
SELECT COUNT(*) FROM matches WHERE year = 2013 OR year = 2016
SELECT T1.country_code, T1.first_name FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id WHERE T2.tourney_name = 'WTA Championships' INTERSECT SELECT T1.country_code, T1.first_name FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id WHERE T2.tourney_name = 'Australian Open'
SELECT DISTINCT P.first_name, P.country_code FROM players AS P JOIN matches AS M ON P.player_id = M.winner_id WHERE M.tourney_name = 'WTA Championships' INTERSECT SELECT DISTINCT P.first_name, P.country_code FROM players AS P JOIN matches AS M ON P.player_id = M.winner_id WHERE M.tourney_name = 'Australian Open'
SELECT first_name, country_code FROM players ORDER BY birth_date ASC LIMIT 1
SELECT first_name, country_code FROM players ORDER BY birth_date ASC LIMIT 1
SELECT first_name, last_name FROM players ORDER BY birth_date
SELECT first_name || ' ' || last_name FROM players ORDER BY birth_date
SELECT first_name, last_name FROM players WHERE hand = 'L' ORDER BY birth_date
SELECT first_name, last_name FROM players WHERE hand = 'Left' ORDER BY birth_date
SELECT T1.first_name, T1.country_code FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id ORDER BY T2.tours DESC LIMIT 1
SELECT T1.first_name, T1.country_code FROM players AS T1 JOIN rankings AS T2 ON T1.player_id = T2.player_id ORDER BY T2.tours DESC LIMIT 1
SELECT year FROM matches GROUP BY year ORDER BY COUNT(*) DESC LIMIT 1
SELECT year FROM matches GROUP BY year ORDER BY COUNT(*) DESC LIMIT 1
SELECT T1.winner_name, T1.winner_rank_points FROM matches AS T1 GROUP BY T1.winner_id ORDER BY COUNT(T1.winner_id) DESC LIMIT 1
SELECT T1.winner_name, T2.winner_rank_points FROM matches AS T1 INNER JOIN players AS T2 ON T1.winner_id = T2.player_id GROUP BY T1.winner_name ORDER BY COUNT(T1.winner_id) DESC LIMIT 1
SELECT winner_name FROM matches WHERE tourney_name = 'Australian Open' ORDER BY winner_rank_points DESC LIMIT 1
SELECT winner_name FROM matches WHERE tourney_name = 'Australian Open' ORDER BY winner_rank_points DESC LIMIT 1
SELECT T1.loser_name, T1.winner_name FROM matches AS T1 ORDER BY T1.minutes DESC LIMIT 1
SELECT T1.winner_name, T1.loser_name FROM matches AS T1 ORDER BY T1.minutes DESC LIMIT 1
SELECT p.first_name, AVG(r.ranking) AS average_ranking FROM players AS p JOIN rankings AS r ON p.player_id = r.player_id GROUP BY p.first_name
SELECT P.first_name, AVG(R.ranking) AS average_ranking FROM players AS P JOIN rankings AS R ON P.player_id = R.player_id GROUP BY P.first_name
SELECT T1.first_name, SUM(T2.ranking_points) AS total_ranking_points FROM players AS T1 INNER JOIN rankings AS T2 ON T1.player_id = T2.player_id GROUP BY T1.first_name
SELECT p.first_name, SUM(r.ranking_points) AS total_ranking_points FROM players AS p JOIN rankings AS r ON p.player_id = r.player_id GROUP BY p.first_name
SELECT country_code, COUNT(player_id) FROM players GROUP BY country_code
SELECT country_code, COUNT(*) FROM players GROUP BY country_code
SELECT country_code FROM players GROUP BY country_code ORDER BY COUNT(*) DESC LIMIT 1
SELECT country_code FROM players GROUP BY country_code ORDER BY COUNT(*) DESC LIMIT 1
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(*) > 50
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(*) > 50
SELECT ranking_date, SUM(tours) AS total_tours FROM rankings GROUP BY ranking_date
SELECT ranking_date, SUM(tours) AS total_tours FROM rankings GROUP BY ranking_date
SELECT year, COUNT(*) FROM matches GROUP BY year
SELECT year, COUNT(*) FROM matches GROUP BY year
SELECT T1.first_name, T1.last_name, T2.ranking FROM players AS T1 INNER JOIN rankings AS T2 ON T1.player_id = T2.player_id WHERE T1.player_id IN ( SELECT winner_id FROM matches ) ORDER BY T1.birth_date DESC LIMIT 3
SELECT T1.first_name, T1.last_name, T2.winner_rank FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id ORDER BY T2.winner_age LIMIT 3
SELECT COUNT(DISTINCT winner_id) FROM matches WHERE tourney_name = 'WTA Championships' AND winner_hand = 'L'
SELECT COUNT(T1.player_id) FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id WHERE T1.hand = 'Left' AND T2.tourney_name = 'WTA Championships'
SELECT T1.first_name, T1.country_code, T1.birth_date FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id ORDER BY T2.winner_rank_points DESC LIMIT 1
SELECT T1.first_name, T1.country_code, T1.birth_date FROM players AS T1 INNER JOIN matches AS T2 ON T1.player_id = T2.winner_id ORDER BY T2.winner_rank_points DESC LIMIT 1
SELECT hand, COUNT(*) FROM players GROUP BY hand
SELECT hand, COUNT(*) FROM players GROUP BY hand
SELECT COUNT(*) FROM ship WHERE disposition_of_ship = 'Captured'
SELECT name, tonnage FROM ship ORDER BY name DESC
SELECT name, date, result FROM battle
SELECT MAX(killed + injured), MIN(killed + injured) FROM death
SELECT AVG(injured) FROM death
SELECT SUM(T1.killed), SUM(T1.injured) FROM death AS T1 INNER JOIN ship AS T2 ON T1.caused_by_ship_id = T2.id WHERE T2.tonnage = 't'
SELECT name, result FROM battle WHERE bulgarian_commander != 'Boril'
SELECT DISTINCT T1.id, T1.name FROM battle AS T1 INNER JOIN ship AS T2 ON T1.id = T2.lost_in_battle WHERE T2.ship_type = 'Brig'
SELECT T1.id, T1.name FROM battle AS T1 INNER JOIN death AS T2 ON T1.id = T2.caused_by_ship_id WHERE T2.killed > 10 GROUP BY T1.id
SELECT T1.id, T1.name FROM ship AS T1 INNER JOIN death AS T2 ON T1.id = T2.caused_by_ship_id GROUP BY T1.id ORDER BY SUM(T2.injured) DESC LIMIT 1
SELECT DISTINCT name FROM battle WHERE bulgarian_commander = 'Kaloyan' AND latin_commander = 'Baldwin I'
SELECT COUNT(DISTINCT result) FROM battle
SELECT COUNT(T1.id) FROM battle AS T1 WHERE T1.id NOT IN ( SELECT T2.lost_in_battle FROM ship AS T2 WHERE T2.tonnage = '225' )
SELECT T1.name, T1.date FROM battle AS T1 INNER JOIN ship AS T2 ON T1.id = T2.lost_in_battle WHERE T2.name = 'Lettice' OR T2.name = 'HMS Atalanta'
SELECT T1.name, T1.result, T1.bulgarian_commander FROM battle AS T1 INNER JOIN ship AS T2 ON T1.id = T2.lost_in_battle WHERE T2.location = 'English Channel' AND T2.lost_in_battle IS NULL
SELECT note FROM death WHERE note LIKE '%East%'
SELECT line_1, line_2 FROM Addresses
SELECT line_1, line_2 FROM Addresses
SELECT COUNT(*) FROM Courses
SELECT COUNT(*) FROM Courses
SELECT course_description FROM Courses WHERE course_name = 'Math'
SELECT course_description FROM Courses WHERE course_name LIKE '%Math%'
SELECT zip_postcode FROM Addresses WHERE city = 'Port Chelsea'
SELECT zip_postcode FROM Addresses WHERE city = 'Port Chelsea'
SELECT T1.department_name, T1.department_id FROM Departments AS T1 INNER JOIN Degree_Programs AS T2 ON T1.department_id = T2.department_id GROUP BY T1.department_id ORDER BY COUNT(T2.degree_program_id) DESC LIMIT 1
SELECT T1.department_name, T1.department_id FROM Departments AS T1 INNER JOIN Degree_Programs AS T2 ON T1.department_id = T2.department_id GROUP BY T1.department_id ORDER BY COUNT(T2.degree_program_id) DESC LIMIT 1
SELECT COUNT(DISTINCT department_id) FROM Degree_Programs
SELECT COUNT(DISTINCT department_name) FROM Departments
SELECT COUNT(DISTINCT degree_summary_name) FROM Degree_Programs
SELECT COUNT(DISTINCT degree_summary_name) FROM Degree_Programs
SELECT COUNT(degree_program_id) FROM Degree_Programs WHERE department_id IN (SELECT department_id FROM Departments WHERE department_name = 'Engineering')
SELECT COUNT(degree_program_id) FROM Degree_Programs WHERE department_id IN (SELECT department_id FROM Departments WHERE department_name = 'Engineering')
SELECT section_name, section_description FROM Sections
SELECT section_name, section_description FROM Sections
SELECT T1.course_name, T1.course_id FROM Courses AS T1 INNER JOIN Sections AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_id HAVING COUNT(T2.section_id) <= 2
SELECT C.course_name, C.course_id FROM Courses AS C JOIN Sections AS S ON C.course_id = S.course_id GROUP BY C.course_id HAVING COUNT(S.section_id) < 2
SELECT section_name FROM Sections ORDER BY section_name DESC
SELECT section_name FROM Sections ORDER BY section_name DESC
SELECT T1.semester_name, T1.semester_id FROM Semesters AS T1 INNER JOIN Student_Enrolment AS T2 ON T1.semester_id = T2.semester_id GROUP BY T1.semester_id ORDER BY COUNT(T2.student_id) DESC LIMIT 1
SELECT T1.semester_name, T1.semester_id FROM Semesters AS T1 INNER JOIN Student_Enrolment AS T2 ON T1.semester_id = T2.semester_id GROUP BY T1.semester_id ORDER BY COUNT(T2.student_id) DESC LIMIT 1
SELECT department_description FROM Departments WHERE department_name LIKE '%the computer%'
SELECT department_description FROM Departments WHERE department_name LIKE '%computer%'
SELECT S.first_name, S.middle_name, S.last_name, S.student_id FROM Students AS S JOIN Student_Enrolment AS SE ON S.student_id = SE.student_id GROUP BY S.student_id HAVING COUNT(DISTINCT SE.degree_program_id) = 2
SELECT S.first_name, S.middle_name, S.last_name, S.student_id FROM Students AS S JOIN Student_Enrolment AS SE ON S.student_id = SE.student_id GROUP BY S.student_id HAVING COUNT(DISTINCT SE.degree_program_id) = 2
SELECT T1.first_name, T1.middle_name, T1.last_name FROM Students AS T1 INNER JOIN Student_Enrolment AS T2 ON T1.student_id = T2.student_id INNER JOIN Degree_Programs AS T3 ON T2.degree_program_id = T3.degree_program_id WHERE T3.degree_summary_name LIKE '%Bachelor%'
SELECT T1.first_name, T1.middle_name, T1.last_name FROM Students AS T1 INNER JOIN Student_Enrolment AS T2 ON T1.student_id = T2.student_id INNER JOIN Degree_Programs AS T3 ON T2.degree_program_id = T3.degree_program_id WHERE T3.degree_summary_name = 'Bachelors'
SELECT T1.degree_summary_name FROM Degree_Programs AS T1 INNER JOIN Student_Enrolment AS T2 ON T1.degree_program_id = T2.degree_program_id GROUP BY T1.degree_summary_name ORDER BY COUNT(T2.student_id) DESC LIMIT 1
SELECT T1.degree_summary_name FROM Degree_Programs AS T1 INNER JOIN Student_Enrolment AS T2 ON T1.degree_program_id = T2.degree_program_id GROUP BY T1.degree_summary_name ORDER BY COUNT(T2.student_id) DESC LIMIT 1
SELECT T1.degree_program_id, T1.degree_summary_name FROM Degree_Programs AS T1 INNER JOIN Student_Enrolment AS T2 ON T1.degree_program_id = T2.degree_program_id GROUP BY T1.degree_program_id ORDER BY COUNT(T2.student_id) DESC LIMIT 1
SELECT Degree_Programs.degree_program_id, Degree_Programs.degree_summary_name FROM Degree_Programs JOIN Student_Enrolment ON Degree_Programs.degree_program_id = Student_Enrolment.degree_program_id GROUP BY Degree_Programs.degree_program_id ORDER BY COUNT(Student_Enrolment.student_enrolment_id) DESC LIMIT 1
SELECT S.student_id, S.first_name, S.middle_name, S.last_name, COUNT(SE.student_enrolment_id) AS num_enrollments FROM Students AS S JOIN Student_Enrolment AS SE ON S.student_id = SE.student_id GROUP BY S.student_id ORDER BY num_enrollments DESC LIMIT 1
SELECT S.first_name, S.middle_name, S.last_name, S.student_id, COUNT(SE.student_enrolment_id) AS num_enrollments FROM Students AS S JOIN Student_Enrolment AS SE ON S.student_id = SE.student_id GROUP BY S.student_id ORDER BY num_enrollments DESC LIMIT 1
SELECT T1.semester_name FROM Semesters AS T1 WHERE T1.semester_id NOT IN ( SELECT semester_id FROM Student_Enrolment )
SELECT T1.semester_name FROM Semesters AS T1 WHERE T1.semester_id NOT IN ( SELECT semester_id FROM Student_Enrolment )
SELECT T1.course_name FROM Courses AS T1 INNER JOIN Student_Enrolment_Courses AS T2 ON T1.course_id = T2.course_id
SELECT T1.course_name FROM Courses AS T1 INNER JOIN Student_Enrolment_Courses AS T2 ON T1.course_id = T2.course_id
SELECT T1.course_name FROM Courses AS T1 INNER JOIN Student_Enrolment_Courses AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(T2.student_course_id) DESC LIMIT 1
SELECT T1.course_name FROM Courses AS T1 INNER JOIN Student_Enrolment_Courses AS T2 ON T1.course_id = T2.course_id GROUP BY T1.course_name ORDER BY COUNT(T2.student_course_id) DESC LIMIT 1
SELECT T1.last_name FROM Students AS T1 INNER JOIN Addresses AS T2 ON T1.current_address_id = T2.address_id WHERE T2.state_province_county = 'North Carolina' AND T1.student_id NOT IN ( SELECT student_id FROM Student_Enrolment )
SELECT T1.last_name FROM Students AS T1 INNER JOIN Addresses AS T2 ON T1.current_address_id = T2.address_id WHERE T2.state_province_county = 'North Carolina' AND T1.student_id NOT IN ( SELECT student_id FROM Student_Enrolment )
SELECT T1.transcript_date, T1.transcript_id FROM Transcripts AS T1 INNER JOIN Transcript_Contents AS T2 ON T1.transcript_id = T2.transcript_id INNER JOIN Student_Enrolment_Courses AS T3 ON T2.student_course_id = T3.student_course_id GROUP BY T1.transcript_id HAVING COUNT(T3.student_course_id) >= 2
SELECT T1.transcript_date, T1.transcript_id FROM Transcripts AS T1 INNER JOIN Transcript_Contents AS T2 ON T1.transcript_id = T2.transcript_id GROUP BY T1.transcript_id HAVING COUNT(T2.student_course_id) >= 2
SELECT cell_mobile_number FROM Students WHERE first_name = 'Timmothy' AND last_name = 'Ward'
SELECT cell_mobile_number FROM Students WHERE first_name = 'Timmothy' AND last_name = 'Ward'
SELECT first_name, middle_name, last_name FROM Students ORDER BY date_first_registered LIMIT 1
SELECT first_name, middle_name, last_name FROM Students ORDER BY date_first_registered LIMIT 1
SELECT T1.first_name, T1.middle_name, T1.last_name FROM Students AS T1 ORDER BY T1.date_left LIMIT 1
SELECT T1.first_name, T1.middle_name, T1.last_name FROM Students AS T1 ORDER BY T1.date_left LIMIT 1
SELECT T1.first_name FROM Students AS T1 INNER JOIN Addresses AS T2 ON T1.current_address_id = T2.address_id INNER JOIN Addresses AS T3 ON T1.permanent_address_id = T3.address_id WHERE T2.address_id <> T3.address_id
SELECT T1.first_name FROM Students AS T1 INNER JOIN Addresses AS T2 ON T1.current_address_id = T2.address_id INNER JOIN Addresses AS T3 ON T1.permanent_address_id = T3.address_id WHERE T2.address_id <> T3.address_id
SELECT T1.address_id, T1.line_1, T1.line_2, T1.line_3 FROM Addresses AS T1 INNER JOIN Students AS T2 ON T1.address_id = T2.current_address_id GROUP BY T1.address_id ORDER BY COUNT(T2.student_id) DESC LIMIT 1
SELECT T1.address_id, T1.line_1, T1.line_2 FROM Addresses AS T1 JOIN Students AS T2 ON T1.address_id = T2.current_address_id GROUP BY T1.address_id ORDER BY COUNT(T2.student_id) DESC LIMIT 1
SELECT AVG(transcript_date) FROM Transcripts
SELECT avg(transcript_date) FROM Transcripts
SELECT T1.transcript_date, T1.other_details FROM Transcripts AS T1 ORDER BY T1.transcript_date LIMIT 1
SELECT MIN(transcript_date), other_details FROM Transcripts
SELECT COUNT(*) FROM Transcripts
SELECT COUNT(*) FROM Transcripts
SELECT MAX(transcript_date) FROM Transcripts
SELECT transcript_date FROM Transcripts ORDER BY transcript_date DESC LIMIT 1
SELECT COUNT(T1.student_course_id), T1.student_course_id FROM Transcript_Contents AS T1 GROUP BY T1.student_course_id ORDER BY COUNT(T1.student_course_id) DESC LIMIT 1
SELECT T1.course_id, T1.student_course_id FROM Student_Enrolment_Courses AS T1 GROUP BY T1.course_id ORDER BY COUNT(T1.student_course_id) DESC LIMIT 1
SELECT T1.transcript_date, T1.transcript_id FROM Transcripts AS T1 INNER JOIN Transcript_Contents AS T2 ON T1.transcript_id = T2.transcript_id GROUP BY T1.transcript_id ORDER BY COUNT(T2.student_course_id) LIMIT 1
SELECT T1.transcript_date, T1.transcript_id FROM Transcripts AS T1 INNER JOIN Transcript_Contents AS T2 ON T1.transcript_id = T2.transcript_id GROUP BY T1.transcript_id ORDER BY COUNT(T2.student_course_id) LIMIT 1
SELECT DISTINCT T1.semester_name FROM Semesters AS T1 INNER JOIN Student_Enrolment AS T2 ON T1.semester_id = T2.semester_id INNER JOIN Degree_Programs AS T3 ON T2.degree_program_id = T3.degree_program_id WHERE T3.degree_summary_name LIKE '%Master%' UNION SELECT DISTINCT T1.semester_name FROM Semesters AS T1 INNER JOIN Student_Enrolment AS T2 ON T1.semester_id = T2.semester_id INNER JOIN Degree_Programs AS T3 ON T2.degree_program_id = T3.degree_program_id WHERE T3.degree_summary_name LIKE '%Bachelor%'
SELECT DISTINCT semester_id FROM Student_Enrolment WHERE degree_program_id IN ( SELECT degree_program_id FROM Degree_Programs WHERE degree_summary_name LIKE '%Masters%' ) OR degree_program_id IN ( SELECT degree_program_id FROM Degree_Programs WHERE degree_summary_name LIKE '%Bachelors%' )
SELECT COUNT(DISTINCT T1.address_id) FROM Students AS T1
SELECT DISTINCT T1.line_1 FROM Addresses AS T1 INNER JOIN Students AS T2 ON T1.address_id = T2.current_address_id
SELECT * FROM Students ORDER BY last_name DESC, first_name DESC
SELECT other_student_details FROM Students ORDER BY last_name DESC
SELECT * FROM Sections WHERE section_name = 'h'
SELECT section_description FROM Sections WHERE section_name = 'h'
SELECT DISTINCT T1.first_name FROM Students AS T1 INNER JOIN Addresses AS T2 ON T1.permanent_address_id = T2.address_id WHERE T2.country = 'Haiti' OR T1.cell_mobile_number = '09700166582'
SELECT DISTINCT T1.first_name FROM Students AS T1 INNER JOIN Addresses AS T2 ON T1.permanent_address_id = T2.address_id WHERE T2.country = 'Haiti' OR T1.cell_mobile_number = '09700166582'
SELECT Title FROM Cartoon ORDER BY Title
SELECT Title FROM Cartoon ORDER BY Title
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones'
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones'
SELECT COUNT(*) FROM Cartoon WHERE Written_by = "Joseph Kuhr"
SELECT COUNT(T1.id) FROM Cartoon AS T1 WHERE T1.Written_by = 'Joseph Kuhr'
SELECT T1.Title, T1.Directed_by FROM Cartoon AS T1 ORDER BY T1.Original_air_date
SELECT T1.Title, T1.Directed_by FROM Cartoon AS T1 ORDER BY T1.Original_air_date
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones' OR Directed_by = 'Brandon Vietti'
SELECT Title FROM Cartoon WHERE Directed_by IN ('Ben Jones', 'Brandon Vietti')
SELECT Country, COUNT(*) AS num_channels FROM TV_Channel GROUP BY Country ORDER BY num_channels DESC LIMIT 1
SELECT Country, COUNT(id) FROM TV_Channel GROUP BY Country ORDER BY COUNT(id) DESC LIMIT 1
SELECT COUNT(DISTINCT series_name), COUNT(DISTINCT Content) FROM TV_Channel
SELECT COUNT(DISTINCT series_name), COUNT(DISTINCT Content) FROM TV_Channel
SELECT Content FROM TV_Channel WHERE series_name = 'Sky Radio'
SELECT Content FROM TV_Channel WHERE series_name = 'Sky Radio'
SELECT Package_Option FROM TV_Channel WHERE series_name = 'Sky Radio'
SELECT T1.Package_Option FROM TV_Channel AS T1 WHERE T1.series_name = 'Sky Radio'
SELECT COUNT(*) FROM TV_Channel WHERE Language = 'English'
SELECT COUNT(*) FROM TV_Channel WHERE Language = 'English'
SELECT Language, COUNT(id) AS ChannelCount FROM TV_Channel GROUP BY Language ORDER BY ChannelCount ASC LIMIT 1
SELECT Language, COUNT(id) AS channel_count FROM TV_Channel GROUP BY Language ORDER BY channel_count LIMIT 1
SELECT Language, COUNT(*) FROM TV_Channel GROUP BY Language
SELECT Language, COUNT(*) FROM TV_Channel GROUP BY Language
SELECT T1.series_name FROM TV_Channel AS T1 INNER JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Title = 'The Rise of the Blue Beetle!'
SELECT T1.series_name FROM TV_Channel AS T1 INNER JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Title = 'The Rise of the Blue Beetle'
SELECT T1.Title FROM Cartoon AS T1 INNER JOIN TV_Channel AS T2 ON T1.Channel = T2.id WHERE T2.series_name = 'Sky Radio'
SELECT T1.Title FROM Cartoon AS T1 INNER JOIN TV_Channel AS T2 ON T1.Channel = T2.id WHERE T2.series_name = 'Sky Radio'
SELECT Episode FROM TV_series ORDER BY Rating
SELECT Episode FROM TV_series ORDER BY Rating
SELECT Episode, Rating FROM TV_series ORDER BY Rating DESC LIMIT 3
SELECT Episode, Rating FROM TV_series ORDER BY Rating DESC LIMIT 3
SELECT MIN(Share), MAX(Share) FROM TV_series
SELECT MAX(Share), MIN(Share) FROM TV_series
SELECT Air_Date FROM TV_series WHERE Episode = "A Love of a Lifetime"
SELECT Air_Date FROM TV_series WHERE Episode = "A Love of a Lifetime"
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Love of a Lifetime'
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Love of a Lifetime'
SELECT T1.series_name FROM TV_Channel AS T1 INNER JOIN TV_series AS T2 ON T1.id = T2.Channel WHERE T2.Episode = 'A Love of a Lifetime'
SELECT T1.series_name FROM TV_Channel AS T1 INNER JOIN TV_series AS T2 ON T1.id = T2.Channel WHERE T2.Episode = 'A Love of a Lifetime'
SELECT T1.Episode FROM TV_series AS T1 INNER JOIN TV_Channel AS T2 ON T1.Channel = T2.id WHERE T2.series_name = 'Sky Radio'
SELECT T1.Episode FROM TV_series AS T1 INNER JOIN TV_Channel AS T2 ON T1.Channel = T2.id WHERE T2.series_name = 'Sky Radio'
SELECT Directed_by, COUNT(id) FROM Cartoon GROUP BY Directed_by
SELECT Directed_by, COUNT(*) FROM Cartoon GROUP BY Directed_by
SELECT Production_code, Channel FROM Cartoon ORDER BY Original_air_date DESC LIMIT 1
SELECT Production_code, Channel FROM Cartoon ORDER BY Original_air_date DESC LIMIT 1
SELECT Package_Option, series_name FROM TV_Channel WHERE Hight_definition_TV = 'Yes'
SELECT T1.Package_Option, T1.series_name FROM TV_Channel AS T1 WHERE T1.Hight_definition_TV = 'Yes'
SELECT DISTINCT T1.Country FROM TV_Channel AS T1 INNER JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Written_by = 'Todd Casey'
SELECT DISTINCT T1.Country FROM TV_Channel AS T1 INNER JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Written_by = 'Todd Casey'
SELECT DISTINCT T1.Country FROM TV_Channel AS T1 INNER JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Written_by <> 'Todd Casey'
SELECT DISTINCT T1.Country FROM TV_Channel AS T1 INNER JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Written_by <> 'Todd Casey'
SELECT T1.series_name, T1.Country FROM TV_Channel AS T1 INNER JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Directed_by = 'Ben Jones' AND T2.Directed_by = 'Michael Chang'
SELECT T1.series_name, T1.Country FROM TV_Channel AS T1 INNER JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Directed_by = 'Ben Jones' INTERSECT SELECT T1.series_name, T1.Country FROM TV_Channel AS T1 INNER JOIN Cartoon AS T2 ON T1.id = T2.Channel WHERE T2.Directed_by = 'Michael Chang'
SELECT Pixel_aspect_ratio_PAR, Country FROM TV_Channel WHERE Language <> 'English'
SELECT Pixel_aspect_ratio_PAR, Country FROM TV_Channel WHERE Language <> 'English'
SELECT T1.id FROM TV_Channel AS T1 WHERE T1.Country IN ( SELECT Country FROM TV_Channel GROUP BY Country HAVING COUNT(*) > 2 )
SELECT COUNT(T1.id) FROM TV_Channel AS T1 INNER JOIN TV_series AS T2 ON T1.id = T2.Channel GROUP BY T1.id HAVING COUNT(T1.id) > 2
SELECT DISTINCT T1.id FROM TV_Channel AS T1 WHERE T1.id NOT IN ( SELECT T3.Channel FROM Cartoon AS T3 WHERE T3.Directed_by = 'Ben Jones' )
SELECT DISTINCT T1.id FROM TV_Channel AS T1 WHERE T1.id NOT IN ( SELECT T3.Channel FROM Cartoon AS T3 WHERE T3.Directed_by = 'Ben Jones' )
SELECT DISTINCT T1.Package_Option FROM TV_Channel AS T1 WHERE T1.id NOT IN ( SELECT T3.Channel FROM Cartoon AS T3 WHERE T3.Directed_by = 'Ben Jones' )
SELECT DISTINCT T1.Package_Option FROM TV_Channel AS T1 WHERE T1.id NOT IN ( SELECT T3.Channel FROM Cartoon AS T3 WHERE T3.Directed_by = 'Ben Jones' )
SELECT COUNT(*) FROM poker_player
SELECT COUNT(*) FROM poker_player
SELECT Earnings FROM poker_player ORDER BY Earnings DESC
SELECT Earnings FROM poker_player ORDER BY Earnings DESC
SELECT Final_Table_Made, Best_Finish FROM poker_player
SELECT Final_Table_Made, Best_Finish FROM poker_player
SELECT avg(Earnings) FROM poker_player
SELECT avg(Earnings) FROM poker_player
SELECT Money_Rank FROM poker_player ORDER BY Earnings DESC LIMIT 1
SELECT Money_Rank FROM poker_player ORDER BY Earnings DESC LIMIT 1
SELECT MAX(Final_Table_Made) FROM poker_player WHERE Earnings < 200000
SELECT MAX(Final_Table_Made) FROM poker_player WHERE Earnings < 200000
SELECT T1.Name FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID
SELECT T1.Name FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID
SELECT T1.Name FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID WHERE T2.Earnings > 300000
SELECT T1.Name FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID WHERE T2.Earnings > 300000
SELECT T1.Name FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Final_Table_Made
SELECT T1.Name FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Final_Table_Made
SELECT T1.Birth_Date FROM people AS T1 JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings ASC LIMIT 1
SELECT T1.Birth_Date FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings LIMIT 1
SELECT T1.Money_Rank FROM poker_player AS T1 INNER JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Height DESC LIMIT 1
SELECT T1.Money_Rank FROM poker_player AS T1 INNER JOIN people AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Height DESC LIMIT 1
SELECT AVG(T1.Earnings) FROM poker_player AS T1 INNER JOIN people AS T2 ON T1.People_ID = T2.People_ID WHERE T2.Height > 200
SELECT AVG(p.Earnings) FROM poker_player AS p JOIN people AS pe ON p.People_ID = pe.People_ID WHERE pe.Height > 200
SELECT T1.Name FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings DESC
SELECT T1.Name FROM people AS T1 INNER JOIN poker_player AS T2 ON T1.People_ID = T2.People_ID ORDER BY T2.Earnings DESC
SELECT Nationality, COUNT(*) FROM people GROUP BY Nationality
SELECT Nationality, COUNT(*) FROM people GROUP BY Nationality
SELECT Nationality FROM people GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT Nationality FROM people GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2
SELECT Name, Birth_Date FROM people ORDER BY Name ASC
SELECT Name, Birth_Date FROM people ORDER BY Name
SELECT Name FROM people WHERE Nationality != "Russia"
SELECT Name FROM people WHERE Nationality != 'Russia'
SELECT Name FROM people WHERE People_ID NOT IN ( SELECT People_ID FROM poker_player )
SELECT Name FROM people WHERE People_ID NOT IN ( SELECT People_ID FROM poker_player )
SELECT COUNT(DISTINCT Nationality) FROM people
SELECT COUNT(DISTINCT Nationality) FROM people
SELECT COUNT(DISTINCT state) FROM AREA_CODE_STATE
SELECT contestant_number, contestant_name FROM CONTESTANTS ORDER BY contestant_name DESC
SELECT vote_id, phone_number, state FROM VOTES
SELECT MAX(area_code), MIN(area_code) FROM AREA_CODE_STATE
SELECT MAX(created) FROM VOTES WHERE state = 'CA'
SELECT contestant_name FROM CONTESTANTS WHERE contestant_name != 'Jessie Alloway'
SELECT DISTINCT state, created FROM VOTES
SELECT T1.contestant_number, T1.contestant_name FROM CONTESTANTS AS T1 INNER JOIN VOTES AS T2 ON T1.contestant_number = T2.contestant_number GROUP BY T1.contestant_number HAVING COUNT(T2.vote_id) >= 2
SELECT T1.contestant_number, T1.contestant_name FROM CONTESTANTS AS T1 INNER JOIN VOTES AS T2 ON T1.contestant_number = T2.contestant_number GROUP BY T1.contestant_number ORDER BY COUNT(T2.vote_id) LIMIT 1
SELECT COUNT(*) FROM VOTES WHERE state IN ('NY', 'CA')
SELECT COUNT(contestant_number) FROM CONTESTANTS WHERE contestant_number NOT IN ( SELECT contestant_number FROM VOTES )
SELECT T1.area_code FROM AREA_CODE_STATE AS T1 INNER JOIN VOTES AS T2 ON T1.state = T2.state GROUP BY T1.area_code ORDER BY COUNT(T2.vote_id) DESC LIMIT 1
SELECT T1.created, T1.state, T1.phone_number FROM VOTES AS T1 INNER JOIN CONTESTANTS AS T2 ON T1.contestant_number = T2.contestant_number WHERE T2.contestant_name = 'Tabatha Gehling'
SELECT DISTINCT T1.area_code FROM AREA_CODE_STATE AS T1 INNER JOIN VOTES AS T2 ON T1.state = T2.state INNER JOIN CONTESTANTS AS T3 ON T2.contestant_number = T3.contestant_number WHERE T3.contestant_name = 'Tabatha Gehling' INTERSECT SELECT DISTINCT T1.area_code FROM AREA_CODE_STATE AS T1 INNER JOIN VOTES AS T2 ON T1.state = T2.state INNER JOIN CONTESTANTS AS T3 ON T2.contestant_number = T3.contestant_number WHERE T3.contestant_name = 'Kelly Clauss'
SELECT contestant_name FROM CONTESTANTS WHERE contestant_name LIKE '%Al%'
SELECT Name FROM country WHERE IndepYear > 1950
SELECT Name FROM country WHERE IndepYear > 1950
SELECT COUNT(Code) FROM country WHERE GovernmentForm = 'Republic'
SELECT COUNT(Code) FROM country WHERE GovernmentForm = 'Republic'
SELECT SUM(SurfaceArea) FROM country WHERE Region = 'Caribbean'
SELECT SUM(SurfaceArea) FROM country WHERE Region = 'Caribbean'
SELECT T1.Continent FROM country AS T1 WHERE T1.Name = 'Anguilla'
SELECT T1.Continent FROM country AS T1 INNER JOIN city AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Anguilla'
SELECT T1.Region FROM country AS T1 INNER JOIN city AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Kabul'
SELECT T1.Region FROM country AS T1 INNER JOIN city AS T2 ON T1.Code = T2.CountryCode WHERE T2.Name = 'Kabul'
SELECT Language FROM countrylanguage WHERE CountryCode = 'ABW' ORDER BY Percentage DESC LIMIT 1
SELECT Language FROM countrylanguage WHERE CountryCode = ( SELECT Code FROM country WHERE Name = 'Aruba' ) ORDER BY Percentage DESC LIMIT 1
SELECT Population, LifeExpectancy FROM country WHERE Name = 'Brazil'
SELECT Population, LifeExpectancy FROM country WHERE Name = 'Brazil'
SELECT Region, Population FROM country WHERE Name = 'Angola'
SELECT T1.Region, T1.Population FROM country AS T1 WHERE T1.Name = 'Angola'
SELECT avg(LifeExpectancy) FROM country WHERE Region = 'Central Africa'
SELECT AVG(LifeExpectancy) FROM country WHERE Region = 'Central Africa'
SELECT Name FROM country WHERE Continent = 'Asia' ORDER BY LifeExpectancy LIMIT 1
SELECT Name FROM country WHERE Continent = 'Asia' ORDER BY LifeExpectancy LIMIT 1
SELECT SUM(Population), MAX(GNP) FROM country WHERE Continent = 'Asia'
SELECT SUM(T1.Population), MAX(T1.GNP) FROM country AS T1 WHERE T1.Continent = 'Asia'
SELECT AVG(T1.LifeExpectancy) FROM country AS T1 WHERE T1.Continent = 'Africa' AND T1.GovernmentForm = 'Republic'
SELECT AVG(T1.LifeExpectancy) FROM country AS T1 WHERE T1.Continent = 'Africa' AND T1.GovernmentForm = 'Republic'
SELECT SUM(SurfaceArea) FROM country WHERE Continent IN ('Asia', 'Europe')
SELECT SUM(SurfaceArea) FROM country WHERE Continent = 'Asia' OR Continent = 'Europe'
SELECT SUM(Population) FROM city WHERE District = 'Gelderland'
SELECT SUM(Population) FROM city WHERE District = 'Gelderland'
SELECT AVG(GNP), SUM(Population) FROM country WHERE GovernmentForm = 'US Territory'
SELECT AVG(T1.GNP), SUM(T1.Population) FROM country AS T1 WHERE T1.GovernmentForm = 'US Territory'
SELECT COUNT(DISTINCT Language) FROM countrylanguage
SELECT COUNT(DISTINCT Language) FROM countrylanguage
SELECT COUNT(DISTINCT GovernmentForm) FROM country WHERE Continent = 'Africa'
SELECT COUNT(DISTINCT GovernmentForm) FROM country WHERE Continent = 'Africa'
SELECT COUNT(DISTINCT Language) FROM countrylanguage WHERE CountryCode = 'ABW'
SELECT COUNT(DISTINCT Language) FROM countrylanguage WHERE CountryCode = 'ABW'
SELECT SUM(CASE WHEN IsOfficial = 'T' THEN 1 ELSE 0 END) FROM countrylanguage WHERE CountryCode = 'AFG'
SELECT SUM(Percentage) FROM countrylanguage WHERE CountryCode = 'AFG' AND IsOfficial = 'T'
SELECT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Code ORDER BY COUNT(T2.Language) DESC LIMIT 1
SELECT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Code ORDER BY COUNT(T2.Language) DESC LIMIT 1
SELECT T1.Continent FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Continent ORDER BY COUNT(T2.Language) DESC LIMIT 1
SELECT T1.Continent FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Continent ORDER BY COUNT(T2.Language) DESC LIMIT 1
SELECT COUNT(DISTINCT T1.CountryCode) FROM countrylanguage AS T1 INNER JOIN countrylanguage AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Language = 'English' AND T2.Language = 'Dutch'
SELECT COUNT(DISTINCT T1.CountryCode) FROM countrylanguage AS T1 INNER JOIN countrylanguage AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Language = 'English' AND T2.Language = 'Dutch'
SELECT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' INTERSECT SELECT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'French'
SELECT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' INTERSECT SELECT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'French'
SELECT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' AND T2.IsOfficial = 'T' INNER JOIN countrylanguage AS T3 ON T1.Code = T3.CountryCode WHERE T3.Language = 'French' AND T3.IsOfficial = 'T'
SELECT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' AND T2.IsOfficial = 'T' AND T2.Language = 'French' AND T2.IsOfficial = 'T'
SELECT DISTINCT T1.Continent FROM country INNER JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = 'Chinese'
SELECT COUNT(DISTINCT T1.Continent) FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'Chinese'
SELECT DISTINCT T1.Region FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' OR T2.Language = 'Dutch'
SELECT DISTINCT T1.Region FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'Dutch' OR T2.Language = 'English'
SELECT DISTINCT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.IsOfficial = 'T' AND ( T2.Language = 'English' OR T2.Language = 'Dutch' )
SELECT DISTINCT T1.Name FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language = 'English' OR T2.Language = 'Dutch' AND T2.IsOfficial = 'T'
SELECT Language FROM countrylanguage WHERE CountryCode IN ( SELECT Code FROM country WHERE Continent = 'Asia' ) GROUP BY Language ORDER BY SUM(Percentage) DESC LIMIT 1
SELECT Language FROM countrylanguage WHERE CountryCode IN ( SELECT Code FROM country WHERE Continent = 'Asia' ) GROUP BY Language ORDER BY COUNT(CountryCode) DESC LIMIT 1
SELECT DISTINCT T1.Language FROM countrylanguage AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE T2.GovernmentForm = 'Republic' GROUP BY T1.Language HAVING COUNT(T1.CountryCode) = 1
SELECT DISTINCT T1.Language FROM countrylanguage AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE T2.GovernmentForm = 'Republic' GROUP BY T1.Language HAVING COUNT(T1.CountryCode) = 1
SELECT T1.Name FROM city AS T1 INNER JOIN countrylanguage AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Language = 'English' ORDER BY T1.Population DESC LIMIT 1
SELECT T1.Name FROM city AS T1 INNER JOIN countrylanguage AS T2 ON T1.CountryCode = T2.CountryCode WHERE T2.Language = 'English' ORDER BY T1.Population DESC LIMIT 1
SELECT T1.Name, T1.Population, T1.LifeExpectancy FROM country AS T1 WHERE T1.Continent = 'Asia' ORDER BY T1.SurfaceArea DESC LIMIT 1
SELECT T1.Name, T1.Population, T1.LifeExpectancy FROM country AS T1 WHERE T1.Continent = 'Asia' ORDER BY T1.SurfaceArea DESC LIMIT 1
SELECT AVG(T1.LifeExpectancy) FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language != 'English' AND T2.IsOfficial = 'F'
SELECT AVG(LifeExpectancy) FROM country WHERE Code NOT IN (SELECT CountryCode FROM countrylanguage WHERE Language = 'English' AND IsOfficial = 'T')
SELECT SUM(T1.Population) FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language <> 'English'
SELECT SUM(T1.Population) FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language <> 'English'
SELECT T1.Language FROM countrylanguage AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE T2.HeadOfState = 'Beatrix'
SELECT T1.Language FROM countrylanguage AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE T2.HeadOfState = 'Beatrix'
SELECT COUNT(DISTINCT T1.Language) FROM countrylanguage AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE T2.IndepYear < 1930 AND T1.IsOfficial = 'T'
SELECT COUNT(DISTINCT T1.Language) FROM countrylanguage AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE T2.IndepYear < 1930 AND T1.IsOfficial = 'T'
SELECT Name FROM country WHERE SurfaceArea > ( SELECT MAX(SurfaceArea) FROM country WHERE Continent = 'Europe' )
SELECT T1.Name FROM country AS T1 WHERE T1.SurfaceArea > ( SELECT MAX(SurfaceArea) FROM country WHERE Continent = 'Europe' )
SELECT T1.Name FROM country AS T1 WHERE T1.Continent = 'Africa' AND T1.Population < ( SELECT MIN(Population) FROM country WHERE Continent = 'Asia' )
SELECT T1.Name FROM country AS T1 WHERE T1.Continent = 'Africa' AND T1.Population < ( SELECT MIN(Population) FROM country WHERE Continent = 'Asia' )
SELECT T1.Name FROM country AS T1 WHERE T1.Continent = 'Asia' AND T1.Population > ( SELECT MAX(Population) FROM country WHERE Continent = 'Africa' )
SELECT T1.Name FROM country AS T1 WHERE T1.Continent = 'Asia' AND T1.Population > ( SELECT MAX(Population) FROM country WHERE Continent = 'Africa' )
SELECT DISTINCT CountryCode FROM countrylanguage WHERE Language != 'English'
SELECT DISTINCT CountryCode FROM countrylanguage WHERE Language != 'English'
SELECT DISTINCT CountryCode FROM countrylanguage WHERE Language != 'English'
SELECT DISTINCT CountryCode FROM countrylanguage WHERE Language != 'English'
SELECT DISTINCT T1.Code FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language != 'English' AND T1.GovernmentForm != 'Republic'
SELECT DISTINCT T1.Code FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T2.Language != 'English' AND T1.GovernmentForm != 'Republic'
SELECT T1.Name FROM city AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code INNER JOIN countrylanguage AS T3 ON T2.Code = T3.CountryCode WHERE T2.Continent = 'Europe' AND T3.Language <> 'English' AND T3.IsOfficial = 'F'
SELECT T1.Name FROM city AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code INNER JOIN countrylanguage AS T3 ON T2.Code = T3.CountryCode WHERE T2.Continent = 'Europe' AND T3.Language = 'English' AND T3.IsOfficial = 'F'
SELECT DISTINCT T1.Name FROM city AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code INNER JOIN countrylanguage AS T3 ON T2.Code = T3.CountryCode WHERE T2.Continent = 'Asia' AND T3.Language = 'Chinese' AND T3.IsOfficial = 'T'
SELECT DISTINCT T1.Name FROM city AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code INNER JOIN countrylanguage AS T3 ON T2.Code = T3.CountryCode WHERE T2.Continent = 'Asia' AND T3.Language = 'Chinese'
SELECT Name, IndepYear, SurfaceArea FROM country ORDER BY Population ASC LIMIT 1
SELECT Name, IndepYear, SurfaceArea FROM country ORDER BY Population ASC LIMIT 1
SELECT T1.Population, T1.Name, T1.HeadOfState FROM country AS T1 ORDER BY T1.SurfaceArea DESC LIMIT 1
SELECT T1.Name, T1.Population, T1.HeadOfState FROM country AS T1 ORDER BY T1.SurfaceArea DESC LIMIT 1
SELECT T1.Name, COUNT(T2.Language) FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Code HAVING COUNT(T2.Language) >= 3
SELECT T1.Name, COUNT(T2.Language) AS num_languages FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode GROUP BY T1.Code HAVING COUNT(T2.Language) > 2
SELECT District, COUNT(ID) FROM city WHERE Population > ( SELECT AVG(Population) FROM city ) GROUP BY District
SELECT T1.District, COUNT(T1.ID) FROM city AS T1 WHERE T1.Population > ( SELECT AVG(Population) FROM city ) GROUP BY T1.District
SELECT T1.GovernmentForm, SUM(T2.Population) FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode WHERE T1.LifeExpectancy > 72 GROUP BY T1.GovernmentForm
SELECT GovernmentForm, SUM(Population) AS TotalPopulation FROM country WHERE LifeExpectancy > 72 GROUP BY GovernmentForm
SELECT Continent, AVG(LifeExpectancy) AS AverageLifeExpectancy, SUM(Population) AS TotalPopulation FROM country GROUP BY Continent HAVING AVG(LifeExpectancy) < 72
SELECT T1.Continent, SUM(T1.Population) AS TotalPopulation, AVG(T1.LifeExpectancy) AS AverageLifeExpectancy FROM country AS T1 WHERE T1.LifeExpectancy < 72 GROUP BY T1.Continent
SELECT Name, SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 5
SELECT Name, SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 5
SELECT Name FROM country ORDER BY Population DESC LIMIT 3
SELECT Name FROM country ORDER BY Population DESC LIMIT 3
SELECT Name FROM country ORDER BY Population LIMIT 3
SELECT Name FROM country ORDER BY Population LIMIT 3
SELECT COUNT(Code) FROM country WHERE Continent = 'Asia'
SELECT COUNT(Code) FROM country WHERE Continent = 'Asia'
SELECT Name FROM country WHERE Continent = 'Europe' AND Population = 80000
SELECT Name FROM country WHERE Continent = 'Europe' AND Population = 80000
SELECT SUM(Population), AVG(SurfaceArea) FROM country WHERE Continent = 'North America' AND SurfaceArea > 3000
SELECT SUM(Population), AVG(SurfaceArea) FROM country WHERE Region = 'North America' AND SurfaceArea > 3000
SELECT Name FROM city WHERE Population BETWEEN 160000 AND 900000
SELECT Name FROM city WHERE Population BETWEEN 160000 AND 900000
SELECT Language FROM countrylanguage GROUP BY Language ORDER BY COUNT(CountryCode) DESC LIMIT 1
SELECT Language FROM countrylanguage GROUP BY Language ORDER BY COUNT(CountryCode) DESC LIMIT 1
SELECT T1.Language, T1.Percentage FROM countrylanguage AS T1 INNER JOIN ( SELECT CountryCode, MAX(Percentage) AS MaxPercentage FROM countrylanguage GROUP BY CountryCode ) AS T2 ON T1.CountryCode = T2.CountryCode AND T1.Percentage = T2.MaxPercentage
SELECT T1.Code, T2.Language FROM country AS T1 INNER JOIN countrylanguage AS T2 ON T1.Code = T2.CountryCode ORDER BY T1.Code LIMIT 1
SELECT COUNT(DISTINCT T1.CountryCode) FROM countrylanguage AS T1 INNER JOIN countrylanguage AS T2 ON T1.CountryCode = T2.CountryCode WHERE T1.Language = 'Spanish' AND T1.Percentage = ( SELECT MAX(Percentage) FROM countrylanguage WHERE Language = 'Spanish' )
SELECT COUNT(T1.CountryCode) FROM countrylanguage AS T1 INNER JOIN country AS T2 ON T1.CountryCode = T2.Code WHERE T1.Language = 'Spanish' AND T1.Percentage = 100.0
SELECT CountryCode FROM countrylanguage WHERE Language = 'Spanish' ORDER BY Percentage DESC LIMIT 1
SELECT CountryCode FROM countrylanguage WHERE Language = 'Spanish' AND Percentage = ( SELECT MAX(Percentage) FROM countrylanguage WHERE CountryCode = countrylanguage.CountryCode )
SELECT COUNT(*) FROM conductor
SELECT COUNT(*) FROM conductor
SELECT Name FROM conductor ORDER BY Age ASC
SELECT Name FROM conductor ORDER BY Age
SELECT Name FROM conductor WHERE Nationality != "USA"
SELECT Name FROM conductor WHERE Nationality <> 'USA'
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC
SELECT Record_Company FROM orchestra ORDER BY Year_of_Founded DESC
SELECT avg(Attendance) FROM show
SELECT AVG(Attendance) FROM show
SELECT MAX(Share), MIN(Share) FROM performance WHERE Type <> 'Live final'
SELECT MAX(Share), MIN(Share) FROM Performance WHERE Type != 'Live final'
SELECT COUNT(DISTINCT Nationality) FROM conductor
SELECT COUNT(DISTINCT Nationality) FROM conductor
SELECT Name FROM conductor ORDER BY Year_of_Work DESC
SELECT Name FROM conductor ORDER BY Year_of_Work DESC
SELECT Name FROM conductor ORDER BY Year_of_Work DESC LIMIT 1
SELECT Name FROM conductor ORDER BY Year_of_Work DESC LIMIT 1
SELECT T1.Name, T2.Orchestra FROM conductor AS T1 INNER JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID
SELECT T1.Name, T2.Orchestra FROM conductor AS T1 INNER JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID
SELECT T1.Name FROM conductor AS T1 INNER JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID GROUP BY T1.Conductor_ID HAVING COUNT(T2.Orchestra_ID) > 1
SELECT T1.Name FROM conductor AS T1 INNER JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID GROUP BY T1.Conductor_ID HAVING COUNT(T2.Orchestra_ID) > 1
SELECT T1.Name FROM conductor AS T1 INNER JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID GROUP BY T1.Conductor_ID ORDER BY COUNT(T2.Orchestra_ID) DESC LIMIT 1
SELECT T1.Name FROM conductor AS T1 INNER JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID GROUP BY T1.Conductor_ID ORDER BY COUNT(T2.Orchestra_ID) DESC LIMIT 1
SELECT T1.Name FROM conductor AS T1 INNER JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID WHERE T2.Year_of_Founded > 2008
SELECT T1.Name FROM conductor AS T1 INNER JOIN orchestra AS T2 ON T1.Conductor_ID = T2.Conductor_ID WHERE T2.Year_of_Founded > 2008
SELECT Record_Company, COUNT(Orchestra_ID) FROM orchestra GROUP BY Record_Company
SELECT Record_Company, COUNT(Orchestra_ID) FROM orchestra GROUP BY Record_Company
SELECT Major_Record_Format FROM orchestra GROUP BY Major_Record_Format ORDER BY COUNT(*) ASC
SELECT Major_Record_Format, COUNT(Orchestra_ID) AS format_count FROM orchestra GROUP BY Major_Record_Format ORDER BY format_count DESC
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC LIMIT 1
SELECT Record_Company FROM orchestra GROUP BY Record_Company ORDER BY COUNT(*) DESC LIMIT 1
SELECT Orchestra FROM orchestra WHERE Orchestra_ID NOT IN ( SELECT Orchestra_ID FROM performance )
SELECT Orchestra FROM orchestra WHERE Orchestra_ID NOT IN ( SELECT Orchestra_ID FROM performance )
SELECT DISTINCT Record_Company FROM orchestra WHERE Year_of_Founded < 2003 UNION SELECT DISTINCT Record_Company FROM orchestra WHERE Year_of_Founded > 2003
SELECT DISTINCT Record_Company FROM orchestra WHERE Year_of_Founded < 2003 INTERSECT SELECT DISTINCT Record_Company FROM orchestra WHERE Year_of_Founded > 2003
SELECT COUNT(Orchestra_ID) FROM orchestra WHERE Major_Record_Format IN ('CD', 'DVD')
SELECT COUNT(Orchestra_ID) FROM orchestra WHERE Major_Record_Format IN ('CD', 'DVD')
SELECT DISTINCT T1.Year_of_Founded FROM orchestra AS T1 INNER JOIN performance AS T2 ON T1.Orchestra_ID = T2.Orchestra_ID GROUP BY T1.Orchestra_ID HAVING COUNT(T2.Performance_ID) > 1
SELECT T1.Year_of_Founded FROM orchestra AS T1 INNER JOIN performance AS T2 ON T1.Orchestra_ID = T2.Orchestra_ID GROUP BY T1.Orchestra_ID HAVING COUNT(T2.Performance_ID) > 1
SELECT COUNT(*) FROM Highschooler
SELECT COUNT(*) FROM Highschooler
SELECT name, grade FROM Highschooler
SELECT name, grade FROM Highschooler
SELECT grade FROM Highschooler
SELECT grade FROM Highschooler
SELECT grade FROM Highschooler WHERE name = 'Kyle'
SELECT grade FROM Highschooler WHERE name = 'Kyle'
SELECT name FROM Highschooler WHERE grade = 10
SELECT name FROM Highschooler WHERE grade = 10
SELECT ID FROM Highschooler WHERE name = 'Kyle'
SELECT ID FROM Highschooler WHERE name = 'Kyle'
SELECT COUNT(*) FROM Highschooler WHERE grade = 9 OR grade = 10
SELECT COUNT(ID) FROM Highschooler WHERE grade = 9 OR grade = 10
SELECT grade, COUNT(*) FROM Highschooler GROUP BY grade
SELECT grade, COUNT(*) FROM Highschooler GROUP BY grade
SELECT grade FROM Highschooler GROUP BY grade ORDER BY COUNT(*) DESC LIMIT 1
SELECT grade FROM Highschooler GROUP BY grade ORDER BY COUNT(*) DESC LIMIT 1
SELECT grade FROM Highschooler GROUP BY grade HAVING COUNT(*) >= 4
SELECT grade FROM Highschooler GROUP BY grade HAVING COUNT(*) >= 4
SELECT T1.student_id, COUNT(T1.friend_id) AS num_friends FROM Friend AS T1 GROUP BY T1.student_id
SELECT T1.name, COUNT(T2.friend_id) AS num_friends FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T1.ID
SELECT T1.name, COUNT(T2.friend_id) AS num_friends FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T1.name
SELECT T1.name, COUNT(T2.friend_id) AS num_friends FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T1.name
SELECT T1.name FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T1.ID ORDER BY COUNT(T2.friend_id) DESC LIMIT 1
SELECT T1.name FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T1.ID ORDER BY COUNT(T2.friend_id) DESC LIMIT 1
SELECT T1.name FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T1.ID HAVING count(T2.friend_id) >= 3
SELECT T1.name FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id GROUP BY T1.ID HAVING COUNT(T2.friend_id) >= 3
SELECT T1.name FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.ID = T2.friend_id INNER JOIN Highschooler AS T3 ON T2.student_id = T3.ID WHERE T3.name = 'Kyle'
SELECT T1.name FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.ID = T2.friend_id WHERE T2.student_id = (SELECT ID FROM Highschooler WHERE name = 'Kyle')
SELECT COUNT(T1.friend_id) FROM Friend AS T1 INNER JOIN Highschooler AS T2 ON T1.student_id = T2.ID WHERE T2.name = 'Kyle'
SELECT COUNT(*) FROM Friend WHERE student_id IN (SELECT ID FROM Highschooler WHERE name = 'Kyle')
SELECT ID FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT ID FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT name FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT name FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT DISTINCT T1.ID FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.ID = T2.student_id INNER JOIN Likes AS T3 ON T1.ID = T3.liked_id
SELECT DISTINCT student_id FROM Friend UNION SELECT DISTINCT student_id FROM Likes
SELECT T1.name FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.ID = T2.student_id INNER JOIN Likes AS T3 ON T1.ID = T3.liked_id
SELECT T1.name FROM Highschooler AS T1 INNER JOIN Friend AS T2 ON T1.ID = T2.student_id INNER JOIN Likes AS T3 ON T1.ID = T3.student_id
SELECT student_id, COUNT(liked_id) FROM Likes GROUP BY student_id
SELECT student_id, COUNT(liked_id) FROM Likes GROUP BY student_id
SELECT T1.name, COUNT(T2.liked_id) AS num_likes FROM Highschooler AS T1 INNER JOIN Likes AS T2 ON T1.ID = T2.liked_id GROUP BY T1.name
SELECT T1.name, COUNT(T2.liked_id) AS num_likes FROM Highschooler AS T1 INNER JOIN Likes AS T2 ON T1.ID = T2.student_id GROUP BY T1.name
SELECT T1.name FROM Highschooler AS T1 INNER JOIN Likes AS T2 ON T1.ID = T2.liked_id GROUP BY T1.ID ORDER BY COUNT(T2.student_id) DESC LIMIT 1
SELECT T1.name FROM Highschooler AS T1 JOIN Likes AS T2 ON T1.ID = T2.liked_id GROUP BY T1.ID ORDER BY COUNT(T2.student_id) DESC LIMIT 1
SELECT T1.name FROM Highschooler AS T1 INNER JOIN Likes AS T2 ON T1.ID = T2.liked_id GROUP BY T1.ID HAVING count(*) >= 2
SELECT T1.name FROM Highschooler AS T1 JOIN Likes AS T2 ON T1.ID = T2.liked_id GROUP BY T1.ID HAVING COUNT(T2.student_id) >= 2
SELECT T1.name FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id WHERE T1.grade > 5 GROUP BY T1.ID HAVING COUNT(T2.friend_id) >= 2
SELECT T1.name FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id WHERE T1.grade > 5 GROUP BY T1.ID HAVING COUNT(T2.friend_id) >= 2
SELECT COUNT(*) FROM Likes WHERE student_id IN (SELECT ID FROM Highschooler WHERE name = 'Kyle')
SELECT COUNT(*) FROM Likes WHERE student_id IN (SELECT ID FROM Highschooler WHERE name = 'Kyle')
SELECT AVG(T1.grade) FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id
SELECT AVG(T1.grade) FROM Highschooler AS T1 JOIN Friend AS T2 ON T1.ID = T2.student_id
SELECT MIN(grade) FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT min(T1.grade) FROM Highschooler AS T1 WHERE T1.ID NOT IN (SELECT student_id FROM Friend)
SELECT DISTINCT T1.state FROM Owners AS T1 INNER JOIN Professionals AS T2 ON T1.state = T2.state
SELECT DISTINCT T1.state FROM Owners AS T1 INNER JOIN Professionals AS T2 ON T1.state = T2.state
SELECT AVG(T1.age) FROM Dogs AS T1 INNER JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id
SELECT AVG(age) FROM Dogs WHERE dog_id IN (SELECT dog_id FROM Treatments)
SELECT P.professional_id, P.last_name, P.cell_number FROM Professionals AS P WHERE P.state = 'Indiana' UNION SELECT P.professional_id, P.last_name, P.cell_number FROM Professionals AS P JOIN Treatments AS T ON P.professional_id = T.professional_id GROUP BY P.professional_id HAVING COUNT(T.treatment_id) > 2
SELECT T1.professional_id, T1.last_name, T1.cell_number FROM Professionals AS T1 WHERE T1.state = 'Indiana' OR T1.professional_id IN ( SELECT professional_id FROM Treatments GROUP BY professional_id HAVING COUNT(*) > 2 )
SELECT T1.name FROM Dogs AS T1 INNER JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id WHERE T2.cost_of_treatment <= 1000
SELECT T1.name FROM Dogs AS T1 INNER JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id WHERE T2.cost_of_treatment <= 1000
SELECT DISTINCT first_name FROM Owners UNION SELECT DISTINCT first_name FROM Professionals WHERE first_name NOT IN ( SELECT name FROM Dogs )
SELECT DISTINCT T1.first_name FROM Owners AS T1 UNION SELECT DISTINCT T1.first_name FROM Professionals AS T1 WHERE T1.first_name NOT IN ( SELECT name FROM Dogs )
SELECT P.professional_id, P.role_code, P.email_address FROM Professionals AS P WHERE P.professional_id NOT IN ( SELECT professional_id FROM Treatments )
SELECT professional_id, role_code, email_address FROM Professionals WHERE professional_id NOT IN ( SELECT professional_id FROM Treatments )
SELECT O.owner_id, O.first_name, O.last_name FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id GROUP BY O.owner_id ORDER BY COUNT(D.dog_id) DESC LIMIT 1
SELECT T1.owner_id, T1.first_name, T1.last_name FROM Owners AS T1 INNER JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id GROUP BY T1.owner_id ORDER BY COUNT(T2.dog_id) DESC LIMIT 1
SELECT P.professional_id, P.role_code, P.first_name FROM Professionals AS P JOIN Treatments AS T ON P.professional_id = T.professional_id GROUP BY P.professional_id HAVING COUNT(T.treatment_id) >= 2
SELECT P.professional_id, P.role_code, P.first_name FROM Professionals AS P JOIN Treatments AS T ON P.professional_id = T.professional_id GROUP BY P.professional_id HAVING COUNT(T.treatment_id) >= 2
SELECT T1.breed_name FROM Breeds AS T1 INNER JOIN Dogs AS T2 ON T1.breed_code = T2.breed_code GROUP BY T1.breed_name ORDER BY COUNT(T2.dog_id) DESC LIMIT 1
SELECT T1.breed_name FROM Breeds AS T1 INNER JOIN Dogs AS T2 ON T1.breed_code = T2.breed_code GROUP BY T1.breed_name ORDER BY COUNT(T2.dog_id) DESC LIMIT 1
SELECT O.owner_id, O.last_name FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id JOIN Treatments AS T ON D.dog_id = T.dog_id GROUP BY O.owner_id ORDER BY COUNT(T.treatment_id) DESC LIMIT 1
SELECT T1.owner_id, T2.last_name FROM Dogs AS T1 INNER JOIN Owners AS T2 ON T1.owner_id = T2.owner_id INNER JOIN Treatments AS T3 ON T1.dog_id = T3.dog_id GROUP BY T1.owner_id ORDER BY SUM(T3.cost_of_treatment) DESC LIMIT 1
SELECT T2.treatment_type_description FROM Treatments AS T1 INNER JOIN Treatment_Types AS T2 ON T1.treatment_type_code = T2.treatment_type_code GROUP BY T1.treatment_type_code ORDER BY SUM(T1.cost_of_treatment) LIMIT 1
SELECT T1.treatment_type_description FROM Treatment_Types AS T1 INNER JOIN Treatments AS T2 ON T1.treatment_type_code = T2.treatment_type_code GROUP BY T1.treatment_type_code ORDER BY SUM(T2.cost_of_treatment) LIMIT 1
SELECT O.owner_id, O.zip_code FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id JOIN Treatments AS T ON D.dog_id = T.dog_id GROUP BY O.owner_id ORDER BY SUM(T.cost_of_treatment) DESC LIMIT 1
SELECT T1.owner_id, T1.zip_code FROM Owners AS T1 INNER JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id INNER JOIN Treatments AS T3 ON T2.dog_id = T3.dog_id GROUP BY T1.owner_id ORDER BY SUM(T3.cost_of_treatment) DESC LIMIT 1
SELECT T1.professional_id, T1.cell_number FROM Professionals AS T1 INNER JOIN Treatments AS T2 ON T1.professional_id = T2.professional_id GROUP BY T1.professional_id HAVING COUNT(DISTINCT T2.treatment_type_code) >= 2
SELECT T1.professional_id, T1.cell_number FROM Professionals AS T1 INNER JOIN Treatments AS T2 ON T1.professional_id = T2.professional_id GROUP BY T1.professional_id HAVING COUNT(DISTINCT T2.treatment_type_code) >= 2
SELECT T1.first_name, T1.last_name FROM Professionals AS T1 INNER JOIN Treatments AS T2 ON T1.professional_id = T2.professional_id WHERE T2.cost_of_treatment < ( SELECT AVG(cost_of_treatment) FROM Treatments )
SELECT T1.first_name, T1.last_name FROM Professionals AS T1 INNER JOIN Treatments AS T2 ON T1.professional_id = T2.professional_id WHERE T2.cost_of_treatment < ( SELECT AVG(cost_of_treatment) FROM Treatments )
SELECT T.date_of_treatment, P.first_name FROM Treatments AS T JOIN Professionals AS P ON T.professional_id = P.professional_id
SELECT T1.date_of_treatment, T2.first_name FROM Treatments AS T1 INNER JOIN Professionals AS T2 ON T1.professional_id = T2.professional_id
SELECT T.cost_of_treatment, TT.treatment_type_description FROM Treatments AS T JOIN Treatment_Types AS TT ON T.treatment_type_code = TT.treatment_type_code
SELECT T.cost_of_treatment, TT.treatment_type_description FROM Treatments AS T JOIN Treatment_Types AS TT ON T.treatment_type_code = TT.treatment_type_code
SELECT O.first_name, O.last_name, S.size_description FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id JOIN Sizes AS S ON D.size_code = S.size_code
SELECT O.first_name, O.last_name, S.size_description FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id JOIN Sizes AS S ON D.size_code = S.size_code
SELECT O.first_name, D.name FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id
SELECT O.first_name, D.name FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id
SELECT T1.name, T3.date_of_treatment FROM Dogs AS T1 INNER JOIN Treatments AS T3 ON T1.dog_id = T3.dog_id INNER JOIN Breeds AS T2 ON T1.breed_code = T2.breed_code WHERE T2.breed_code = ( SELECT breed_code FROM Breeds GROUP BY breed_code ORDER BY COUNT(*) LIMIT 1 )
SELECT T1.name, T3.date_of_treatment FROM Dogs AS T1 INNER JOIN Breeds AS T2 ON T1.breed_code = T2.breed_code INNER JOIN Treatments AS T3 ON T1.dog_id = T3.dog_id ORDER BY T2.breed_name LIMIT 1
SELECT O.first_name, D.name FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id WHERE O.state = 'VA'
SELECT O.first_name, D.name FROM Owners AS O JOIN Dogs AS D ON O.owner_id = D.owner_id WHERE O.state = 'VA'
SELECT T1.date_arrived, T1.date_departed FROM Dogs AS T1 INNER JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id
SELECT T1.date_arrived, T1.date_departed FROM Dogs AS T1 INNER JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id
SELECT T1.last_name FROM Owners AS T1 INNER JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id ORDER BY T2.age LIMIT 1
SELECT T1.last_name FROM Owners AS T1 INNER JOIN Dogs AS T2 ON T1.owner_id = T2.owner_id ORDER BY T2.age ASC LIMIT 1
SELECT email_address FROM Professionals WHERE state = 'Hawaii' OR state = 'Wisconsin'
SELECT email_address FROM Professionals WHERE state = 'Hawaii' OR state = 'Wisconsin'
SELECT date_arrived, date_departed FROM Dogs
SELECT date_arrived, date_departed FROM Dogs
SELECT COUNT(DISTINCT dog_id) FROM Treatments
SELECT COUNT(T1.dog_id) FROM Treatments AS T1
SELECT COUNT(DISTINCT professional_id) FROM Treatments
SELECT COUNT(DISTINCT professional_id) FROM Treatments
SELECT T1.role_code, T1.street, T1.city, T1.state FROM Professionals AS T1 WHERE T1.city LIKE '%West%'
SELECT T1.role_code, T1.street, T1.city, T1.state FROM Professionals AS T1 WHERE T1.city LIKE '%West%'
SELECT first_name, last_name, email_address FROM Owners WHERE state LIKE '%North%'
SELECT first_name, last_name, email_address FROM Owners WHERE state LIKE '%North%'
SELECT COUNT(dog_id) FROM Dogs WHERE age < (SELECT AVG(age) FROM Dogs)
SELECT COUNT(dog_id) FROM Dogs WHERE age < (SELECT AVG(age) FROM Dogs)
SELECT MAX(cost_of_treatment) FROM Treatments
SELECT cost_of_treatment FROM Treatments ORDER BY date_of_treatment DESC LIMIT 1
SELECT COUNT(T1.dog_id) FROM Dogs AS T1 LEFT JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id WHERE T2.dog_id IS NULL
SELECT COUNT(T1.dog_id) FROM Dogs AS T1 LEFT JOIN Treatments AS T2 ON T1.dog_id = T2.dog_id WHERE T2.dog_id IS NULL
SELECT COUNT(owner_id) FROM Owners WHERE owner_id NOT IN (SELECT owner_id FROM Dogs WHERE date_adopted IS NULL AND date_departed IS NULL)
SELECT COUNT(owner_id) FROM Owners WHERE owner_id NOT IN (SELECT owner_id FROM Dogs WHERE date_adopted IS NULL AND date_departed IS NULL)
SELECT COUNT(T1.professional_id) FROM Professionals AS T1 LEFT JOIN Treatments AS T2 ON T1.professional_id = T2.professional_id WHERE T2.professional_id IS NULL
SELECT COUNT(*) FROM Professionals WHERE professional_id NOT IN (SELECT professional_id FROM Treatments)
SELECT name, age, weight FROM Dogs WHERE abandoned_yn = '1'
SELECT name, age, weight FROM Dogs WHERE abandoned_yn = '1'
SELECT avg(age) FROM Dogs
SELECT AVG(age) FROM Dogs
SELECT MAX(age) FROM Dogs
SELECT MAX(age) FROM Dogs
SELECT charge_type, charge_amount FROM Charges
SELECT charge_type, charge_amount FROM Charges
SELECT MAX(charge_amount) FROM Charges
SELECT MAX(charge_amount) FROM Charges
SELECT email_address, cell_number, home_phone FROM Professionals
SELECT email_address, cell_number, home_phone FROM Professionals
SELECT T1.breed_name, T2.size_description FROM Breeds AS T1 INNER JOIN Dogs AS T3 ON T1.breed_code = T3.breed_code INNER JOIN Sizes AS T2 ON T2.size_code = T3.size_code
SELECT DISTINCT T1.breed_code, T2.size_code FROM Dogs AS T1 INNER JOIN Sizes AS T2 ON T1.size_code = T2.size_code
SELECT T1.first_name, T3.treatment_type_description FROM Professionals AS T1 INNER JOIN Treatments AS T2 ON T1.professional_id = T2.professional_id INNER JOIN Treatment_Types AS T3 ON T2.treatment_type_code = T3.treatment_type_code
SELECT T1.first_name, T2.treatment_type_description FROM Professionals AS T1 INNER JOIN Treatments AS T3 ON T1.professional_id = T3.professional_id INNER JOIN Treatment_Types AS T2 ON T3.treatment_type_code = T2.treatment_type_code
SELECT COUNT(*) FROM singer
SELECT COUNT(*) FROM singer
SELECT Name FROM singer ORDER BY Net_Worth_Millions ASC
SELECT Name FROM singer ORDER BY Net_Worth_Millions ASC
SELECT Birth_Year, Citizenship FROM singer
SELECT Birth_Year, Citizenship FROM singer
SELECT Name FROM singer WHERE Citizenship != "France"
SELECT Name FROM singer WHERE Citizenship != 'French'
SELECT Name FROM singer WHERE Birth_Year IN (1948, 1949)
SELECT Name FROM singer WHERE Birth_Year = 1948 OR Birth_Year = 1949
SELECT Name FROM singer ORDER BY Net_Worth_Millions DESC LIMIT 1
SELECT Name FROM singer ORDER BY Net_Worth_Millions DESC LIMIT 1
SELECT Citizenship, COUNT(*) AS NumberOfSingers FROM singer GROUP BY Citizenship
SELECT Citizenship, COUNT(Singer_ID) FROM singer GROUP BY Citizenship
SELECT Citizenship FROM singer GROUP BY Citizenship ORDER BY COUNT(*) DESC LIMIT 1
SELECT Citizenship FROM singer GROUP BY Citizenship ORDER BY COUNT(*) DESC LIMIT 1
SELECT Citizenship, MAX(Net_Worth_Millions) FROM singer GROUP BY Citizenship
SELECT Citizenship, MAX(Net_Worth_Millions) FROM singer GROUP BY Citizenship
SELECT T1.Title, T2.Name FROM song AS T1 INNER JOIN singer AS T2 ON T1.Singer_ID = T2.Singer_ID
SELECT T1.Title, T2.Name FROM song AS T1 INNER JOIN singer AS T2 ON T1.Singer_ID = T2.Singer_ID
SELECT DISTINCT T1.Name FROM singer AS T1 INNER JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID WHERE T2.Sales > 300000
SELECT DISTINCT T1.Name FROM singer AS T1 INNER JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID WHERE T2.Sales > 300000
SELECT T1.Name FROM singer AS T1 INNER JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T1.Singer_ID HAVING COUNT(T2.Song_ID) > 1
SELECT T1.Name FROM singer AS T1 INNER JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T1.Singer_ID HAVING COUNT(T2.Song_ID) > 1
SELECT T1.Name, SUM(T2.Sales) FROM singer AS T1 INNER JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T1.Name
SELECT T1.Name, SUM(T2.Sales) FROM singer AS T1 INNER JOIN song AS T2 ON T1.Singer_ID = T2.Singer_ID GROUP BY T1.Name
SELECT Name FROM singer WHERE Singer_ID NOT IN (SELECT Singer_ID FROM song)
SELECT Name FROM singer WHERE Singer_ID NOT IN (SELECT Singer_ID FROM song)
SELECT DISTINCT T1.Citizenship FROM singer AS T1 WHERE T1.Birth_Year < 1945 OR T1.Birth_Year > 1955
SELECT DISTINCT Citizenship FROM singer WHERE Birth_Year < 1945 OR Birth_Year > 1955
SELECT COUNT(*) FROM Other_Available_Features
SELECT T1.feature_type_name FROM Ref_Feature_Types AS T1 INNER JOIN Other_Available_Features AS T2 ON T1.feature_type_code = T2.feature_type_code WHERE T2.feature_name = 'AirCon'
SELECT T1.property_type_description FROM Ref_Property_Types AS T1 INNER JOIN Properties AS T2 ON T1.property_type_code = T2.property_type_code
SELECT property_name FROM Properties WHERE property_type_code IN ('APT', 'HSE') AND room_count > 1

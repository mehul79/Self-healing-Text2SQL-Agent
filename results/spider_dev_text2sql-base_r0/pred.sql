SELECT COUNT(*) FROM singer
SELECT COUNT(*) FROM singer
SELECT singer.Name, singer.Country, singer.Age FROM singer ORDER BY singer.Age DESC
SELECT singer.Name, singer.Country, singer.Age FROM singer ORDER BY singer.Age DESC
SELECT AVG(Age) AS average_age, MIN(Age) AS min_age, MAX(Age) AS max_age FROM singer WHERE Country = 'France'
SELECT AVG(Age) AS average_age, MIN(Age) AS min_age, MAX(Age) AS max_age FROM singer WHERE Country = 'France'
SELECT 1
SELECT s.Name, s.Song_Name, s.Song_release_year FROM singer s JOIN singer_in_concert sic ON s.Singer_ID = sic.Singer_ID JOIN concert c ON sic.concert_ID = c.concert_ID ORDER BY s.Age ASC LIMIT 1
SELECT DISTINCT singer.Country FROM singer WHERE singer.Age > 20
SELECT DISTINCT singer.Country FROM singer JOIN singer_in_concert ON singer.Singer_ID = singer_in_concert.Singer_ID WHERE singer.Age > 20
SELECT singer.Country, COUNT(*) AS singer_count FROM singer GROUP BY singer.Country
SELECT singer.Country, COUNT(*) AS singer_count FROM singer GROUP BY singer.Country
SELECT s.Song_Name FROM singer s WHERE s.Age > (SELECT AVG(Age) FROM singer)
SELECT s.Song_Name FROM singer s WHERE s.Age > (SELECT AVG(Age) FROM singer)
SELECT Location, Name FROM stadium WHERE Capacity BETWEEN 5000 AND 10000
SELECT Location, Name FROM stadium WHERE Capacity BETWEEN 5000 AND 10000
SELECT MAX(Capacity) AS max_capacity, AVG(Capacity) AS avg_capacity FROM stadium
SELECT AVG(Capacity) AS average_capacity, MAX(Capacity) AS max_capacity FROM stadium
SELECT Name, Capacity FROM stadium WHERE Average = (SELECT MAX(Average) FROM stadium)
SELECT Name, Capacity FROM stadium WHERE Average = (SELECT MAX(Average) FROM stadium)
SELECT COUNT(*) FROM concert WHERE Year IN ('2014', '2015')
SELECT COUNT(*) FROM concert WHERE Year IN ('2014', '2015')
SELECT stadium.Name, COUNT(concert.concert_ID) AS num_concerts FROM stadium JOIN concert ON stadium.Stadium_ID = concert.Stadium_ID GROUP BY stadium.Name
SELECT stadium.Stadium_ID, COUNT(*) AS concert_count FROM stadium JOIN concert ON stadium.Stadium_ID = concert.Stadium_ID GROUP BY stadium.Stadium_ID
SELECT s.Name, s.Capacity FROM stadium s JOIN concert c ON s.Stadium_ID = c.Stadium_ID WHERE CAST(c.Year AS INTEGER) >= 2014 GROUP BY s.Stadium_ID, s.Name, s.Capacity ORDER BY COUNT(*) DESC LIMIT 1
SELECT s.Name, s.Capacity FROM stadium s JOIN concert c ON s.Stadium_ID = c.Stadium_ID WHERE CAST(c.Year AS INTEGER) > 2013 GROUP BY s.Stadium_ID, s.Name, s.Capacity ORDER BY COUNT(*) DESC LIMIT 1
SELECT Year, COUNT(*) AS num_concerts FROM concert GROUP BY Year ORDER BY num_concerts DESC LIMIT 1
SELECT Year, COUNT(*) AS concert_count FROM concert GROUP BY Year ORDER BY concert_count DESC LIMIT 1
SELECT stadium.Name FROM stadium WHERE stadium.Stadium_ID NOT IN (SELECT concert.Stadium_ID FROM concert)
SELECT stadium.Name FROM stadium WHERE stadium.Stadium_ID NOT IN (SELECT concert.Stadium_ID FROM concert)
SELECT DISTINCT singer.Country FROM singer WHERE singer.Age > 40 OR singer.Age < 30
SELECT s.Name FROM stadium s WHERE s.Stadium_ID NOT IN ( SELECT c.Stadium_ID FROM concert c WHERE c.Year = '2014' )
SELECT stadium.Name FROM stadium WHERE stadium.Stadium_ID NOT IN ( SELECT concert.Stadium_ID FROM concert WHERE concert.Year = '2014' )
SELECT c.concert_Name, c.Theme, COUNT(si.Singer_ID) AS singer_count FROM concert c JOIN singer_in_concert si ON c.concert_ID = si.concert_ID GROUP BY c.concert_ID, c.concert_Name, c.Theme
SELECT c.concert_Name, c.Theme, COUNT(si.Singer_ID) AS number_of_singers FROM concert c JOIN singer_in_concert si ON c.concert_ID = si.concert_ID GROUP BY c.concert_ID, c.concert_Name, c.Theme
SELECT s.Name, COUNT(DISTINCT sc.concert_ID) AS num_concerts FROM singer s JOIN singer_in_concert sc ON s.Singer_ID = sc.Singer_ID GROUP BY s.Singer_ID, s.Name
SELECT s.Name, COUNT(DISTINCT ci.concert_ID) AS num_concerts FROM singer s JOIN singer_in_concert ci ON s.Singer_ID = ci.Singer_ID GROUP BY s.Singer_ID, s.Name
SELECT s.Name FROM singer s JOIN singer_in_concert sic ON s.Singer_ID = sic.Singer_ID JOIN concert c ON sic.concert_ID = c.concert_ID WHERE c.Year = '2014'
SELECT DISTINCT s.Name FROM singer s JOIN singer_in_concert sic ON s.Singer_ID = sic.Singer_ID JOIN concert c ON sic.concert_ID = c.concert_ID WHERE c.Year = '2014'
SELECT singer.Name, singer.Country FROM singer JOIN singer_in_concert ON singer.Singer_ID = singer_in_concert.Singer_ID JOIN concert ON singer_in_concert.concert_ID = concert.concert_ID WHERE singer.Song_Name LIKE '%Hey%'
SELECT singer.Name, singer.Country FROM singer JOIN singer_in_concert ON singer.Singer_ID = singer_in_concert.Singer_ID JOIN concert ON singer_in_concert.concert_ID = concert.concert_ID WHERE singer.Song_Name LIKE '%Hey%'
SELECT DISTINCT s.Name, s.Location FROM stadium s JOIN concert c ON s.Stadium_ID = c.Stadium_ID WHERE c.Year IN ('2014', '2015') GROUP BY s.Stadium_ID HAVING COUNT(DISTINCT c.Year) = 2
SELECT DISTINCT s.Name, s.Location FROM stadium s JOIN concert c ON s.Stadium_ID = c.Stadium_ID WHERE c.Year IN ('2014', '2015') GROUP BY s.Stadium_ID, s.Name, s.Location HAVING COUNT(DISTINCT c.Year) = 2
SELECT COUNT(*) FROM concert c JOIN stadium s ON c.Stadium_ID = s.Stadium_ID WHERE s.Capacity = (SELECT MAX(Capacity) FROM stadium)
SELECT COUNT(*) FROM concert c JOIN stadium s ON c.Stadium_ID = s.Stadium_ID WHERE s.Capacity = (SELECT MAX(Capacity) FROM stadium)
SELECT COUNT(*) FROM Pets WHERE weight > 10
SELECT COUNT(*) FROM Pets WHERE weight > 10
SELECT p.weight FROM Pets p JOIN Has_Pet hp ON p.PetID = hp.PetID JOIN Student s ON hp.StuID = s.StuID WHERE p.PetType = 'dog' ORDER BY p.pet_age ASC LIMIT 1
SELECT MAX(pet_weight) FROM (SELECT CAST(pets.weight AS REAL) AS pet_weight FROM Pets JOIN Has_Pet ON Pets.PetID = Has_Pet.PetID JOIN Student ON Has_Pet.StuID = Student.StuID WHERE Pets.PetType = 'dog' ORDER BY pet_age ASC LIMIT 1)
SELECT PetType, MAX(weight) AS max_weight FROM Pets GROUP BY PetType
SELECT PetType, MAX(weight) AS max_weight FROM Pets GROUP BY PetType
SELECT COUNT(*) FROM Has_Pet JOIN Student ON Has_Pet.StuID = Student.StuID WHERE Student.Age > 20
SELECT COUNT(*) FROM Student s JOIN Has_Pet h ON s.StuID = h.StuID JOIN Pets p ON h.PetID = p.PetID WHERE s.Age > 20
SELECT COUNT(*) FROM Pets p JOIN Has_Pet h ON p.PetID = h.PetID JOIN Student s ON h.StuID = s.StuID WHERE p.PetType = 'dog' AND s.Sex = 'F'
SELECT COUNT(*) FROM Pets p JOIN Has_Pet h ON p.PetID = h.PetID JOIN Student s ON h.StuID = s.StuID WHERE p.PetType = 'dog' AND s.Sex = 'F'
SELECT COUNT(DISTINCT PetType) FROM Pets
SELECT COUNT(DISTINCT PetType) FROM Pets
SELECT Student.Fname FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType IN ('cat', 'dog')
SELECT S.Fname FROM Student S JOIN Has_Pet H ON S.StuID = H.StuID JOIN Pets P ON H.PetID = P.PetID WHERE P.PetType IN ('cat', 'dog')
SELECT DISTINCT s.Fname FROM Student s JOIN Has_Pet hp ON s.StuID = hp.StuID JOIN Pets p ON hp.PetID = p.PetID WHERE p.PetType = 'cat' AND EXISTS ( SELECT 1 FROM Has_Pet hp2 JOIN Pets p2 ON hp2.PetID = p2.PetID WHERE hp2.StuID = s.StuID AND p2.PetType = 'dog' )
SELECT DISTINCT S.Fname FROM Student S JOIN Has_Pet HP ON S.StuID = HP.StuID JOIN Pets P ON HP.PetID = P.PetID WHERE P.PetType = 'cat' AND EXISTS ( SELECT 1 FROM Has_Pet HP2 JOIN Pets P2 ON HP2.PetID = P2.PetID WHERE HP2.StuID = S.StuID AND P2.PetType = 'dog' )
SELECT S.Major, S.Age FROM Student S WHERE NOT EXISTS ( SELECT 1 FROM Has_Pet H JOIN Pets P ON H.PetID = P.PetID WHERE H.StuID = S.StuID AND P.PetType = 'cat' )
SELECT S.Major, S.Age FROM Student S WHERE NOT EXISTS ( SELECT 1 FROM Has_Pet HP JOIN Pets P ON HP.PetID = P.PetID WHERE HP.StuID = S.StuID AND P.PetType = 'cat' )
SELECT StuID FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'cat')
SELECT StuID FROM Student WHERE StuID NOT IN (SELECT StuID FROM Has_Pet JOIN Pets ON Has_Pet.PetID = Pets.PetID WHERE Pets.PetType = 'cat')
SELECT Fname, Age FROM Student WHERE StuID IN (SELECT StuID FROM Has_Pet WHERE PetID IN (SELECT PetID FROM Pets WHERE PetType = 'dog')) AND StuID NOT IN (SELECT StuID FROM Has_Pet WHERE PetID IN (SELECT PetID FROM Pets WHERE PetType = 'cat'))
SELECT S.Fname FROM Student S JOIN Has_Pet HP ON S.StuID = HP.StuID JOIN Pets P ON HP.PetID = P.PetID WHERE P.PetType = 'dog' AND NOT EXISTS ( SELECT 1 FROM Has_Pet HP2 JOIN Pets P2 ON HP2.PetID = P2.PetID WHERE HP2.StuID = S.StuID AND P2.PetType = 'cat' )
SELECT P.PetType, P.weight FROM Pets P JOIN Has_Pet HP ON P.PetID = HP.PetID JOIN Student S ON HP.StuID = S.StuID ORDER BY P.pet_age DESC LIMIT 1
SELECT PetType, weight FROM Pets WHERE pet_age = (SELECT MIN(pet_age) FROM Pets)
SELECT Pets.PetID, Pets.weight FROM Pets WHERE pet_age > 1
SELECT Pets.PetID, Pets.weight FROM Pets WHERE pet_age > 1
SELECT PetType, AVG(pet_age) AS avg_age, MAX(pet_age) AS max_age FROM Pets GROUP BY PetType
SELECT PetType, AVG(pet_age) AS avg_age, MAX(pet_age) AS max_age FROM Pets GROUP BY PetType
SELECT PetType, AVG(weight) AS avg_weight FROM Pets GROUP BY PetType
SELECT PetType, AVG(weight) AS avg_weight FROM Pets GROUP BY PetType
SELECT Student.Fname, Student.Age FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID
SELECT DISTINCT S.Fname, S.Age FROM Student S JOIN Has_Pet H ON S.StuID = H.StuID
SELECT p.PetID FROM Pets p JOIN Has_Pet hp ON p.PetID = hp.PetID JOIN Student s ON hp.StuID = s.StuID WHERE s.LName = 'Smith'
SELECT p.PetID FROM Pets p JOIN Has_Pet hp ON p.PetID = hp.PetID JOIN Student s ON hp.StuID = s.StuID WHERE s.LName = 'Smith'
SELECT Student.StuID, COUNT(*) AS num_pets FROM Student JOIN Has_Pet ON Student.StuID = Has_Pet.StuID JOIN Pets ON Has_Pet.PetID = Pets.PetID GROUP BY Student.StuID
SELECT StuID, COUNT(*) AS pet_count FROM Has_Pet GROUP BY StuID
SELECT S.Fname, S.Sex FROM Student S JOIN Has_Pet HP ON S.StuID = HP.StuID JOIN Pets P ON HP.PetID = P.PetID GROUP BY S.StuID HAVING COUNT(P.PetID) > 1
SELECT Fname, Sex FROM Student s JOIN Has_Pet hp ON s.StuID = hp.StuID JOIN Pets p ON hp.PetID = p.PetID GROUP BY s.StuID, s.Fname, s.Sex HAVING COUNT(*) > 1
SELECT S.LName FROM Student S JOIN Has_Pet H ON S.StuID = H.StuID JOIN Pets P ON H.PetID = P.PetID WHERE P.PetType = 'cat' AND P.pet_age = 3
SELECT S.LName FROM Student S JOIN Has_Pet H ON S.StuID = H.StuID JOIN Pets P ON H.PetID = P.PetID WHERE P.PetType = 'cat' AND P.pet_age = 3
SELECT AVG(S.Age) AS average_age FROM Student S WHERE S.StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT AVG(S.Age) AS average_age FROM Student S WHERE S.StuID NOT IN (SELECT StuID FROM Has_Pet)
SELECT COUNT(*) FROM continents
SELECT COUNT(*) FROM continents
SELECT continents.ContId, continents.Continent, COUNT(countries.CountryId) AS country_count FROM continents JOIN countries ON continents.ContId = countries.Continent GROUP BY continents.ContId, continents.Continent
SELECT continents.ContId, continents.Continent, COUNT(countries.CountryId) AS country_count FROM continents JOIN countries ON continents.ContId = countries.Continent GROUP BY continents.ContId, continents.Continent
SELECT COUNT(*) FROM countries
SELECT COUNT(*) FROM countries
SELECT 1
SELECT 1
SELECT car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN model_list ON car_names.Model = model_list.Model JOIN car_makers ON model_list.Maker = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId ORDER BY CAST(cars_data.Horsepower AS REAL) ASC LIMIT 1
SELECT car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN model_list ON car_names.Model = model_list.Model JOIN car_makers ON model_list.Maker = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId ORDER BY CAST(cars_data.Horsepower AS REAL) ASC LIMIT 1
SELECT car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN car_makers ON car_names.MakeId = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId JOIN model_list ON car_makers.Id = model_list.Maker WHERE cars_data.Weight < (SELECT AVG(cars_data2.Weight) FROM cars_data cars_data2)
SELECT car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN car_makers ON car_names.MakeId = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId JOIN model_list ON car_makers.Id = model_list.Maker WHERE cars_data.Weight < (SELECT AVG(cars_data2.Weight) FROM cars_data cars_data2)
SELECT DISTINCT cm.Maker FROM car_makers cm JOIN car_names cn ON cm.Id = cn.MakeId JOIN cars_data cd ON cn.MakeId = cd.Id WHERE cd.Year = 1970
SELECT DISTINCT cm.Maker FROM car_makers cm JOIN car_names cn ON cm.Id = cn.MakeId JOIN cars_data cd ON cn.MakeId = cd.Id WHERE cd.Year = 1970
SELECT car_names.Make, cars_data.Year FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId ORDER BY cars_data.Year ASC LIMIT 1
SELECT m.Maker, c.Year FROM cars_data c JOIN car_names cn ON c.Id = cn.MakeId JOIN model_list ml ON cn.Model = ml.Model JOIN car_makers m ON ml.Maker = m.Id ORDER BY c.Year ASC LIMIT 1
SELECT DISTINCT car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN car_makers ON car_names.Make = car_makers.Maker JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId WHERE cars_data.Year > 1980
SELECT DISTINCT car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN car_makers ON car_names.MakeId = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId WHERE cars_data.Year > 1980
SELECT continents.Continent, COUNT(*) AS car_maker_count FROM car_makers JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId GROUP BY continents.Continent
SELECT continents.Continent, COUNT(DISTINCT car_makers.Id) AS car_maker_count FROM car_makers JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId GROUP BY continents.Continent
SELECT c.CountryName FROM countries c JOIN car_makers cm ON c.CountryId = cm.Country GROUP BY c.CountryName ORDER BY COUNT(*) DESC LIMIT 1
SELECT c.CountryName FROM car_makers cm JOIN countries c ON cm.Country = c.CountryId GROUP BY c.CountryName ORDER BY COUNT(*) DESC LIMIT 1
SELECT cm.FullName, COUNT(cni.Model) AS model_count FROM car_makers cm JOIN car_names cni ON cm.Id = cni.MakeId GROUP BY cm.FullName
SELECT car_makers.Id AS maker_id, car_makers.FullName AS maker_full_name, COUNT(car_names.MakeId) AS model_count FROM car_makers JOIN car_names ON car_makers.Id = car_names.MakeId GROUP BY car_makers.Id, car_makers.FullName
SELECT 1
SELECT CAST(cars_data.Accelerate AS REAL) FROM car_makers JOIN car_names ON car_makers.Id = car_names.MakeId JOIN cars_data ON car_names.MakeId = cars_data.Id JOIN model_list ON car_names.Model = model_list.Model JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId WHERE model_list.Model = 'amc hornet sportabout (sw)'
SELECT COUNT(*) FROM car_makers cm JOIN countries c ON cm.Country = c.CountryId WHERE c.CountryName = 'france'
SELECT COUNT(DISTINCT cm.Id) FROM car_makers cm JOIN countries c ON cm.Country = c.CountryId WHERE c.CountryName = 'france'
SELECT COUNT(*) FROM car_makers JOIN countries ON car_makers.Country = countries.CountryId WHERE countries.CountryName = 'usa'
SELECT COUNT(*) FROM car_makers WHERE Maker = 'usa'
SELECT AVG(CAST(cars_data.MPG AS REAL)) AS average_mpg FROM cars_data WHERE CAST(cars_data.Cylinders AS INTEGER) = 4
SELECT AVG(CAST(MPG AS REAL)) FROM cars_data WHERE Cylinders = 4
SELECT 1
SELECT 1
SELECT DISTINCT cm.Maker, cn.Model FROM car_makers cm JOIN model_list ml ON cm.Id = ml.Maker JOIN car_names cn ON ml.Model = cn.Model
SELECT DISTINCT cm.Maker, cn.Model FROM car_makers cm JOIN car_names cn ON cm.Id = cn.MakeId JOIN model_list ml ON cn.Model = ml.Model WHERE cm.Maker IS NOT NULL AND cn.Model IS NOT NULL AND ml.Model IS NOT NULL
SELECT c.CountryName, c.CountryId FROM countries c JOIN car_makers cm ON c.CountryId = cm.Country WHERE c.CountryName IS NOT NULL
SELECT c.CountryName, c.CountryId FROM countries c JOIN car_makers cm ON c.CountryId = cm.Country WHERE c.CountryName IS NOT NULL
SELECT COUNT(*) FROM cars_data WHERE CAST(Horsepower AS REAL) > 150
SELECT COUNT(*) FROM cars_data WHERE Horsepower > 150
SELECT CAST(AVG(cars_data.Weight) AS REAL) AS average_weight, cars_data.Year FROM cars_data GROUP BY cars_data.Year ORDER BY cars_data.Year
SELECT CAST(AVG(cars_data.Weight) AS REAL) AS avg_weight, cars_data.Year FROM cars_data GROUP BY cars_data.Year
SELECT c.CountryName FROM countries c JOIN continents co ON c.Continent = co.ContId JOIN car_makers cm ON c.CountryId = cm.Country WHERE co.Continent = 'europe' GROUP BY c.CountryName HAVING COUNT(*) >= 3
SELECT 1
SELECT MAX(cars_data.Horsepower) AS max_horsepower, car_names.Make FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN model_list ON car_names.Model = model_list.Model JOIN car_makers ON model_list.Maker = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId WHERE cars_data.Cylinders = 3
SELECT MAX(cars_data.Horsepower) AS max_horsepower, car_makers.Maker FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN car_makers ON car_names.MakeId = car_makers.Id WHERE cars_data.Cylinders = 3
SELECT car_names.Model, CAST(cars_data.MPG AS REAL) AS MPG FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId ORDER BY MPG DESC LIMIT 1
SELECT car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN model_list ON car_names.Model = model_list.Model JOIN car_makers ON model_list.Maker = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId ORDER BY CAST(cars_data.MPG AS REAL) DESC LIMIT 1
SELECT AVG(CAST(c.Horsepower AS REAL)) FROM cars_data c JOIN car_names cn ON c.Id = cn.MakeId JOIN model_list ml ON cn.Model = ml.Model JOIN car_makers cm ON ml.Maker = cm.Id JOIN countries co ON cm.Country = co.CountryId JOIN continents con ON co.Continent = con.ContId WHERE c.Year < 1980
SELECT AVG(CAST(c.Horsepower AS REAL)) FROM cars_data c JOIN car_names cn ON c.Id = cn.MakeId JOIN model_list ml ON cn.Model = ml.Model JOIN car_makers cm ON ml.Maker = cm.Id JOIN countries co ON cm.Country = co.CountryId JOIN continents con ON co.Continent = con.ContId WHERE c.Year < 1980
SELECT AVG(cars_data.Edispl) AS average_edispl FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN model_list ON car_names.Model = model_list.Model JOIN car_makers ON model_list.Maker = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId WHERE model_list.Model = 'volvo'
SELECT AVG(cars_data.Edispl) AS average_edispl FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN model_list ON car_names.Model = model_list.Model JOIN car_makers ON model_list.Maker = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId WHERE car_makers.Maker = 'volvo'
SELECT Cylinders, MAX(CAST(Accelerate AS REAL)) AS MaxAccelerate FROM cars_data GROUP BY Cylinders ORDER BY Cylinders
SELECT cylinders, MAX(CAST(Accelerate AS REAL)) as max_accelerate FROM cars_data GROUP BY cylinders
SELECT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id JOIN car_names ON car_makers.Id = car_names.MakeId JOIN cars_data ON car_names.MakeId = cars_data.Id GROUP BY model_list.Model ORDER BY COUNT(*) DESC LIMIT 1
SELECT model_list.Model FROM model_list JOIN car_makers ON model_list.Maker = car_makers.Id JOIN car_names ON car_makers.Id = car_names.MakeId JOIN cars_data ON car_names.MakeId = cars_data.Id GROUP BY model_list.Model ORDER BY COUNT(DISTINCT cars_data.Id) DESC LIMIT 1
SELECT COUNT(*) FROM cars_data WHERE Cylinders > 4
SELECT COUNT(*) FROM cars_data WHERE Cylinders > 4
SELECT COUNT(*) FROM cars_data WHERE Year = 1980
SELECT COUNT(*) FROM cars_data WHERE Year = 1980
SELECT COUNT(*) FROM car_makers cm JOIN car_names cn ON cm.Id = cn.MakeId JOIN model_list ml ON cn.Model = ml.Model WHERE cm.FullName = 'American Motor Company'
SELECT COUNT(*) FROM car_makers cm JOIN model_list ml ON cm.Id = ml.Maker WHERE cm.FullName = 'American Motor Company'
SELECT cm.FullName, cm.Id FROM car_makers cm JOIN model_list ml ON cm.Id = ml.Maker GROUP BY cm.Id, cm.FullName HAVING COUNT(*) > 3
SELECT cm.Id, cm.Maker FROM car_makers cm JOIN model_list ml ON cm.Id = ml.Maker GROUP BY cm.Id, cm.Maker HAVING COUNT(*) > 3
SELECT DISTINCT car_names.Model FROM car_names JOIN car_makers ON car_names.MakeId = car_makers.Id JOIN cars_data ON car_names.MakeId = cars_data.Id WHERE (car_makers.FullName = 'General Motors' OR cars_data.Weight > 3500)
SELECT DISTINCT car_names.Model FROM car_names JOIN car_makers ON car_names.MakeId = car_makers.Id JOIN cars_data ON car_names.MakeId = cars_data.Id WHERE car_makers.Maker = 'General Motors' OR cars_data.Weight > 3500
SELECT DISTINCT cars_data.Year FROM cars_data WHERE cars_data.Weight >= 3000 AND cars_data.Weight <= 4000
SELECT DISTINCT Year FROM cars_data WHERE Weight < 4000 AND Weight > 3000
SELECT Horsepower FROM cars_data WHERE Accelerate = (SELECT MAX(Accelerate) FROM cars_data)
SELECT Horsepower FROM cars_data WHERE Accelerate = (SELECT MAX(Accelerate) FROM cars_data)
SELECT c.Cylinders FROM cars_data c JOIN car_names cn ON c.Id = cn.MakeId JOIN model_list ml ON cn.Model = ml.Model JOIN car_makers cm ON ml.Maker = cm.Id JOIN countries co ON cm.Country = co.CountryId JOIN continents con ON co.Continent = con.ContId WHERE ml.Model = 'volvo' ORDER BY c.Accelerate ASC LIMIT 1
SELECT MIN(CAST(c.cylinders AS INTEGER)) FROM cars_data c JOIN car_names cn ON c.Id = cn.MakeId JOIN model_list ml ON cn.Model = ml.Model JOIN car_makers cm ON ml.Maker = cm.Id JOIN countries co ON cm.Country = co.CountryId JOIN continents con ON co.Continent = con.ContId WHERE cm.Maker = 'volvo' ORDER BY c.Accelerate ASC LIMIT 1
SELECT COUNT(*) FROM cars_data WHERE Accelerate > (SELECT MAX(Accelerate) FROM cars_data WHERE Horsepower = (SELECT MAX(Horsepower) FROM cars_data))
SELECT COUNT(*) AS car_count FROM cars_data WHERE Accelerate > (SELECT MAX(Accelerate) FROM cars_data WHERE Horsepower = (SELECT MAX(Horsepower) FROM cars_data))
SELECT COUNT(*) AS country_count FROM car_makers cm JOIN countries c ON cm.Country = c.CountryId GROUP BY c.CountryName HAVING COUNT(cm.Id) > 2
SELECT COUNT(*) AS country_count FROM car_makers cm JOIN countries c ON cm.Country = c.CountryId GROUP BY c.CountryName HAVING COUNT(cm.Id) > 2
SELECT COUNT(*) FROM cars_data WHERE Cylinders > 6
SELECT COUNT(*) FROM cars_data WHERE Cylinders > 6
SELECT car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN model_list ON car_names.Model = model_list.Model JOIN car_makers ON model_list.Maker = car_makers.Id JOIN countries ON car_makers.Country = countries.CountryId JOIN continents ON countries.Continent = continents.ContId WHERE cars_data.Cylinders = 4 ORDER BY cars_data.Horsepower DESC LIMIT 1
SELECT car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId JOIN car_makers ON car_names.MakeId = car_makers.Id JOIN model_list ON car_names.Model = model_list.Model WHERE cars_data.Cylinders = 4 ORDER BY cars_data.Horsepower DESC LIMIT 1
SELECT 1
SELECT car_names.MakeId, car_names.Model FROM cars_data JOIN car_names ON cars_data.Id = car_names.MakeId WHERE Horsepower > (SELECT MIN(Horsepower) FROM cars_data) AND Cylinders < 4
SELECT 1
SELECT MAX(cars_data.MPG) AS max_mpg FROM cars_data WHERE cars_data.Cylinders = 8 OR cars_data.Year < 1980
SELECT DISTINCT cn.Model FROM cars_data cd JOIN car_names cn ON cd.Id = cn.MakeId JOIN car_makers cm ON cn.MakeId = cm.Id WHERE cd.Weight < 3500 AND cm.Maker != 'Ford Motor Company'
SELECT 1
SELECT 1
SELECT 1
SELECT cm.Id, cm.Maker FROM car_makers cm JOIN model_list ml ON cm.Id = ml.Maker GROUP BY cm.Id, cm.Maker HAVING COUNT(ml.ModelId) >= 2
SELECT cm.Id, cm.Maker FROM car_makers cm JOIN model_list ml ON cm.Id = ml.Maker JOIN car_names cn ON ml.Model = cn.Model JOIN cars_data cd ON cn.MakeId = cd.Id GROUP BY cm.Id, cm.Maker HAVING COUNT(DISTINCT ml.Model) >= 2 AND COUNT(*) > 3
SELECT 1
SELECT 1
SELECT Country FROM airlines WHERE Airline = 'JetBlue Airways'
SELECT a.Country FROM airlines a WHERE a.Airline = 'Jetblue Airways'
SELECT Abbreviation FROM airlines WHERE Airline = 'JetBlue Airways'
SELECT a.Abbreviation FROM airlines a WHERE a.Airline = 'Jetblue Airways'
SELECT a.Airline, a.Abbreviation FROM airlines a JOIN airports ap ON a.Country = ap.Country WHERE ap.Country = 'United States'
SELECT a.Airline, a.Abbreviation FROM airlines a JOIN airports ap ON a.uid = ap.Country WHERE ap.CountryAbbrev = 'US'
SELECT AirportCode, AirportName FROM airports WHERE City LIKE '%Anthony%'
SELECT AirportCode, AirportName FROM airports WHERE City LIKE '%Anthony%'
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
SELECT City, Country FROM airports WHERE AirportCode = 'ALN'
SELECT City, Country FROM airports WHERE AirportCode = 'ALN'
SELECT AirportName FROM airports WHERE AirportCode = 'AKO'
SELECT AirportName FROM airports WHERE AirportCode = 'AKO'
SELECT AirportName FROM airports WHERE City = 'Aberdeen'
SELECT AirportName FROM airports WHERE City = 'Aberdeen'
SELECT COUNT(*) FROM flights WHERE SourceAirport = 'APG'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE a.City = 'APG'
SELECT COUNT(*) FROM flights WHERE DestAirport = 'ATO'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.City = 'ATO'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE a.City = 'Aberdeen'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE a.City = 'Aberdeen'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.City = 'Aberdeen'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.City = 'Aberdeen'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode JOIN airports b ON f.DestAirport = b.AirportCode WHERE a.City = 'Aberdeen' AND b.City = 'Ashley'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode JOIN airports b ON f.DestAirport = b.AirportCode WHERE a.City = 'Aberdeen' AND b.City = 'Ashley'
SELECT COUNT(*) FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode JOIN airports AS dest_airports ON flights.DestAirport = dest_airports.AirportCode JOIN airlines ON flights.Airline = airlines.uid WHERE airlines.Airline = 'JetBlue Airways'
SELECT COUNT(*) FROM flights WHERE Airline = (SELECT uid FROM airlines WHERE Airline = 'Jetblue Airways')
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE f.Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND a.AirportCode = 'ASY'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE f.Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND a.City = 'ASY'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE f.Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND a.City = 'AHD'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE f.Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND a.City = 'AHD'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE f.Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND a.City = 'Aberdeen'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE f.Airline = (SELECT uid FROM airlines WHERE Airline = 'United Airlines') AND a.City = 'Aberdeen'
SELECT 1
SELECT airports.City, COUNT(*) AS frequency FROM flights JOIN airports ON flights.DestAirport = airports.AirportCode GROUP BY airports.City ORDER BY frequency DESC LIMIT 1
SELECT 1
SELECT a.City FROM airports a JOIN flights f ON a.AirportCode = f.SourceAirport GROUP BY a.City ORDER BY COUNT(*) DESC LIMIT 1
SELECT airports.AirportCode FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode GROUP BY airports.AirportCode ORDER BY COUNT(*) DESC LIMIT 1
SELECT 1
SELECT airports.AirportCode FROM flights JOIN airports ON flights.SourceAirport = airports.AirportCode GROUP BY airports.AirportCode ORDER BY COUNT(*) ASC LIMIT 1
SELECT AirportCode FROM airports WHERE AirportCode = ( SELECT SourceAirport FROM flights GROUP BY SourceAirport ORDER BY COUNT(*) ASC LIMIT 1 ) UNION SELECT AirportCode FROM airports WHERE AirportCode = ( SELECT DestAirport FROM flights GROUP BY DestAirport ORDER BY COUNT(*) ASC LIMIT 1 ) ORDER BY AirportCode
SELECT 1
SELECT 1
SELECT a.Abbreviation, a.Country FROM airlines a WHERE a.uid = ( SELECT f.Airline FROM flights f GROUP BY f.Airline ORDER BY COUNT(*) ASC LIMIT 1 )
SELECT a.Abbreviation, a.Country FROM airlines a JOIN flights f ON a.uid = f.Airline GROUP BY a.uid ORDER BY COUNT(*) ASC LIMIT 1
SELECT DISTINCT a.Airline FROM airlines a JOIN flights f ON a.uid = f.Airline WHERE f.SourceAirport = 'AHD'
SELECT DISTINCT a.Airline FROM airlines a JOIN flights f ON a.uid = f.Airline WHERE f.SourceAirport = 'AHD'
SELECT 1
SELECT 1
SELECT DISTINCT a.Airline FROM airlines a JOIN flights f ON a.uid = f.Airline WHERE f.SourceAirport IN ('APG', 'CVO') GROUP BY a.Airline HAVING COUNT(DISTINCT f.SourceAirport) = 2
SELECT DISTINCT f.Airline FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE a.AirportCode IN ('APG', 'CVO') GROUP BY f.Airline HAVING COUNT(DISTINCT a.AirportCode) = 2
SELECT DISTINCT a.Airline FROM airlines a JOIN flights f ON a.uid = f.Airline WHERE f.SourceAirport = 'CVO' AND f.SourceAirport NOT IN (SELECT SourceAirport FROM flights WHERE SourceAirport = 'APG')
SELECT DISTINCT f.Airline FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE a.City = 'CVO' AND f.Airline NOT IN ( SELECT f2.Airline FROM flights f2 JOIN airports a2 ON f2.SourceAirport = a2.AirportCode WHERE a2.City = 'APG' )
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.Airline HAVING COUNT(*) >= 10
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.Airline HAVING COUNT(*) >= 10
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.Airline HAVING COUNT(*) < 200
SELECT airlines.Airline FROM airlines JOIN flights ON airlines.uid = flights.Airline GROUP BY airlines.Airline HAVING COUNT(*) < 200
SELECT f.FlightNo FROM flights f JOIN airlines a ON f.Airline = a.uid WHERE a.Airline = 'United Airlines'
SELECT f.FlightNo FROM flights f JOIN airlines a ON f.Airline = a.uid WHERE a.Airline = 'United Airlines'
SELECT f.FlightNo FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE a.City = 'APG'
SELECT f.FlightNo FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE a.City = 'APG'
SELECT f.FlightNo FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.AirportName = 'APG'
SELECT f.FlightNo FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.AirportCode = 'APG'
SELECT f.FlightNo FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE a.City = 'Aberdeen '
SELECT f.FlightNo FROM flights f JOIN airports a ON f.SourceAirport = a.AirportCode WHERE a.City = 'Aberdeen'
SELECT f.FlightNo FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.City = 'Aberdeen'
SELECT f.FlightNo FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.City = 'Aberdeen'
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.City LIKE 'Aberdeen%' OR a.City LIKE 'Abilene%';
SELECT COUNT(*) FROM flights f JOIN airports a ON f.DestAirport = a.AirportCode WHERE a.City LIKE 'Aberdeen%' OR a.City LIKE 'Abilene%';
SELECT DISTINCT a.AirportName FROM airports a WHERE a.AirportCode NOT IN ( SELECT SourceAirport FROM flights UNION SELECT DestAirport FROM flights )
SELECT DISTINCT a.City, a.AirportCode, a.AirportName FROM airports a WHERE a.AirportCode NOT IN (SELECT SourceAirport FROM flights UNION SELECT DestAirport FROM flights)
SELECT COUNT(*) FROM employee
SELECT COUNT(*) FROM employee
SELECT employee.Name FROM employee ORDER BY employee.Age ASC
SELECT Name FROM employee ORDER BY Age ASC
SELECT employee.City, COUNT(*) AS employee_count FROM employee GROUP BY employee.City
SELECT employee.City, COUNT(*) AS employee_count FROM employee GROUP BY employee.City
SELECT DISTINCT e.City FROM employee e JOIN hiring h ON e.Employee_ID = h.Employee_ID WHERE e.Age < 30 GROUP BY e.City HAVING COUNT(*) > 1
SELECT employee.City FROM employee WHERE employee.Age < 30 GROUP BY employee.City HAVING COUNT(*) > 1
SELECT Location, COUNT(*) AS shop_count FROM shop GROUP BY Location
SELECT Location, COUNT(*) AS shop_count FROM shop GROUP BY Location
SELECT shop.Manager_name, shop.District FROM shop ORDER BY shop.Number_products DESC LIMIT 1
SELECT shop.Manager_name, shop.District FROM shop ORDER BY shop.Number_products DESC LIMIT 1
SELECT MIN(Number_products) AS min_products, MAX(Number_products) AS max_products FROM shop
SELECT MIN(Number_products) AS min_products, MAX(Number_products) AS max_products FROM shop
SELECT shop.Name, shop.Location, shop.District FROM shop ORDER BY shop.Number_products DESC
SELECT Name, Location, District FROM shop ORDER BY Number_products DESC
SELECT Name FROM shop WHERE Number_products > (SELECT AVG(Number_products) FROM shop)
SELECT shop.Name FROM shop WHERE shop.Number_products > (SELECT AVG(shop.Number_products) FROM shop)
SELECT e.Name FROM employee e JOIN evaluation ev ON e.Employee_ID = ev.Employee_ID GROUP BY e.Employee_ID, e.Name ORDER BY COUNT(*) DESC LIMIT 1
SELECT e.Name FROM employee e JOIN evaluation ev ON e.Employee_ID = ev.Employee_ID GROUP BY e.Employee_ID, e.Name ORDER BY COUNT(ev.Employee_ID) DESC LIMIT 1
SELECT e.Name FROM employee e JOIN evaluation ev ON e.Employee_ID = ev.Employee_ID ORDER BY ev.Bonus DESC LIMIT 1
SELECT e.Name FROM employee e JOIN evaluation ev ON e.Employee_ID = ev.Employee_ID ORDER BY ev.Bonus DESC LIMIT 1
SELECT e.Name FROM employee e WHERE e.Employee_ID NOT IN (SELECT Employee_ID FROM evaluation)
SELECT Name FROM employee WHERE Employee_ID NOT IN (SELECT Employee_ID FROM evaluation)
SELECT shop.Name FROM shop JOIN hiring ON shop.Shop_ID = hiring.Shop_ID GROUP BY shop.Shop_ID, shop.Name ORDER BY COUNT(hiring.Employee_ID) DESC LIMIT 1
SELECT shop.Name FROM shop JOIN hiring ON shop.Shop_ID = hiring.Shop_ID GROUP BY shop.Shop_ID ORDER BY COUNT(hiring.Employee_ID) DESC LIMIT 1
SELECT shop.Name FROM shop WHERE shop.Shop_ID NOT IN (SELECT DISTINCT hiring.Shop_ID FROM hiring)
SELECT shop.Name FROM shop WHERE shop.Shop_ID NOT IN (SELECT DISTINCT hiring.Shop_ID FROM hiring)
SELECT shop.Name, COUNT(hiring.Employee_ID) AS number_of_employees FROM shop JOIN hiring ON shop.Shop_ID = hiring.Shop_ID GROUP BY shop.Shop_ID, shop.Name
SELECT shop.Name, COUNT(employee.Employee_ID) AS employee_count FROM shop JOIN hiring ON shop.Shop_ID = hiring.Shop_ID JOIN employee ON hiring.Employee_ID = employee.Employee_ID GROUP BY shop.Shop_ID, shop.Name
SELECT SUM(Bonus) AS total_bonus FROM evaluation
SELECT SUM(Bonus) FROM evaluation
SELECT * FROM hiring
SELECT * FROM hiring
SELECT DISTINCT District FROM shop WHERE Number_products < 3000 OR Number_products > 10000 GROUP BY District HAVING COUNT(*) >= 2;
SELECT DISTINCT district FROM shop WHERE Number_products < 3000 OR Number_products > 10000 GROUP BY district HAVING COUNT(*) >= 2;
SELECT COUNT(DISTINCT shop.Location) AS different_store_locations FROM shop;
SELECT COUNT(DISTINCT shop.Location) AS distinct_store_locations FROM shop;
SELECT COUNT(*) FROM Documents
SELECT COUNT(*) FROM Documents
SELECT Document_ID, Document_Name, Document_Description FROM Documents
SELECT Document_ID, Document_Name, Document_Description FROM Documents
SELECT Document_Name, Template_ID FROM Documents WHERE Document_Description LIKE '%w%'
SELECT Document_Name, Template_ID FROM Documents WHERE Document_Description LIKE '%w%'
SELECT d.Document_ID, t.Template_ID, d.Document_Description FROM Documents d JOIN Templates t ON d.Template_ID = t.Template_ID WHERE d.Document_Name = 'Robbin CV'
SELECT d.Document_ID, t.Template_ID, d.Document_Description FROM Documents d JOIN Templates t ON d.Template_ID = t.Template_ID WHERE d.Document_Name = 'Robbin CV'
SELECT COUNT(DISTINCT t.Template_ID) AS template_count FROM Documents d JOIN Templates t ON d.Template_ID = t.Template_ID
SELECT COUNT(DISTINCT Templates.Template_ID) AS template_count FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID
SELECT COUNT(*) FROM Documents d JOIN Templates t ON d.Template_ID = t.Template_ID JOIN Ref_Template_Types rtt ON t.Template_Type_Code = rtt.Template_Type_Code WHERE rtt.Template_Type_Code = 'PPT'
SELECT COUNT(*) FROM Documents d JOIN Templates t ON d.Template_ID = t.Template_ID JOIN Ref_Template_Types rtt ON t.Template_Type_Code = rtt.Template_Type_Code WHERE rtt.Template_Type_Description = 'Presentation'
SELECT Templates.Template_ID, COUNT(Documents.Document_ID) AS document_count FROM Templates JOIN Documents ON Templates.Template_ID = Documents.Template_ID GROUP BY Templates.Template_ID
SELECT Templates.Template_ID, COUNT(DISTINCT Documents.Document_ID) AS usage_count FROM Templates JOIN Documents ON Templates.Template_ID = Documents.Template_ID GROUP BY Templates.Template_ID
SELECT t.Template_ID, t.Template_Type_Code FROM Templates t JOIN Documents d ON t.Template_ID = d.Template_ID GROUP BY t.Template_ID, t.Template_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT t.Template_ID, t.Template_Type_Code FROM Templates t JOIN Documents d ON t.Template_ID = d.Template_ID GROUP BY t.Template_ID, t.Template_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT DISTINCT t.Template_ID FROM Templates t JOIN Documents d ON t.Template_ID = d.Template_ID GROUP BY t.Template_ID HAVING COUNT(d.Document_ID) > 1
SELECT Template_ID FROM Documents GROUP BY Template_ID HAVING COUNT(*) > 1
SELECT Template_ID FROM Templates WHERE Template_ID NOT IN (SELECT DISTINCT Template_ID FROM Documents)
SELECT Template_ID FROM Templates WHERE Template_ID NOT IN (SELECT DISTINCT Template_ID FROM Documents)
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
SELECT Ref_Template_Types.Template_Type_Code, COUNT(Templates.Template_ID) AS template_count FROM Templates JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code
SELECT Ref_Template_Types.Template_Type_Code, COUNT(Templates.Template_ID) AS template_count FROM Templates JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code
SELECT Template_Type_Code, COUNT(*) AS template_count FROM Templates GROUP BY Template_Type_Code ORDER BY template_count DESC LIMIT 1
SELECT Ref_Template_Types.Template_Type_Code FROM Templates JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT Template_Type_Code FROM Templates GROUP BY Template_Type_Code HAVING COUNT(*) < 3
SELECT Template_Type_Code FROM Templates GROUP BY Template_Type_Code HAVING COUNT(*) < 3
SELECT 1
SELECT MIN(Version_Number) AS lowest_version, Template_Type_Code FROM Templates GROUP BY Template_Type_Code ORDER BY lowest_version ASC LIMIT 1
SELECT 1
SELECT DISTINCT RTT.Template_Type_Code FROM Documents D JOIN Templates T ON D.Template_ID = T.Template_ID JOIN Ref_Template_Types RTT ON T.Template_Type_Code = RTT.Template_Type_Code WHERE D.Document_Name = 'Data base'
SELECT DISTINCT d.Document_Name FROM Documents d JOIN Templates t ON d.Template_ID = t.Template_ID JOIN Ref_Template_Types rtt ON t.Template_Type_Code = rtt.Template_Type_Code WHERE rtt.Template_Type_Code = 'BK'
SELECT DISTINCT d.Document_Name FROM Documents d JOIN Templates t ON d.Template_ID = t.Template_ID JOIN Ref_Template_Types rtt ON t.Template_Type_Code = rtt.Template_Type_Code WHERE rtt.Template_Type_Code = 'BK'
SELECT Ref_Template_Types.Template_Type_Code, COUNT(DISTINCT Documents.Document_ID) AS document_count FROM Ref_Template_Types JOIN Templates ON Ref_Template_Types.Template_Type_Code = Templates.Template_Type_Code JOIN Documents ON Templates.Template_ID = Documents.Template_ID GROUP BY Ref_Template_Types.Template_Type_Code
SELECT Ref_Template_Types.Template_Type_Code, COUNT(DISTINCT Documents.Document_ID) AS document_count FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code
SELECT Ref_Template_Types.Template_Type_Code FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT Ref_Template_Types.Template_Type_Code FROM Documents JOIN Templates ON Documents.Template_ID = Templates.Template_ID JOIN Ref_Template_Types ON Templates.Template_Type_Code = Ref_Template_Types.Template_Type_Code GROUP BY Ref_Template_Types.Template_Type_Code ORDER BY COUNT(*) DESC LIMIT 1
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Code NOT IN ( SELECT DISTINCT Templates.Template_Type_Code FROM Templates INNER JOIN Documents ON Templates.Template_ID = Documents.Template_ID )
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Code NOT IN ( SELECT DISTINCT Templates.Template_Type_Code FROM Templates INNER JOIN Documents ON Templates.Template_ID = Documents.Template_ID )
SELECT Template_Type_Code, Template_Type_Description FROM Ref_Template_Types
SELECT Template_Type_Code, Template_Type_Description FROM Ref_Template_Types
SELECT Template_Type_Description FROM Ref_Template_Types WHERE Template_Type_Code = 'AD'
SELECT Template_Type_Description FROM Ref_Template_Types WHERE Template_Type_Code = 'AD'
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'Book'
SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'Book'
SELECT DISTINCT RTT.Template_Type_Description FROM Templates T JOIN Documents D ON T.Template_ID = D.Template_ID JOIN Ref_Template_Types RTT ON T.Template_Type_Code = RTT.Template_Type_Code
SELECT DISTINCT RTT.Template_Type_Description FROM Templates T JOIN Documents D ON T.Template_ID = D.Template_ID JOIN Ref_Template_Types RTT ON T.Template_Type_Code = RTT.Template_Type_Code
SELECT DISTINCT T.Template_ID FROM Templates T JOIN Ref_Template_Types R ON T.Template_Type_Code = R.Template_Type_Code WHERE R.Template_Type_Description = 'Presentation'
SELECT Template_ID FROM Templates WHERE Template_Type_Code = (SELECT Template_Type_Code FROM Ref_Template_Types WHERE Template_Type_Description = 'Presentation')
SELECT COUNT(*) FROM Paragraphs
SELECT COUNT(*) FROM Paragraphs
SELECT COUNT(*) FROM Paragraphs p JOIN Documents d ON p.Document_ID = d.Document_ID WHERE d.Document_Name = 'Summer Show'
SELECT COUNT(*) FROM Paragraphs p JOIN Documents d ON p.Document_ID = d.Document_ID WHERE d.Document_Name = 'Summer Show'
SELECT Paragraph_ID, Paragraph_Text, Other_Details FROM Paragraphs WHERE Paragraph_Text = 'Korea '
SELECT Paragraph_Text, Other_Details FROM Paragraphs WHERE Paragraph_Text LIKE 'Korea %'
SELECT Paragraphs.Paragraph_ID, Paragraphs.Paragraph_Text FROM Paragraphs JOIN Documents ON Paragraphs.Document_ID = Documents.Document_ID WHERE Documents.Document_Name = 'Welcome to NY'
SELECT Paragraphs.Paragraph_ID, Paragraphs.Paragraph_Text FROM Paragraphs JOIN Documents ON Paragraphs.Document_ID = Documents.Document_ID WHERE Documents.Document_Name = 'Welcome to NY'
SELECT Paragraphs.Paragraph_Text FROM Paragraphs JOIN Documents ON Paragraphs.Document_ID = Documents.Document_ID WHERE Documents.Document_Name = 'Customer reviews'
SELECT Paragraphs.Paragraph_Text FROM Paragraphs JOIN Documents ON Paragraphs.Document_ID = Documents.Document_ID WHERE Documents.Document_Name = 'Customer reviews'
SELECT Documents.Document_ID, COUNT(Paragraphs.Paragraph_ID) AS paragraph_count FROM Documents JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID ORDER BY Documents.Document_ID
SELECT Document_ID, COUNT(*) AS paragraph_count FROM Paragraphs GROUP BY Document_ID ORDER BY Document_ID
SELECT d.Document_ID, d.Document_Name, COUNT(p.Paragraph_ID) AS paragraph_count FROM Documents d LEFT JOIN Paragraphs p ON d.Document_ID = p.Document_ID GROUP BY d.Document_ID, d.Document_Name
SELECT Documents.Document_ID, Documents.Document_Name, COUNT(Paragraphs.Paragraph_ID) AS Paragraph_Count FROM Documents LEFT JOIN Paragraphs ON Documents.Document_ID = Paragraphs.Document_ID GROUP BY Documents.Document_ID, Documents.Document_Name
SELECT DISTINCT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(*) >= 2
SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(*) >= 2
SELECT d.Document_ID, d.Document_Name FROM Documents d JOIN Paragraphs p ON d.Document_ID = p.Document_ID GROUP BY d.Document_ID, d.Document_Name ORDER BY COUNT(p.Paragraph_ID) DESC LIMIT 1
SELECT 1
SELECT Document_ID, COUNT(*) AS paragraph_count FROM Paragraphs GROUP BY Document_ID ORDER BY paragraph_count ASC LIMIT 1
SELECT Document_ID FROM (SELECT Paragraphs.Document_ID, COUNT(*) AS paragraph_count FROM Paragraphs GROUP BY Paragraphs.Document_ID ORDER BY paragraph_count ASC LIMIT 1) AS subquery
SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(*) BETWEEN 1 AND 2
SELECT Document_ID FROM Paragraphs GROUP BY Document_ID HAVING COUNT(*) BETWEEN 1 AND 2
SELECT DISTINCT Paragraphs.Document_ID, Paragraphs.Paragraph_Text FROM Paragraphs WHERE Paragraphs.Paragraph_TEXT IN ('Brazil', 'Ireland')
SELECT DISTINCT Paragraphs.Document_ID FROM Paragraphs WHERE Paragraph_Text = 'Brazil' INTERSECT SELECT Paragraphs.Document_ID FROM Paragraphs WHERE Paragraph_Text = 'Ireland'
SELECT COUNT(*) FROM teacher
SELECT COUNT(*) FROM teacher
SELECT t.Name FROM teacher t ORDER BY CAST(t.Age AS REAL) ASC
SELECT teacher.Name FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID ORDER BY CAST(teacher.Age AS REAL) ASC
SELECT teacher.Age, teacher.Hometown FROM teacher
SELECT teacher.Name, teacher.Age, teacher.Hometown FROM teacher
SELECT teacher.Name FROM teacher WHERE teacher.Hometown != 'Little Lever Urban District'
SELECT teacher.Name FROM teacher WHERE teacher.Hometown != 'Little Lever Urban District'
SELECT teacher.Name FROM teacher WHERE CAST(teacher.Age AS INTEGER) IN (32, 33)
SELECT teacher.Name FROM teacher WHERE CAST(teacher.Age AS INTEGER) IN (32, 33)
SELECT teacher.Hometown FROM teacher WHERE CAST(teacher.Age AS INTEGER) = (SELECT MIN(CAST(teacher.Age AS INTEGER)) FROM teacher)
SELECT teacher.Hometown FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID JOIN course ON course_arrange.Course_ID = course.Course_ID ORDER BY CAST(teacher.Age AS REAL) ASC LIMIT 1
SELECT teacher.Hometown, COUNT(*) AS teacher_count FROM teacher GROUP BY teacher.Hometown
SELECT teacher.Hometown, COUNT(*) AS teacher_count FROM teacher GROUP BY teacher.Hometown
SELECT teacher.Hometown, COUNT(*) as teacher_count FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID GROUP BY teacher.Hometown ORDER BY teacher_count DESC LIMIT 1
SELECT teacher.Hometown, COUNT(*) AS occurrence_count FROM teacher GROUP BY teacher.Hometown ORDER BY occurrence_count DESC LIMIT 1
SELECT hometown FROM teacher GROUP BY hometown HAVING COUNT(*) >= 2
SELECT teacher.Hometown FROM teacher GROUP BY teacher.Hometown HAVING COUNT(*) >= 2
SELECT teacher.Name, course.Course FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID JOIN course ON course_arrange.Course_ID = course.Course_ID
SELECT teacher.Name, course.Course FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID JOIN course ON course_arrange.Course_ID = course.Course_ID
SELECT teacher.Name, course.Course FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID JOIN course ON course_arrange.Course_ID = course.Course_ID ORDER BY teacher.Name ASC
SELECT teacher.Name, course.Course FROM course JOIN course_arrange ON course.Course_ID = course_arrange.Course_ID JOIN teacher ON course_arrange.Teacher_ID = teacher.Teacher_ID ORDER BY teacher.Name ASC
SELECT teacher.Name FROM course JOIN course_arrange ON course.Course_ID = course_arrange.Course_ID JOIN teacher ON course_arrange.Teacher_ID = teacher.Teacher_ID WHERE course.Course = 'Math'
SELECT teacher.Name FROM teacher INNER JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID INNER JOIN course ON course_arrange.Course_ID = course.Course_ID WHERE course.Course = 'Math'
SELECT 1
SELECT teacher.Name, COUNT(course_arrange.Course_ID) AS course_count FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID GROUP BY teacher.Teacher_ID, teacher.Name
SELECT teacher.Name FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID GROUP BY teacher.Teacher_ID HAVING COUNT(DISTINCT course_arrange.Course_ID) >= 2
SELECT teacher.Name FROM teacher JOIN course_arrange ON teacher.Teacher_ID = course_arrange.Teacher_ID GROUP BY teacher.Teacher_ID HAVING COUNT(DISTINCT course_arrange.Course_ID) >= 2
SELECT t.Name FROM teacher t WHERE t.Teacher_ID NOT IN (SELECT Teacher_ID FROM course_arrange)
SELECT t.Name FROM teacher t WHERE NOT EXISTS ( SELECT 1 FROM course_arrange ca WHERE ca.Teacher_ID = t.Teacher_ID )
SELECT COUNT(*) FROM visitor WHERE Age < 30
SELECT visitor.Name FROM visitor WHERE visitor.Level_of_membership > 4 ORDER BY visitor.Level_of_membership DESC
SELECT AVG(v.Age) AS average_age FROM visitor v JOIN visit vis ON v.ID = vis.visitor_ID WHERE v.Level_of_membership <= 4
SELECT visitor.Name, visitor.Level_of_membership FROM visitor WHERE visitor.Level_of_membership > 4 ORDER BY visitor.Age DESC
SELECT Museum_ID, Name FROM museum ORDER BY Num_of_Staff DESC LIMIT 1
SELECT AVG(m.Num_of_Staff) FROM museum m WHERE m.Open_Year < '2009'
SELECT museum.Open_Year, museum.Num_of_Staff FROM museum WHERE museum.Name = 'Plaza Museum'
SELECT m.Name FROM museum m WHERE m.Num_of_Staff > ( SELECT MIN(m2.Num_of_Staff) FROM museum m2 WHERE CAST(m2.Open_Year AS INTEGER) > 2010 )
SELECT visitor.ID, visitor.Name, visitor.Age FROM visitor JOIN visit ON visitor.ID = visit.visitor_ID GROUP BY visitor.ID, visitor.Name, visitor.Age HAVING COUNT(*) > 1
SELECT visitor.ID, visitor.Name, visitor.Level_of_membership FROM visitor JOIN visit ON visitor.ID = visit.visitor_ID GROUP BY visitor.ID, visitor.Name, visitor.Level_of_membership ORDER BY SUM(visit.Total_spent) DESC LIMIT 1
SELECT museum.Museum_ID, museum.Name FROM museum JOIN visit ON museum.Museum_ID = visit.Museum_ID GROUP BY museum.Museum_ID ORDER BY COUNT(*) DESC LIMIT 1
SELECT museum.Name FROM museum WHERE museum.Museum_ID NOT IN (SELECT Museum_ID FROM visit)
SELECT v.Name, v.Age FROM visitor v JOIN visit vis ON v.ID = vis.visitor_ID ORDER BY vis.Num_of_Ticket DESC LIMIT 1
SELECT AVG(Num_of_Ticket) AS average_tickets, MAX(Num_of_Ticket) AS max_tickets FROM visit
SELECT SUM(v.Total_spent) AS total_ticket_expense FROM visit v JOIN visitor vis ON v.visitor_ID = vis.ID WHERE vis.Level_of_membership = 1
SELECT v.Name FROM visitor v JOIN visit v1 ON v.ID = v1.visitor_ID JOIN museum m1 ON v1.Museum_ID = m1.Museum_ID JOIN visit v2 ON v.ID = v2.visitor_ID JOIN museum m2 ON v2.Museum_ID = m2.Museum_ID WHERE CAST(m1.Open_Year AS INTEGER) < 2009 AND CAST(m2.Open_Year AS INTEGER) > 2011 GROUP BY v.ID, v.Name HAVING COUNT(DISTINCT m1.Museum_ID) = 2
SELECT COUNT(*) FROM visitor v WHERE v.ID NOT IN (SELECT DISTINCT visit.visitor_ID FROM visit WHERE visit.Museum_ID IN (SELECT Museum_ID FROM museum WHERE Open_Year > '2010'))
SELECT COUNT(*) FROM museum WHERE Open_Year > '2013' OR Open_Year < '2008'
SELECT COUNT(*) AS total_players FROM players
SELECT COUNT(*) FROM players
SELECT COUNT(*) AS total_matches FROM matches
SELECT COUNT(*) AS match_count FROM matches
SELECT p.first_name, p.birth_date FROM players p WHERE p.country_code = 'USA'
SELECT first_name, birth_date FROM players WHERE country_code = 'USA'
SELECT AVG(loser_age) AS avg_losers_age, AVG(winner_age) AS avg_winners_age FROM matches
SELECT AVG(loser_age) AS avg_losers_age, AVG(winner_age) AS avg_winners_age FROM matches
SELECT AVG(winner_rank) AS average_rank FROM matches
SELECT AVG(m.winner_rank) AS average_rank FROM matches m
SELECT MAX(loser_rank) AS highest_rank FROM matches
SELECT MAX(loser_rank) AS best_rank FROM matches
SELECT COUNT(DISTINCT p.country_code) FROM players p
SELECT COUNT(DISTINCT country_code) FROM players
SELECT COUNT(DISTINCT loser_name) FROM matches
SELECT COUNT(DISTINCT loser_name) FROM matches
SELECT tourney_name FROM matches GROUP BY tourney_name HAVING COUNT(*) > 10
SELECT DISTINCT tourney_name FROM matches GROUP BY tourney_name HAVING COUNT(*) > 10
SELECT DISTINCT winner_name FROM matches WHERE winner_id IN ( SELECT winner_id FROM matches WHERE strftime('%Y', tourney_date) = '2013' ) AND winner_id IN ( SELECT winner_id FROM matches WHERE strftime('%Y', tourney_date) = '2016' );
SELECT DISTINCT winner_name FROM matches WHERE year IN (2013, 2016) GROUP BY winner_name HAVING COUNT(DISTINCT year) = 2
SELECT COUNT(*) AS match_count FROM matches WHERE year IN (2013, 2016)
SELECT COUNT(*) AS match_count FROM matches WHERE strftime('%Y', tourney_date) IN ('2013', '2016')
SELECT DISTINCT p.country_code, p.first_name FROM matches m JOIN players p ON m.winner_id = p.player_id WHERE m.tourney_name IN ('WTA Championships', 'Australian Open') GROUP BY p.player_id, p.country_code, p.first_name
SELECT DISTINCT p.first_name, p.country_code FROM matches m JOIN players p ON m.winner_id = p.player_id WHERE m.tourney_name IN ('WTA Championships', 'Australian Open') GROUP BY p.player_id
SELECT p.first_name, p.country_code FROM players p ORDER BY CAST(p.birth_date AS TEXT) ASC LIMIT 1
SELECT p.first_name, p.country_code FROM players p ORDER BY CAST(p.birth_date AS TEXT) ASC LIMIT 1
SELECT first_name, last_name FROM players ORDER BY birth_date
SELECT p.first_name || ' ' || p.last_name AS full_name, p.birth_date FROM players p ORDER BY p.birth_date
SELECT first_name, last_name FROM players WHERE hand = 'L' ORDER BY birth_date
SELECT first_name || ' ' || last_name AS full_name, birth_date FROM players WHERE hand = 'L' ORDER BY birth_date
SELECT p.first_name, p.country_code FROM players p JOIN matches m ON p.player_id = m.loser_id GROUP BY p.player_id ORDER BY COUNT(m.tourney_id) DESC, p.player_id LIMIT 1
SELECT p.first_name, p.country_code FROM players p JOIN rankings r ON p.player_id = r.player_id GROUP BY p.player_id ORDER BY SUM(r.tours) DESC LIMIT 1
SELECT year, COUNT(*) AS match_count FROM matches GROUP BY year ORDER BY match_count DESC LIMIT 1
SELECT year, COUNT(*) AS match_count FROM matches GROUP BY year ORDER BY match_count DESC LIMIT 1
SELECT p.first_name || ' ' || p.last_name AS name, m.winner_rank_points AS rank_points FROM matches m JOIN players p ON m.winner_id = p.player_id GROUP BY m.winner_id ORDER BY COUNT(*) DESC LIMIT 1
SELECT p.first_name || ' ' || p.last_name AS winner_name, COUNT(*) AS total_matches, r.ranking_points FROM matches m JOIN players p ON m.winner_id = p.player_id JOIN rankings r ON p.player_id = r.player_id GROUP BY p.player_id ORDER BY total_matches DESC, r.ranking_points DESC LIMIT 1
SELECT winner_name FROM matches JOIN players ON matches.winner_id = players.player_id WHERE matches.tourney_name = 'Australian Open' ORDER BY winner_rank_points DESC LIMIT 1
SELECT 1
SELECT loser_name, winner_name FROM matches WHERE minutes = (SELECT MAX(minutes) FROM matches)
SELECT winner_name, loser_name FROM matches m JOIN players p1 ON m.winner_id = p1.player_id JOIN players p2 ON m.loser_id = p2.player_id ORDER BY minutes DESC LIMIT 1
SELECT 1
SELECT p.first_name, AVG(r.ranking) AS average_ranking FROM players p JOIN rankings r ON p.player_id = r.player_id GROUP BY p.player_id, p.first_name
SELECT p.first_name, SUM(r.ranking_points) AS total_ranking_points FROM players p LEFT JOIN rankings r ON p.player_id = r.player_id GROUP BY p.player_id, p.first_name
SELECT p.first_name, SUM(r.ranking_points) AS total_ranking_points FROM players p LEFT JOIN rankings r ON p.player_id = r.player_id GROUP BY p.player_id, p.first_name
SELECT p.country_code, COUNT(*) AS player_count FROM players p GROUP BY p.country_code
SELECT country_code, COUNT(*) AS player_count FROM players GROUP BY country_code
SELECT country_code FROM players GROUP BY country_code ORDER BY COUNT(*) DESC LIMIT 1
SELECT p.country_code, COUNT(*) AS player_count FROM players p GROUP BY p.country_code ORDER BY player_count DESC LIMIT 1
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(*) > 50
SELECT country_code FROM players GROUP BY country_code HAVING COUNT(*) > 50
SELECT ranking_date, COUNT(*) AS total_tours FROM rankings GROUP BY ranking_date
SELECT ranking_date, COUNT(*) AS total_tours FROM rankings GROUP BY ranking_date
SELECT year, COUNT(*) AS match_count FROM matches GROUP BY year
SELECT year, COUNT(*) AS match_count FROM matches GROUP BY year
SELECT p.first_name || ' ' || p.last_name AS name, m.winner_rank FROM matches m JOIN players p ON m.winner_id = p.player_id ORDER BY CAST(m.winner_age AS REAL) ASC LIMIT 3
SELECT p.first_name, p.last_name, m.winner_rank FROM matches m JOIN players p ON m.winner_id = p.player_id ORDER BY CAST(m.winner_age AS REAL) ASC LIMIT 3
SELECT COUNT(DISTINCT m.winner_id) FROM matches m JOIN players p ON m.winner_id = p.player_id WHERE m.tourney_name = 'WTA Championships' AND p.hand = 'L'
SELECT COUNT(*) AS left_handed_wta_championships FROM matches JOIN players ON matches.winner_id = players.player_id WHERE matches.tourney_name = 'WTA Championships' AND players.hand = 'L'
SELECT p.first_name, p.country_code, p.birth_date FROM matches m JOIN players p ON m.winner_id = p.player_id ORDER BY m.winner_rank_points DESC LIMIT 1
SELECT p.first_name, p.country_code, p.birth_date FROM players p JOIN matches m ON p.player_id = m.winner_id GROUP BY p.player_id ORDER BY SUM(m.winner_rank_points) DESC LIMIT 1
SELECT hand, COUNT(*) AS player_count FROM players GROUP BY hand
SELECT hand, COUNT(*) AS player_count FROM players GROUP BY hand
SELECT COUNT(*) FROM ship WHERE disposition_of_ship = 'Captured'
SELECT s.name, s.tonnage FROM ship s ORDER BY s.name DESC
SELECT name, date, result FROM battle
SELECT MAX(killed) AS max_deaths, MIN(killed) AS min_deaths FROM death
SELECT AVG(killed) AS average_injuries FROM death
SELECT d.note, d.killed, d.injured, s.name AS ship_name, s.tonnage FROM death d JOIN ship s ON d.caused_by_ship_id = s.id WHERE s.tonnage = 't'
SELECT battle.name, battle.result FROM battle WHERE bulgarian_commander != 'Boril'
SELECT DISTINCT b.id, b.name FROM battle b JOIN ship s ON b.id = s.lost_in_battle WHERE s.ship_type = 'Brig'
SELECT b.id, b.name FROM battle b JOIN ship s ON b.id = s.lost_in_battle JOIN death d ON s.id = d.caused_by_ship_id GROUP BY b.id, b.name HAVING SUM(d.killed) > 10
SELECT d.caused_by_ship_id, s.name FROM death d JOIN ship s ON d.caused_by_ship_id = s.id GROUP BY d.caused_by_ship_id, s.name ORDER BY SUM(d.injured) DESC LIMIT 1
SELECT DISTINCT battle.name FROM battle WHERE battle.bulgarian_commander = 'Kaloyan' AND battle.latin_commander = 'Baldwin I'
SELECT COUNT(DISTINCT result) FROM battle
SELECT COUNT(*) FROM battle b WHERE NOT EXISTS (SELECT 1 FROM ship s WHERE s.lost_in_battle = b.id AND s.tonnage = '225')
SELECT b.name, b.date FROM battle b JOIN ship s1 ON b.id = s1.lost_in_battle JOIN ship s2 ON b.id = s2.lost_in_battle WHERE s1.name = 'Lettice' AND s2.name = 'HMS Atalanta'
SELECT b.name, b.result, b.bulgarian_commander FROM battle b LEFT JOIN ship s ON b.id = s.lost_in_battle WHERE s.location = 'English Channel' AND s.id IS NULL
SELECT death.note FROM death WHERE death.note LIKE '%East%'
SELECT address_id, line_1, line_2 FROM Addresses
SELECT line_1, line_2 FROM Addresses
SELECT COUNT(*) FROM Courses
SELECT COUNT(*) FROM Courses
SELECT course_description FROM Courses WHERE course_name = 'math'
SELECT course_description FROM Courses WHERE course_name = 'math'
SELECT address.zip_postcode FROM Addresses address WHERE address.city = 'Port Chelsea'
SELECT zip_postcode FROM Addresses WHERE city = 'Port Chelsea'
SELECT d.department_name, d.department_id, COUNT(*) AS degree_count FROM Departments d JOIN Degree_Programs dp ON d.department_id = dp.department_id GROUP BY d.department_id, d.department_name ORDER BY degree_count DESC LIMIT 1
SELECT 1
SELECT COUNT(DISTINCT dp.department_id) FROM Degree_Programs dp
SELECT COUNT(DISTINCT dp.department_id) FROM Degree_Programs dp
SELECT COUNT(DISTINCT degree_summary_name) FROM Degree_Programs
SELECT COUNT(DISTINCT degree_summary_name) FROM Degree_Programs
SELECT COUNT(*) FROM Degree_Programs dp JOIN Departments d ON dp.department_id = d.department_id WHERE d.department_name = 'engineering'
SELECT COUNT(*) AS degree_count FROM Degree_Programs WHERE department_id = (SELECT department_id FROM Departments WHERE department_name = 'engineering')
SELECT section_name, section_description FROM Sections
SELECT section_name, section_description FROM Sections
SELECT course_name, course_id FROM Courses WHERE course_id IN (SELECT course_id FROM Sections GROUP BY course_id HAVING COUNT(*) <= 2)
SELECT course_name, course_id FROM Courses WHERE course_id IN (SELECT course_id FROM Sections GROUP BY course_id HAVING COUNT(*) < 2)
SELECT section_name FROM Sections ORDER BY section_name DESC
SELECT section_name FROM Sections ORDER BY section_name DESC
SELECT semester_name, semester_id FROM Semesters WHERE semester_id = ( SELECT sem.semester_id FROM Student_Enrolment se JOIN Semesters sem ON se.semester_id = sem.semester_id GROUP BY sem.semester_id ORDER BY COUNT(*) DESC LIMIT 1 )
SELECT s.semester_name, s.semester_id FROM Semesters s JOIN Student_Enrolment se ON s.semester_id = se.semester_id GROUP BY s.semester_id, s.semester_name ORDER BY COUNT(se.student_id) DESC LIMIT 1
SELECT department_description FROM Departments WHERE department_name LIKE '%the computer%'
SELECT department_description FROM Departments WHERE department_name LIKE '%computer%'
SELECT s.first_name, s.middle_name, s.last_name, s.student_id FROM Students s JOIN Student_Enrolment se ON s.student_id = se.student_id GROUP BY s.student_id, s.first_name, s.middle_name, s.last_name HAVING COUNT(DISTINCT se.degree_program_id) = 2;
SELECT s.first_name, s.middle_name, s.last_name, s.student_id FROM Students s JOIN Student_Enrolment se ON s.student_id = se.student_id GROUP BY s.student_id HAVING COUNT(DISTINCT se.degree_program_id) = 2
SELECT s.first_name, s.middle_name, s.last_name FROM Students s JOIN Student_Enrolment se ON s.student_id = se.student_id JOIN Degree_Programs dp ON se.degree_program_id = dp.degree_program_id WHERE dp.degree_summary_name = 'Bachelor'
SELECT s.first_name, s.middle_name, s.last_name FROM Students s JOIN Student_Enrolment se ON s.student_id = se.student_id JOIN Degree_Programs dp ON se.degree_program_id = dp.degree_program_id WHERE dp.degree_summary_name = 'Bachelor'
SELECT dp.degree_summary_name FROM Degree_Programs dp JOIN Student_Enrolment se ON dp.degree_program_id = se.degree_program_id GROUP BY dp.degree_summary_name ORDER BY COUNT(se.student_id) DESC LIMIT 1
SELECT dp.degree_summary_name, COUNT(se.student_id) AS student_count FROM Degree_Programs dp JOIN Student_Enrolment se ON dp.degree_program_id = se.degree_program_id GROUP BY dp.degree_summary_name ORDER BY student_count DESC LIMIT 1
SELECT dp.degree_program_id, dp.degree_summary_name FROM Degree_Programs dp JOIN Student_Enrolment se ON dp.degree_program_id = se.degree_program_id GROUP BY dp.degree_program_id, dp.degree_summary_name ORDER BY COUNT(se.student_id) DESC LIMIT 1
SELECT dp.degree_program_id, dp.degree_summary_name FROM Degree_Programs dp JOIN Student_Enrolment se ON dp.degree_program_id = se.degree_program_id GROUP BY dp.degree_program_id, dp.degree_summary_name ORDER BY COUNT(se.student_enrolment_id) DESC LIMIT 1
SELECT s.student_id, s.first_name, s.middle_name, s.last_name, COUNT(*) AS enrollment_count FROM Students s JOIN Student_Enrolment se ON s.student_id = se.student_id GROUP BY s.student_id, s.first_name, s.middle_name, s.last_name ORDER BY enrollment_count DESC LIMIT 1
SELECT s.first_name, s.middle_name, s.last_name, s.student_id, COUNT(*) as enrollment_count FROM Students s JOIN Student_Enrolment se ON s.student_id = se.student_id GROUP BY s.student_id, s.first_name, s.middle_name, s.last_name ORDER BY enrollment_count DESC LIMIT 1
SELECT semester_name FROM Semesters WHERE semester_id NOT IN (SELECT DISTINCT semester_id FROM Student_Enrolment)
SELECT s.semester_name FROM Semesters s WHERE NOT EXISTS ( SELECT 1 FROM Student_Enrolment se WHERE se.semester_id = s.semester_id )
SELECT DISTINCT c.course_name FROM Courses c JOIN Student_Enrolment_Courses sec ON c.course_id = sec.course_id JOIN Student_Enrolment se ON sec.student_enrolment_id = se.student_enrolment_id
SELECT DISTINCT c.course_name FROM Courses c JOIN Student_Enrolment_Courses sec ON c.course_id = sec.course_id JOIN Student_Enrolment se ON sec.student_enrolment_id = se.student_enrolment_id
SELECT c.course_name FROM Courses c JOIN Student_Enrolment_Courses sec ON c.course_id = sec.course_id JOIN Student_Enrolment se ON sec.student_enrolment_id = se.student_enrolment_id GROUP BY c.course_id, c.course_name ORDER BY COUNT(*) DESC LIMIT 1
SELECT c.course_name FROM Courses c JOIN Student_Enrolment_Courses sec ON c.course_id = sec.course_id JOIN Student_Enrolment se ON sec.student_enrolment_id = se.student_enrolment_id GROUP BY c.course_id, c.course_name ORDER BY COUNT(se.student_id) DESC LIMIT 1
SELECT s.last_name FROM Students s WHERE s.current_address_id IS NOT NULL AND s.current_address_id IN ( SELECT a.address_id FROM Addresses a WHERE a.state_province_county = 'North Carolina' ) AND s.student_id NOT IN ( SELECT se.student_id FROM Student_Enrolment se )
SELECT s.last_name FROM Students s WHERE s.current_address_id = (SELECT address_id FROM Addresses WHERE state_province_county = 'North Carolina') AND s.permanent_address_id = (SELECT address_id FROM Addresses WHERE state_province_county = 'North Carolina') AND s.student_id NOT IN (SELECT student_id FROM Student_Enrolment)
SELECT t.transcript_id, t.transcript_date FROM Transcripts t JOIN Transcript_Contents tc ON t.transcript_id = tc.transcript_id GROUP BY t.transcript_id, t.transcript_date HAVING COUNT(*) >= 2
SELECT t.transcript_id, t.transcript_date FROM Transcripts t JOIN Transcript_Contents tc ON t.transcript_id = tc.transcript_id GROUP BY t.transcript_id, t.transcript_date HAVING COUNT(*) >= 2
SELECT cell_mobile_number FROM Students WHERE first_name = 'Timmothy' AND last_name = 'Ward'
SELECT s.cell_mobile_number FROM Students s WHERE s.first_name = 'Timmothy' AND s.last_name = 'Ward'
SELECT first_name, middle_name, last_name FROM Students WHERE date_first_registered = (SELECT MIN(date_first_registered) FROM Students)
SELECT first_name, middle_name, last_name FROM Students WHERE date_first_registered = (SELECT MIN(date_first_registered) FROM Students)
SELECT 1
SELECT s.first_name, s.middle_name, s.last_name FROM Students s WHERE s.date_left IS NOT NULL ORDER BY s.date_left ASC LIMIT 1
SELECT DISTINCT s.first_name FROM Students s WHERE s.current_address_id != s.permanent_address_id
SELECT s.first_name FROM Students s WHERE s.permanent_address_id != s.current_address_id
SELECT a.address_id, a.line_1, a.line_2, a.line_3 FROM Addresses a JOIN Students s ON s.current_address_id = a.address_id GROUP BY a.address_id, a.line_1, a.line_2, a.line_3 ORDER BY COUNT(s.student_id) DESC LIMIT 1
SELECT a.address_id, a.line_1, a.line_2 FROM Addresses a JOIN Students s ON s.current_address_id = a.address_id GROUP BY a.address_id ORDER BY COUNT(s.student_id) DESC LIMIT 1
SELECT AVG(transcript_date) AS average_transcript_date FROM Transcripts
SELECT AVG(transcript_date) FROM Transcripts
SELECT MIN(transcript_date) AS first_transcript_date, other_details AS details FROM Transcripts
SELECT MIN(transcript_date) AS earliest_date, other_details AS details FROM Transcripts
SELECT COUNT(*) FROM Transcripts
SELECT COUNT(*) FROM Transcripts
SELECT MAX(transcript_date) AS last_transcript_release_date FROM Transcripts
SELECT MAX(transcript_date) AS last_transcript_date FROM Transcripts
SELECT MAX(cnt) as max_transcripts, student_course_id FROM ( SELECT student_course_id, COUNT(DISTINCT tc.transcript_id) as cnt FROM Transcript_Contents tc GROUP BY student_course_id )
SELECT MAX(transcript_count) AS max_transcripts, min(student_course_id) AS enrollment_id FROM ( SELECT sc.student_course_id, COUNT(DISTINCT tc.transcript_id) AS transcript_count FROM Student_Enrolment_Courses sc JOIN Transcript_Contents tc ON sc.student_course_id = tc.student_course_id GROUP BY sc.student_course_id )
SELECT t.transcript_date, t.transcript_id FROM Transcripts t JOIN Transcript_Contents tc ON t.transcript_id = tc.transcript_id JOIN Student_Enrolment_Courses sec ON tc.student_course_id = sec.student_course_id GROUP BY t.transcript_id ORDER BY COUNT(*) ASC LIMIT 1
SELECT t.transcript_id, t.transcript_date FROM Transcripts t JOIN Transcript_Contents tc ON t.transcript_id = tc.transcript_id GROUP BY t.transcript_id, t.transcript_date ORDER BY COUNT(*) ASC LIMIT 1
SELECT DISTINCT sem.semester_name FROM Semesters sem JOIN Student_Enrolment se ON sem.semester_id = se.semester_id JOIN Degree_Programs dp ON se.degree_program_id = dp.degree_program_id WHERE dp.degree_summary_name IN ('Master', 'Bachelor') GROUP BY sem.semester_name HAVING COUNT(DISTINCT dp.degree_summary_name) = 2
SELECT DISTINCT se.semester_id FROM Student_Enrolment se JOIN Degree_Programs dp ON se.degree_program_id = dp.degree_program_id WHERE dp.degree_summary_name IN ('Master', 'Bachelor') GROUP BY se.semester_id HAVING COUNT(DISTINCT dp.degree_summary_name) = 2
SELECT COUNT(DISTINCT a.address_id) FROM Students s JOIN Addresses a ON s.current_address_id = a.address_id
SELECT DISTINCT address_id, line_1, line_2, line_3, city, zip_postcode, state_province_county, country, other_address_details FROM Addresses WHERE address_id IN (SELECT current_address_id FROM Students) OR address_id IN (SELECT permanent_address_id FROM Students)
SELECT * FROM Students ORDER BY first_name DESC, middle_name DESC, last_name DESC
SELECT s.other_student_details FROM Students s ORDER BY s.last_name, s.first_name, s.middle_name DESC
SELECT section_name, section_description, other_details FROM Sections WHERE section_name = 'h'
SELECT section_description FROM Sections WHERE section_name = 'h'
SELECT DISTINCT s.first_name FROM Students s WHERE s.permanent_address_id = (SELECT address_id FROM Addresses WHERE country = 'Haiti') OR s.cell_mobile_number = '09700166582'
SELECT DISTINCT s.first_name FROM Students s WHERE s.permanent_address_id IS NOT NULL AND EXISTS ( SELECT 1 FROM Addresses a WHERE a.address_id = s.permanent_address_id AND a.country = 'Haiti' ) OR s.cell_mobile_number = '09700166582';
SELECT Title FROM Cartoon ORDER BY Title
SELECT Title FROM Cartoon ORDER BY Title
SELECT * FROM Cartoon WHERE Directed_by = 'Ben Jones'
SELECT Title FROM Cartoon WHERE Directed_by = 'Ben Jones'
SELECT COUNT(*) FROM Cartoon WHERE Written_by = 'Joseph Kuhr'
SELECT COUNT(*) FROM Cartoon WHERE Written_by = 'Joseph Kuhr'
SELECT Cartoon.Title, Cartoon.Directed_by, Cartoon.Original_air_date FROM Cartoon ORDER BY Cartoon.Original_air_date
SELECT Title, Directed_by FROM Cartoon ORDER BY Original_air_date
SELECT Title FROM Cartoon WHERE Directed_by IN ('Ben Jones', 'Brandon Vietti')
SELECT Title FROM Cartoon WHERE Directed_by IN ('Ben Jones', 'Brandon Vietti')
SELECT TV_Channel.Country, COUNT(*) AS num_channels FROM TV_Channel GROUP BY TV_Channel.Country ORDER BY num_channels DESC LIMIT 1;
SELECT TV_Channel.Country, COUNT(*) AS channel_count FROM TV_Channel GROUP BY TV_Channel.Country ORDER BY channel_count DESC LIMIT 1
SELECT COUNT(DISTINCT series_name) AS series_count, COUNT(DISTINCT Content) AS content_count FROM TV_Channel
SELECT COUNT(DISTINCT series_name || ' - ' || Content) AS different_series_contents FROM TV_Channel
SELECT Content FROM TV_Channel WHERE series_name = 'Sky Radio'
SELECT Content FROM TV_Channel WHERE series_name = 'Sky Radio'
SELECT Package_Option FROM TV_Channel WHERE series_name = 'Sky Radio'
SELECT DISTINCT TV_Channel.Package_Option FROM TV_Channel WHERE TV_Channel.series_name = 'Sky Radio'
SELECT COUNT(*) FROM TV_Channel WHERE Language = 'English'
SELECT COUNT(*) FROM TV_Channel WHERE Language = 'English'
SELECT TV_Channel.Language, COUNT(*) AS num_channels FROM TV_Channel GROUP BY TV_Channel.Language ORDER BY num_channels ASC LIMIT 1
SELECT Language, COUNT(*) AS channel_count FROM TV_Channel GROUP BY Language ORDER BY channel_count ASC LIMIT 1
SELECT Language, COUNT(*) AS channel_count FROM TV_Channel GROUP BY Language
SELECT Language, COUNT(*) AS channel_count FROM TV_Channel GROUP BY Language
SELECT TV_Channel.series_name FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE Cartoon.Title = 'The Rise of the Blue Beetle!'
SELECT TV_Channel.series_name FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE Cartoon.Title = 'The Rise of the Blue Beetle!';
SELECT Cartoon.Title FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE TV_Channel.series_name = 'Sky Radio'
SELECT Cartoon.Title FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE TV_Channel.series_name = 'Sky Radio'
SELECT Episode FROM TV_series ORDER BY Rating DESC
SELECT TV_series.Episode, CAST(TV_series.Rating AS REAL) AS Rating FROM TV_series ORDER BY Rating DESC
SELECT Episode, Rating FROM TV_series ORDER BY Rating DESC LIMIT 3
SELECT Episode, Rating FROM TV_series ORDER BY CAST(Rating AS REAL) DESC LIMIT 3
SELECT MIN(Share) AS min_share, MAX(Share) AS max_share FROM TV_series
SELECT MAX(Share) AS max_share, MIN(Share) AS min_share FROM TV_series
SELECT TV_series.Air_Date FROM TV_series WHERE TV_series.Episode = 'A Love of a Lifetime';
SELECT Air_Date FROM TV_series WHERE Episode = 'A Love of a Lifetime'
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Love of a Lifetime'
SELECT Weekly_Rank FROM TV_series WHERE Episode = 'A Love of a Lifetime'
SELECT TV_Channel.series_name FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_series.Episode = 'A Love of a Lifetime'
SELECT tv_series.Episode FROM Cartoon JOIN TV_series ON Cartoon.id = TV_series.Channel WHERE tv_series.Episode = 'A Love of a Lifetime'
SELECT tv_series.Episode FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_Channel.series_name = 'Sky Radio'
SELECT tv_series.Episode FROM TV_series JOIN TV_Channel ON TV_series.Channel = TV_Channel.id WHERE TV_Channel.series_name = 'Sky Radio'
SELECT Directed_by, COUNT(*) AS cartoon_count FROM Cartoon GROUP BY Directed_by
SELECT Directed_by, COUNT(*) AS cartoon_count FROM Cartoon GROUP BY Directed_by
SELECT Cartoon.Production_code, TV_Channel.series_name FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id ORDER BY CAST(strftime('%Y-%m-%d', Cartoon.Original_air_date) AS REAL) DESC LIMIT 1
SELECT Cartoon.Production_code, TV_Channel.series_name FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id ORDER BY CAST(strftime('%Y-%m-%d', Cartoon.Original_air_date) AS REAL) DESC LIMIT 1
SELECT TV_Channel.Package_Option, TV_Channel.series_name FROM TV_Channel WHERE TV_Channel.Hight_definition_TV = 'yes'
SELECT TV_Channel.Package_Option, TV_series.Episode FROM TV_Channel JOIN TV_series ON TV_Channel.id = TV_series.Channel WHERE TV_Channel.Hight_definition_TV = 'yes'
SELECT DISTINCT TV_Channel.Country FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE Cartoon.Written_by = 'Todd Casey'
SELECT DISTINCT TV_Channel.Country FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id JOIN TV_series ON TV_series.Channel = TV_Channel.id WHERE Cartoon.Written_by = 'Todd Casey'
SELECT DISTINCT tv_channel.Country FROM TV_Channel tv_channel WHERE tv_channel.id NOT IN ( SELECT cartoon.Channel FROM Cartoon cartoon JOIN TV_series tv_series ON cartoon.Channel = tv_series.Channel WHERE cartoon.Written_by = 'Todd Casey' )
SELECT DISTINCT TV_Channel.Country FROM Cartoon JOIN TV_Channel ON Cartoon.Channel = TV_Channel.id WHERE Cartoon.Written_by != 'Todd Casey'
SELECT 1
SELECT 1
SELECT Pixel_aspect_ratio_PAR, Country FROM TV_Channel WHERE Language != 'English'
SELECT Pixel_aspect_ratio_PAR, Country FROM TV_Channel WHERE Language != 'English'
SELECT 1
SELECT TV_Channel.id FROM TV_Channel GROUP BY TV_Channel.id HAVING COUNT(*) > 2
SELECT 1
SELECT 1
SELECT 1
SELECT 1
SELECT COUNT(*) FROM poker_player
SELECT COUNT(*) FROM poker_player
SELECT Earnings FROM poker_player ORDER BY Earnings DESC
SELECT Earnings FROM poker_player ORDER BY Earnings DESC
SELECT poker_player.Final_Table_Made, poker_player.Best_Finish FROM poker_player
SELECT poker_player.Final_Table_Made, poker_player.Best_Finish FROM poker_player
SELECT AVG(poker_player.Earnings) AS average_earnings FROM poker_player
SELECT AVG(Earnings) AS average_earnings FROM poker_player
SELECT money_rank FROM poker_player WHERE earnings = (SELECT MAX(earnings) FROM poker_player)
SELECT money_rank FROM poker_player ORDER BY earnings DESC LIMIT 1
SELECT MAX(Final_Table_Made) FROM poker_player WHERE Earnings < 200000
SELECT MAX(poker_player.Final_Table_Made) FROM poker_player WHERE poker_player.Earnings < 200000
SELECT people.Name FROM people JOIN poker_player ON people.People_ID = poker_player.People_ID
SELECT people.Name FROM people JOIN poker_player ON people.People_ID = poker_player.People_ID
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE poker_player.Earnings > 300000
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE poker_player.Earnings > 300000
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Final_Table_Made ASC
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Final_Table_Made ASC
SELECT people.Birth_Date FROM poker_player, people WHERE poker_player.People_ID = people.People_ID AND poker_player.Earnings = (SELECT MIN(Earnings) FROM poker_player)
SELECT people.Birth_Date FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings ASC LIMIT 1
SELECT pp.Money_Rank FROM poker_player pp JOIN people p ON pp.People_ID = p.People_ID ORDER BY p.Height DESC LIMIT 1
SELECT pp.Money_Rank FROM poker_player pp JOIN people p ON pp.People_ID = p.People_ID ORDER BY p.Height DESC LIMIT 1
SELECT AVG(poker_player.Earnings) AS average_earnings FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE people.Height > 200
SELECT AVG(poker_player.Earnings) AS average_earnings FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID WHERE people.Height > 200
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings DESC
SELECT people.Name FROM poker_player JOIN people ON poker_player.People_ID = people.People_ID ORDER BY poker_player.Earnings DESC
SELECT people.Nationality, COUNT(*) AS num_people FROM people GROUP BY people.Nationality
SELECT people.Nationality, COUNT(*) AS people_count FROM people GROUP BY people.Nationality
SELECT 1
SELECT Nationality FROM people GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2
SELECT Nationality FROM people GROUP BY Nationality HAVING COUNT(*) >= 2
SELECT people.Name, people.Birth_Date FROM people ORDER BY people.Name ASC
SELECT people.Name, people.Birth_Date FROM people ORDER BY people.Name
SELECT people.Name FROM people WHERE Nationality != 'Russia'
SELECT people.Name FROM people WHERE people.Nationality != 'Russia'
SELECT Name FROM people WHERE People_ID NOT IN (SELECT Poker_Player_ID FROM poker_player)
SELECT Name FROM people WHERE People_ID NOT IN (SELECT People_ID FROM poker_player)
SELECT COUNT(DISTINCT people.Nationality) FROM people
SELECT COUNT(DISTINCT people.Nationality) FROM people
SELECT COUNT(DISTINCT state) FROM AREA_CODE_STATE
SELECT c.contestant_number, c.contestant_name FROM CONTESTANTS c ORDER BY c.contestant_name DESC
SELECT v.vote_id, v.phone_number, v.state FROM VOTES v
SELECT 1
SELECT MAX(votes.created) FROM votes JOIN area_code_state ON votes.state = area_code_state.state WHERE area_code_state.state = 'CA'
SELECT DISTINCT c.contestant_name FROM CONTESTANTS c WHERE c.contestant_name != 'Jessie Alloway'
SELECT DISTINCT v.state, strftime('%Y-%m-%d %H:%M:%S', v.created) AS create_time FROM votes v
SELECT c.contestant_number, c.contestant_name FROM CONTESTANTS c JOIN VOTES v ON c.contestant_number = v.contestant_number GROUP BY c.contestant_number, c.contestant_name HAVING COUNT(*) >= 2
SELECT 1
SELECT COUNT(*) AS vote_count FROM VOTES WHERE state IN ('NY', 'CA')
SELECT COUNT(*) FROM CONTESTANTS c WHERE c.contestant_number NOT IN (SELECT DISTINCT contestant_number FROM VOTES)
SELECT area_code FROM AREA_CODE_STATE WHERE state = ( SELECT state FROM VOTES GROUP BY state ORDER BY COUNT(*) DESC LIMIT 1 )
SELECT v.created, v.state, v.phone_number FROM VOTES v JOIN CONTESTANTS c ON v.contestant_number = c.contestant_number WHERE c.contestant_name = 'Tabatha Gehling'
SELECT 1
SELECT contestant_name FROM CONTESTANTS WHERE contestant_name LIKE '%Al%'
SELECT Name FROM country WHERE IndepYear > 1950
SELECT Name FROM country WHERE IndepYear > 1950
SELECT COUNT(*) FROM country WHERE GovernmentForm = 'Republic'
SELECT COUNT(*) FROM country WHERE GovernmentForm LIKE '%Republic%'
SELECT SUM(SurfaceArea) AS total_surface_area FROM country WHERE Region = 'Caribbean'
SELECT SUM(SurfaceArea) FROM country WHERE Region = 'Caribbean'
SELECT country.Continent FROM country WHERE country.Name = 'Anguilla'
SELECT country.Continent FROM country WHERE country.Name = 'Anguilla'
SELECT country.Region FROM city JOIN country ON city.CountryCode = country.Code WHERE city.Name = 'Kabul'
SELECT country.Region FROM city JOIN country ON city.CountryCode = country.Code WHERE city.Name = 'Kabul'
SELECT language FROM countrylanguage WHERE CountryCode = 'AW' ORDER BY Percentage DESC LIMIT 1
SELECT cl.Language FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.Name = 'Aruba' ORDER BY cl.Percentage DESC LIMIT 1
SELECT city.Population, country.LifeExpectancy FROM city JOIN country ON city.CountryCode = country.Code WHERE country.Name = 'Brazil'
SELECT Population, LifeExpectancy FROM country WHERE Code = 'BR'
SELECT Region, Population FROM country WHERE Name = 'Angola'
SELECT Region, Population FROM country WHERE Name = 'Angola'
SELECT AVG(LifeExpectancy) AS AverageLifeExpectancy FROM country WHERE Region = 'Central Africa'
SELECT AVG(c.LifeExpectancy) AS average_life_expectancy FROM country c WHERE c.Region = 'Central Africa'
SELECT country.Name FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code WHERE country.Region = 'Southern and Central Asia' ORDER BY country.LifeExpectancy ASC LIMIT 1
SELECT country.Name FROM country WHERE country.Continent = 'Asia' ORDER BY country.LifeExpectancy ASC LIMIT 1
SELECT SUM(city.Population) AS total_population, MAX(country.GNP) AS max_gnp FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON countrylanguage.CountryCode = country.Code WHERE country.Continent = 'Asia'
SELECT COUNT(*) AS total_population, MAX(GNP) AS largest_GNP FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode WHERE country.Continent = 'Asia'
SELECT AVG(c.LifeExpectancy) AS average_life_expectancy FROM country c JOIN countrylanguage cl ON c.Code = cl.CountryCode WHERE c.Continent = 'Africa' AND c.GovernmentForm = 'Republic'
SELECT AVG(LifeExpectancy) AS AverageLifeExpectancy FROM country WHERE Continent = 'Africa' AND GovernmentForm LIKE '%Republic%';
SELECT SUM(SurfaceArea) AS total_surface_area FROM country WHERE Continent IN ('Asia', 'Europe')
SELECT SUM(SurfaceArea) AS total_surface_area FROM country WHERE Continent IN ('Asia', 'Europe')
SELECT COUNT(*) FROM city WHERE District = 'Gelderland'
SELECT SUM(Population) FROM city WHERE District = 'Gelderland'
SELECT AVG(GNP) AS average_GNP, SUM(Population) AS total_population FROM country WHERE GovernmentForm LIKE '%US Territory%'
SELECT AVG(c.GNP) AS mean_GNP, SUM(c.Population) AS total_population FROM country c WHERE c.GovernmentForm LIKE '%US%'
SELECT COUNT(DISTINCT Language) FROM countrylanguage
SELECT COUNT(DISTINCT Language) FROM countrylanguage
SELECT COUNT(DISTINCT GovernmentForm) FROM country WHERE Continent = 'Africa'
SELECT COUNT(DISTINCT GovernmentForm) FROM country WHERE Continent = 'Africa'
SELECT COUNT(*) FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.Name = 'Aruba'
SELECT COUNT(*) FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.Name = 'Aruba'
SELECT COUNT(*) FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.Name = 'Afghanistan' AND cl.IsOfficial = 'T'
SELECT COUNT(*) FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.Name = 'Afghanistan' AND cl.IsOfficial = 'T'
SELECT country.Name FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code GROUP BY countrylanguage.CountryCode, country.Name ORDER BY COUNT(countrylanguage.Language) DESC LIMIT 1
SELECT country.Name FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code GROUP BY country.Code, country.Name ORDER BY COUNT(countrylanguage.Language) DESC LIMIT 1
SELECT country.Continent, COUNT(DISTINCT countrylanguage.Language) AS language_count FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code GROUP BY country.Continent ORDER BY language_count DESC LIMIT 1
SELECT country.Continent, COUNT(DISTINCT countrylanguage.Language) AS language_count FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code GROUP BY country.Continent ORDER BY language_count DESC LIMIT 1
SELECT COUNT(*) AS country_count FROM countrylanguage cl1 JOIN countrylanguage cl2 ON cl1.CountryCode = cl2.CountryCode WHERE cl1.Language = 'English' AND cl2.Language = 'Dutch' AND cl1.IsOfficial = 'T' AND cl2.IsOfficial = 'T'
SELECT COUNT(*) AS english_dutch_nations FROM countrylanguage WHERE Language = 'English' AND IsOfficial = 'T' AND CountryCode IN ( SELECT CountryCode FROM countrylanguage WHERE Language = 'Dutch' AND IsOfficial = 'T' )
SELECT DISTINCT country.Name FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code WHERE countrylanguage.Language = 'English' AND countrylanguage.Language = 'French'
SELECT DISTINCT c.Name FROM city c JOIN countrylanguage cl ON c.CountryCode = cl.CountryCode JOIN country co ON cl.CountryCode = co.Code WHERE cl.Language = 'English' AND EXISTS ( SELECT 1 FROM countrylanguage cl2 WHERE cl2.CountryCode = c.CountryCode AND cl2.Language = 'French' )
SELECT DISTINCT country.Name FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code WHERE countrylanguage.Language = 'English' AND countrylanguage.IsOfficial = 'T' AND EXISTS ( SELECT 1 FROM countrylanguage WHERE countrylanguage.CountryCode = country.Code AND countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T' )
SELECT DISTINCT c.Name FROM city c JOIN countrylanguage cl ON c.CountryCode = cl.CountryCode JOIN country co ON cl.CountryCode = co.Code WHERE cl.Language = 'English' AND cl.IsOfficial = 'T' AND cl.Language = 'French' AND cl.IsOfficial = 'T'
SELECT COUNT(DISTINCT c.Continent) FROM country c JOIN countrylanguage cl ON c.Code = cl.CountryCode WHERE cl.Language = 'Chinese'
SELECT 1
SELECT DISTINCT country.Region FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code WHERE countrylanguage.Language IN ('English', 'Dutch') AND countrylanguage.IsOfficial = 'T'
SELECT 1
SELECT DISTINCT country.Name FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code WHERE countrylanguage.Language = 'English' AND countrylanguage.IsOfficial = 'T' OR countrylanguage.Language = 'Dutch' AND countrylanguage.IsOfficial = 'T'
SELECT DISTINCT country.Name FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code WHERE countrylanguage.Language IN ('English', 'Dutch') AND countrylanguage.IsOfficial = 'T'
SELECT cl.Language, SUM(cl.Percentage) AS total_percentage FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.Continent = 'Asia' GROUP BY cl.Language ORDER BY total_percentage DESC LIMIT 1
SELECT cl.Language FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.Continent = 'Asia' GROUP BY cl.Language ORDER BY COUNT(*) DESC LIMIT 1
SELECT DISTINCT cl.Language FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.GovernmentForm = 'Republic' GROUP BY cl.Language HAVING COUNT(DISTINCT cl.CountryCode) = 1
SELECT DISTINCT cl.Language FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.GovernmentForm = 'Republic' GROUP BY cl.Language HAVING COUNT(DISTINCT cl.CountryCode) = 1
SELECT 1
SELECT 1
SELECT country.Name, country.Population, country.LifeExpectancy FROM country WHERE country.Continent = 'Asia' ORDER BY country.SurfaceArea DESC LIMIT 1
SELECT country.Name, country.Population, country.LifeExpectancy FROM country WHERE country.Continent = 'Asia' ORDER BY country.SurfaceArea DESC LIMIT 1
SELECT AVG(c.LifeExpectancy) AS average_life_expectancy FROM country c JOIN countrylanguage cl ON c.Code = cl.CountryCode WHERE cl.IsOfficial = 'F'
SELECT AVG(c.LifeExpectancy) AS mean_life_expectancy FROM country c JOIN countrylanguage cl ON c.Code = cl.CountryCode WHERE cl.IsOfficial = 'F'
SELECT SUM(c.Population) AS total_population FROM city c JOIN country co ON c.CountryCode = co.Code JOIN countrylanguage cl ON co.Code = cl.CountryCode WHERE cl.Language != 'English' AND cl.IsOfficial = 'F'
SELECT COUNT(*) AS total_population FROM city c JOIN country co ON c.CountryCode = co.Code JOIN countrylanguage cl ON co.Code = cl.CountryCode WHERE cl.Language != 'English'
SELECT cl.Language FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.HeadOfState = 'Beatrix' AND cl.IsOfficial = 'T'
SELECT cl.Language FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.HeadOfState = 'Beatrix' AND cl.IsOfficial = 'T'
SELECT COUNT(DISTINCT cl.Language) FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.IndepYear < 1930 AND cl.IsOfficial = 'T'
SELECT COUNT(DISTINCT cl.Language) FROM countrylanguage cl JOIN country c ON cl.CountryCode = c.Code WHERE c.IndepYear < 1930 AND cl.IsOfficial = 'T'
SELECT Name FROM country WHERE SurfaceArea > ( SELECT MAX(SurfaceArea) FROM country WHERE Continent = 'Europe' )
SELECT Name AS CountryName FROM country WHERE SurfaceArea > (SELECT MAX(SurfaceArea) FROM country WHERE Continent = 'Europe')
SELECT country.Name FROM country WHERE country.Continent = 'Africa' AND country.Population < ( SELECT MIN(country2.Population) FROM country country2 WHERE country2.Continent = 'Asia' )
SELECT DISTINCT c.Name FROM city AS c JOIN country AS co ON c.CountryCode = co.Code WHERE co.Continent = 'Africa' AND co.Population < ( SELECT MAX(country.Population) FROM country WHERE country.Continent = 'Asia' )
SELECT country.Name FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code WHERE country.Region = 'Asia' AND country.Population > ( SELECT MAX(country2.Population) FROM country country2 WHERE country2.Region = 'Africa' )
SELECT country.Name FROM country WHERE country.Continent = 'Asia' AND country.Population > ( SELECT MAX(country2.Population) FROM country country2 WHERE country2.Continent = 'Africa' )
SELECT DISTINCT cl.CountryCode FROM countrylanguage cl WHERE cl.Language != 'English'
SELECT DISTINCT cl.CountryCode FROM countrylanguage cl WHERE cl.Language != 'English'
SELECT DISTINCT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language != 'English'
SELECT DISTINCT cl.CountryCode FROM countrylanguage cl WHERE cl.Language != 'English'
SELECT country.Code FROM country WHERE country.GovernmentForm != 'Republic' AND NOT EXISTS ( SELECT 1 FROM countrylanguage WHERE countrylanguage.CountryCode = country.Code AND countrylanguage.Language = 'English' AND countrylanguage.IsOfficial = 'T' )
SELECT country.Code FROM country WHERE country.GovernmentForm != 'Republic' AND NOT EXISTS ( SELECT 1 FROM countrylanguage WHERE countrylanguage.CountryCode = country.Code AND countrylanguage.Language = 'English' AND countrylanguage.IsOfficial = 'T' )
SELECT DISTINCT c.Name FROM city c JOIN country co ON c.CountryCode = co.Code JOIN countrylanguage cl ON co.Code = cl.CountryCode WHERE co.Continent = 'Europe' AND cl.Language = 'English' AND cl.IsOfficial = 'F'
SELECT city.Name FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode WHERE country.Continent = 'Europe' AND countrylanguage.IsOfficial = 'F' AND countrylanguage.Language = 'English'
SELECT DISTINCT c.Name FROM city c JOIN country co ON c.CountryCode = co.Code JOIN countrylanguage cl ON co.Code = cl.CountryCode WHERE co.Continent = 'Asia' AND cl.Language = 'Chinese' AND cl.IsOfficial = 'T'
SELECT DISTINCT city.Name FROM city JOIN country ON city.CountryCode = country.Code JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode WHERE country.Continent = 'Asia' AND countrylanguage.IsOfficial = 'T' AND countrylanguage.Language = 'Chinese'
SELECT country.Name, country.IndepYear, country.SurfaceArea FROM country ORDER BY country.Population ASC LIMIT 1
SELECT Name, IndepYear, SurfaceArea FROM country WHERE Population = (SELECT MIN(Population) FROM country)
SELECT country.Population, country.Name, country.HeadOfState FROM country ORDER BY country.SurfaceArea DESC LIMIT 1
SELECT country.Name, country.Population, country.HeadOfState FROM country ORDER BY country.SurfaceArea DESC LIMIT 1
SELECT country.Name, COUNT(*) AS num_languages FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code GROUP BY country.Code, country.Name HAVING COUNT(*) >= 3
SELECT country.Name, COUNT(*) AS language_count FROM country JOIN countrylanguage ON countrylanguage.CountryCode = country.Code GROUP BY country.Name HAVING COUNT(*) > 2
SELECT District, COUNT(*) AS city_count FROM city WHERE Population > (SELECT AVG(Population) FROM city) GROUP BY District
SELECT District, COUNT(*) AS city_count FROM city WHERE Population > (SELECT AVG(Population) FROM city) GROUP BY District
SELECT country.GovernmentForm, SUM(city.Population) AS TotalPopulation FROM city JOIN country ON city.CountryCode = country.Code GROUP BY country.GovernmentForm HAVING AVG(country.LifeExpectancy) > 72
SELECT country.GovernmentForm, SUM(city.Population) AS TotalPopulation FROM city JOIN country ON city.CountryCode = country.Code WHERE CAST(country.LifeExpectancy AS REAL) > 72 GROUP BY country.GovernmentForm
SELECT 1
SELECT country.Continent, SUM(city.Population) AS total_population, AVG(country.LifeExpectancy) AS average_life_expectancy FROM city JOIN country ON city.CountryCode = country.Code GROUP BY country.Continent HAVING AVG(country.LifeExpectancy) < 72
SELECT Name, SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 5
SELECT Name, SurfaceArea FROM country ORDER BY SurfaceArea DESC LIMIT 5
SELECT country.Name FROM country ORDER BY country.Population DESC LIMIT 3
SELECT country.Name FROM country ORDER BY country.Population DESC LIMIT 3
SELECT country.Name FROM country ORDER BY country.Population ASC LIMIT 3
SELECT country.Name FROM country ORDER BY country.Population ASC LIMIT 3
SELECT COUNT(*) FROM country WHERE Continent = 'Asia'
SELECT COUNT(*) FROM country WHERE Continent = 'Asia'
SELECT country.Name FROM country WHERE country.Continent = 'Europe' AND country.Population = 80000
SELECT country.Name FROM country WHERE country.Continent = 'Europe' AND country.Population = 80000
SELECT SUM(Population) AS total_population, AVG(SurfaceArea) AS average_area FROM country WHERE Continent = 'North America' AND SurfaceArea > 3000
SELECT SUM(Population) AS total_population, AVG(SurfaceArea) AS average_surface_area FROM country WHERE Continent = 'North America' AND SurfaceArea > 3000
SELECT Name FROM city WHERE Population BETWEEN 160000 AND 900000
SELECT Name FROM city WHERE Population BETWEEN 160000 AND 900000
SELECT language, COUNT(*) AS country_count FROM countrylanguage GROUP BY language ORDER BY country_count DESC LIMIT 1
SELECT cl.Language, COUNT(DISTINCT c.ID) AS country_count FROM countrylanguage cl JOIN city c ON cl.CountryCode = c.CountryCode GROUP BY cl.Language ORDER BY country_count DESC LIMIT 1
SELECT countrylanguage.Language, countrylanguage.Percentage, country.Name FROM countrylanguage JOIN country ON countrylanguage.CountryCode = country.Code ORDER BY countrylanguage.Percentage DESC, country.Name LIMIT 1
SELECT country.Code, countrylanguage.Language FROM countrylanguage JOIN country ON countrylanguage.CountryCode = country.Code GROUP BY countrylanguage.CountryCode, countrylanguage.Language ORDER BY countrylanguage.CountryCode, countrylanguage.Language
SELECT COUNT(*) FROM countrylanguage WHERE Language = 'Spanish' AND IsOfficial = 'T' ORDER BY Percentage DESC LIMIT 1
SELECT COUNT(*) FROM countrylanguage WHERE Language = 'Spanish' AND IsOfficial = 'T'
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE countrylanguage.Language = 'Spanish' ORDER BY countrylanguage.Percentage DESC LIMIT 1
SELECT countrylanguage.CountryCode FROM countrylanguage WHERE Language = 'Spanish' AND IsOfficial = 'T'
SELECT COUNT(*) FROM conductor
SELECT COUNT(*) FROM conductor
SELECT Name FROM conductor ORDER BY Age ASC
SELECT Name FROM conductor ORDER BY Age
SELECT Name FROM conductor WHERE Nationality != 'USA'
SELECT Name FROM conductor WHERE Nationality != 'USA'
SELECT orchestra.Record_Company FROM orchestra ORDER BY orchestra.Year_of_Founded DESC
SELECT orchestra.Record_Company FROM orchestra ORDER BY orchestra.Year_of_Founded DESC
SELECT AVG(Attendance) AS average_attendance FROM show
SELECT AVG(Attendance) AS average_attendance FROM show
SELECT MAX(Share) AS max_share, MIN(Share) AS min_share FROM performance WHERE Type != 'Live final'
SELECT MAX(Share) AS max_share, MIN(Share) AS min_share FROM performance WHERE Type != 'Live final'
SELECT COUNT(DISTINCT Nationality) FROM conductor
SELECT COUNT(DISTINCT Nationality) FROM conductor
SELECT Name FROM conductor ORDER BY Year_of_Work DESC
SELECT c.Name FROM conductor c ORDER BY c.Year_of_Work DESC
SELECT Name FROM conductor ORDER BY Year_of_Work DESC LIMIT 1
SELECT c.Name FROM conductor c ORDER BY c.Year_of_Work DESC LIMIT 1
SELECT c.Name, o.Orchestra FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID
SELECT c.Name, o.Orchestra FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID
SELECT DISTINCT c.Name FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID GROUP BY c.Conductor_ID HAVING COUNT(*) > 1
SELECT DISTINCT c.Name FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID GROUP BY c.Conductor_ID HAVING COUNT(*) > 1
SELECT c.Name FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID GROUP BY c.Conductor_ID, c.Name ORDER BY COUNT(*) DESC LIMIT 1
SELECT c.Name FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID GROUP BY c.Conductor_ID, c.Name ORDER BY COUNT(*) DESC LIMIT 1
SELECT DISTINCT c.Name FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID WHERE o.Year_of_Founded > 2008
SELECT DISTINCT c.Name FROM conductor c JOIN orchestra o ON c.Conductor_ID = o.Conductor_ID WHERE o.Year_of_Founded > 2008
SELECT Record_Company, COUNT(*) AS Orchestra_Count FROM orchestra GROUP BY Record_Company
SELECT Record_Company, COUNT(*) AS Orchestra_Count FROM orchestra GROUP BY Record_Company
SELECT Major_Record_Format, COUNT(*) AS record_count FROM orchestra GROUP BY Major_Record_Format ORDER BY record_count ASC
SELECT Major_Record_Format, COUNT(*) AS frequency FROM orchestra GROUP BY Major_Record_Format ORDER BY frequency DESC
SELECT Record_Company, COUNT(*) AS orchestra_count FROM orchestra GROUP BY Record_Company ORDER BY orchestra_count DESC LIMIT 1
SELECT Record_Company, COUNT(*) AS orchestra_count FROM orchestra GROUP BY Record_Company ORDER BY orchestra_count DESC LIMIT 1
SELECT o.orchestra FROM orchestra o WHERE o.orchestra_id NOT IN (SELECT performance_id FROM performance)
SELECT o.Orchestra FROM orchestra o LEFT JOIN performance p ON o.Orchestra_ID = p.Orchestra_ID WHERE p.Performance_ID IS NULL
SELECT DISTINCT orchestra.Record_Company FROM orchestra WHERE orchestra.Year_of_Founded < 2003 OR orchestra.Year_of_Founded > 2003
SELECT DISTINCT Record_Company FROM orchestra WHERE Year_of_Founded < 2003 INTERSECT SELECT DISTINCT Record_Company FROM orchestra WHERE Year_of_Founded > 2003
SELECT COUNT(*) FROM orchestra WHERE Major_Record_Format IN ('CD', 'DVD')
SELECT COUNT(*) FROM orchestra WHERE Major_Record_Format IN ('CD', 'DVD')
SELECT DISTINCT o.Year_of_Founded FROM orchestra o JOIN performance p ON o.Orchestra_ID = p.Orchestra_ID GROUP BY o.Orchestra_ID HAVING COUNT(*) > 1
SELECT o.Year_of_Founded FROM orchestra o JOIN performance p ON o.Orchestra_ID = p.Orchestra_ID GROUP BY o.Orchestra_ID HAVING COUNT(p.Performance_ID) > 1
SELECT COUNT(*) FROM Highschooler
SELECT COUNT(*) FROM Highschooler
SELECT name, grade FROM Highschooler
SELECT name, grade FROM Highschooler
SELECT grade FROM Highschooler
SELECT ID, name, grade FROM Highschooler
SELECT grade FROM Highschooler WHERE name = 'Kyle'
SELECT grade FROM Highschooler WHERE name = 'Kyle'
SELECT name FROM Highschooler WHERE grade = 10
SELECT name FROM Highschooler WHERE grade = 10
SELECT ID FROM Highschooler WHERE name = 'Kyle'
SELECT ID FROM Highschooler WHERE name = 'Kyle'
SELECT COUNT(*) FROM Highschooler WHERE grade IN (9, 10)
SELECT COUNT(*) FROM Highschooler WHERE grade IN (9, 10)
SELECT grade, COUNT(*) AS num_highschoolers FROM Highschooler GROUP BY grade
SELECT grade, COUNT(*) AS student_count FROM Highschooler GROUP BY grade
SELECT 1
SELECT grade FROM Highschooler GROUP BY grade ORDER BY COUNT(*) DESC LIMIT 1
SELECT grade, COUNT(*) AS student_count FROM Highschooler GROUP BY grade HAVING COUNT(*) >= 4
SELECT grade, COUNT(*) AS student_count FROM Highschooler GROUP BY grade HAVING COUNT(*) >= 4
SELECT student_id, COUNT(*) AS num_friends FROM Friend GROUP BY student_id
SELECT Highschooler.ID, COUNT(Friend.friend_id) AS friend_count FROM Highschooler LEFT JOIN Friend ON Highschooler.ID = Friend.student_id GROUP BY Highschooler.ID
SELECT h.name, COUNT(f.friend_id) AS num_friends FROM Highschooler h LEFT JOIN Friend f ON h.ID = f.student_id GROUP BY h.ID, h.name
SELECT h.name, COUNT(f.friend_id) AS friend_count FROM Highschooler h LEFT JOIN Friend f ON h.ID = f.student_id GROUP BY h.ID, h.name
SELECT h.name FROM Highschooler h JOIN Friend f ON h.ID = f.student_id GROUP BY h.ID, h.name ORDER BY COUNT(f.friend_id) DESC LIMIT 1
SELECT h.name FROM Highschooler h JOIN Friend f ON h.ID = f.student_id GROUP BY h.ID, h.name ORDER BY COUNT(f.friend_id) DESC LIMIT 1
SELECT name FROM Highschooler WHERE ID IN ( SELECT friend_id FROM Friend GROUP BY friend_id HAVING COUNT(*) >= 3 )
SELECT name FROM Highschooler WHERE ID IN ( SELECT friend_id FROM Friend GROUP BY friend_id HAVING COUNT(*) >= 3 )
SELECT DISTINCT h.name FROM Highschooler h JOIN Friend f ON h.ID = f.student_id JOIN Highschooler h2 ON h2.ID = f.friend_id WHERE h2.name = 'Kyle'
SELECT DISTINCT h.name FROM Highschooler h JOIN Friend f ON h.ID = f.student_id WHERE f.friend_id IN (SELECT ID FROM Highschooler WHERE name = 'Kyle')
SELECT COUNT(*) FROM Highschooler h WHERE h.name = 'Kyle' AND h.ID IN (SELECT student_id FROM Friend)
SELECT 1
SELECT ID FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT ID FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT name FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT name FROM Highschooler WHERE ID NOT IN (SELECT student_id FROM Friend)
SELECT DISTINCT H.ID FROM Highschooler H WHERE H.ID IN (SELECT student_id FROM Friend) AND H.ID IN (SELECT liked_id FROM Likes)
SELECT DISTINCT H.ID FROM Highschooler H WHERE H.ID IN (SELECT student_id FROM Friend) AND H.ID IN (SELECT liked_id FROM Likes)
SELECT DISTINCT h.name FROM Highschooler h WHERE h.ID IN (SELECT student_id FROM Friend) AND h.ID IN (SELECT liked_id FROM Likes);
SELECT DISTINCT h1.name FROM Highschooler h1 JOIN Friend f ON h1.ID = f.student_id JOIN Likes l ON h1.ID = l.liked_id
SELECT student_id, COUNT(*) AS like_count FROM Likes GROUP BY student_id
SELECT student_id, COUNT(*) as like_count FROM Likes GROUP BY student_id
SELECT h.name, COUNT(*) AS num_likes FROM Highschooler h JOIN Likes l ON h.ID = l.student_id GROUP BY h.ID, h.name
SELECT h.name, COUNT(*) AS like_count FROM Highschooler h JOIN Likes l ON h.ID = l.student_id GROUP BY h.ID, h.name
SELECT h.name FROM Highschooler h JOIN Likes l ON h.ID = l.student_id GROUP BY h.ID, h.name ORDER BY COUNT(*) DESC LIMIT 1
SELECT h.name FROM Highschooler h JOIN Likes l ON h.ID = l.student_id GROUP BY h.ID, h.name ORDER BY COUNT(*) DESC LIMIT 1
SELECT 1
SELECT Highschooler.name FROM Highschooler JOIN Likes ON Highschooler.ID = Likes.student_id GROUP BY Highschooler.ID HAVING COUNT(*) >= 2
SELECT Highschooler.name FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id WHERE Highschooler.grade > 5 GROUP BY Highschooler.ID HAVING COUNT(Friend.friend_id) >= 2
SELECT DISTINCT h.name FROM Highschooler h JOIN Friend f ON h.ID = f.student_id WHERE h.grade > 5 GROUP BY h.ID HAVING COUNT(f.friend_id) >= 2
SELECT COUNT(*) FROM Likes WHERE student_id = (SELECT ID FROM Highschooler WHERE name = 'Kyle')
SELECT COUNT(*) FROM Likes WHERE student_id = (SELECT ID FROM Highschooler WHERE name = 'Kyle')
SELECT AVG(h.grade) FROM Highschooler h JOIN Friend f ON h.ID = f.student_id
SELECT AVG(Highschooler.grade) AS average_grade FROM Highschooler JOIN Friend ON Highschooler.ID = Friend.student_id
SELECT MIN(h.grade) FROM Highschooler h WHERE h.ID NOT IN (SELECT student_id FROM Friend)
SELECT MIN(h.grade) FROM Highschooler h WHERE h.ID NOT IN (SELECT student_id FROM Friend)
SELECT DISTINCT o.state AS owner_state, p.state AS professional_state FROM Owners o JOIN Professionals p ON o.state = p.state WHERE o.state IS NOT NULL AND p.state IS NOT NULL
SELECT DISTINCT O.state AS owner_state, P.state AS professional_state FROM Owners O JOIN Dogs D ON O.owner_id = D.owner_id JOIN Treatments T ON D.dog_id = T.dog_id JOIN Professionals P ON T.professional_id = P.professional_id WHERE O.state = P.state
SELECT AVG(CAST(dogs.age AS REAL)) AS average_age FROM Dogs INNER JOIN Treatments ON Dogs.dog_id = Treatments.dog_id
SELECT AVG(CAST(dogs.age AS REAL)) AS average_age FROM Dogs INNER JOIN Treatments ON Dogs.dog_id = Treatments.dog_id
SELECT professional_id, last_name, cell_number FROM Professionals WHERE state = 'Indiana' OR professional_id IN ( SELECT professional_id FROM Treatments GROUP BY professional_id HAVING COUNT(*) > 2 )
SELECT professional_id, last_name, cell_number FROM Professionals WHERE state = 'Indiana' OR professional_id IN ( SELECT professional_id FROM Treatments GROUP BY professional_id HAVING COUNT(*) > 2 )
SELECT d.name FROM Dogs d JOIN Treatments t ON d.dog_id = t.dog_id WHERE (SELECT SUM(t.cost_of_treatment) FROM Treatments t WHERE t.dog_id = d.dog_id) <= 1000
SELECT DISTINCT d.name FROM Dogs d JOIN Owners o ON d.owner_id = o.owner_id JOIN Treatments t ON d.dog_id = t.dog_id WHERE (SELECT SUM(t2.cost_of_treatment) FROM Treatments t2 WHERE t2.dog_id = d.dog_id) < 1000
SELECT DISTINCT first_name FROM Professionals UNION SELECT DISTINCT first_name FROM Owners EXCEPT SELECT DISTINCT name FROM Dogs
SELECT DISTINCT first_name FROM Professionals UNION SELECT DISTINCT first_name FROM Owners EXCEPT SELECT name FROM Dogs
SELECT p.professional_id, p.role_code, p.email_address FROM Professionals p WHERE p.professional_id NOT IN (SELECT DISTINCT professional_id FROM Treatments)
SELECT professional_id, role_code, email_address FROM Professionals WHERE professional_id NOT IN ( SELECT DISTINCT professional_id FROM Treatments )
SELECT o.owner_id, o.first_name, o.last_name FROM Owners o JOIN Dogs d ON o.owner_id = d.owner_id GROUP BY o.owner_id, o.first_name, o.last_name ORDER BY COUNT(d.dog_id) DESC LIMIT 1
SELECT owner_id, first_name, last_name FROM Owners WHERE owner_id = (SELECT owner_id FROM Dogs GROUP BY owner_id ORDER BY COUNT(*) DESC LIMIT 1)
SELECT professional_id, role_code, first_name FROM Professionals WHERE professional_id IN (SELECT professional_id FROM Treatments GROUP BY professional_id HAVING COUNT(*) >= 2)
SELECT t.professional_id, p.role_code, p.first_name FROM Treatments t JOIN Professionals p ON t.professional_id = p.professional_id GROUP BY t.professional_id, p.role_code, p.first_name HAVING COUNT(*) >= 2
SELECT b.breed_name FROM Breeds b JOIN Dogs d ON b.breed_code = d.breed_code GROUP BY b.breed_code, b.breed_name ORDER BY COUNT(d.dog_id) DESC LIMIT 1
SELECT b.breed_name FROM Breeds b JOIN Dogs d ON b.breed_code = d.breed_code GROUP BY b.breed_name ORDER BY COUNT(*) DESC LIMIT 1
SELECT o.owner_id, o.last_name FROM Owners o JOIN Dogs d ON o.owner_id = d.owner_id JOIN Treatments t ON d.dog_id = t.dog_id GROUP BY o.owner_id, o.last_name ORDER BY COUNT(*) DESC LIMIT 1
SELECT o.owner_id, o.last_name FROM Owners o JOIN Dogs d ON o.owner_id = d.owner_id JOIN Treatments t ON d.dog_id = t.dog_id GROUP BY o.owner_id, o.last_name ORDER BY SUM(t.cost_of_treatment) DESC LIMIT 1
SELECT tt.treatment_type_description FROM Treatments t JOIN Treatment_Types tt ON t.treatment_type_code = tt.treatment_type_code GROUP BY tt.treatment_type_description ORDER BY SUM(t.cost_of_treatment) ASC LIMIT 1
SELECT tt.treatment_type_description FROM Treatments t JOIN Treatment_Types tt ON t.treatment_type_code = tt.treatment_type_code GROUP BY tt.treatment_type_code, tt.treatment_type_description ORDER BY SUM(t.cost_of_treatment) ASC LIMIT 1
SELECT o.owner_id, o.zip_code FROM Owners o JOIN Dogs d ON o.owner_id = d.owner_id GROUP BY o.owner_id, o.zip_code ORDER BY SUM(CASE WHEN d.date_adopted IS NOT NULL THEN 0 ELSE 0 END) DESC LIMIT 1
SELECT 1
SELECT professional_id, cell_number FROM Professionals WHERE professional_id IN ( SELECT professional_id FROM Treatments GROUP BY professional_id HAVING COUNT(DISTINCT treatment_type_code) >= 2 )
SELECT professional_id, cell_number FROM Professionals WHERE professional_id IN ( SELECT professional_id FROM Treatments GROUP BY professional_id HAVING COUNT(DISTINCT treatment_type_code) >= 2 )
SELECT p.first_name, p.last_name FROM Professionals p JOIN Treatments t ON p.professional_id = t.professional_id WHERE t.cost_of_treatment < (SELECT AVG(t2.cost_of_treatment) FROM Treatments t2)
SELECT DISTINCT p.first_name, p.last_name FROM Professionals p JOIN Treatments t ON p.professional_id = t.professional_id WHERE t.cost_of_treatment < (SELECT AVG(cost_of_treatment) FROM Treatments)
SELECT t.date_of_treatment, p.first_name FROM Treatments t JOIN Professionals p ON t.professional_id = p.professional_id
SELECT t.date_of_treatment, p.first_name FROM Treatments t JOIN Professionals p ON t.professional_id = p.professional_id
SELECT t.cost_of_treatment, tt.treatment_type_description FROM Treatments t JOIN Treatment_Types tt ON t.treatment_type_code = tt.treatment_type_code
SELECT t.cost_of_treatment, tt.treatment_type_description FROM Treatments t JOIN Treatment_Types tt ON t.treatment_type_code = tt.treatment_type_code
SELECT o.first_name, o.last_name, s.size_description FROM Dogs d JOIN Owners o ON d.owner_id = o.owner_id JOIN Sizes s ON d.size_code = s.size_code
SELECT o.first_name, o.last_name, s.size_description FROM Dogs d JOIN Owners o ON d.owner_id = o.owner_id JOIN Sizes s ON d.size_code = s.size_code
SELECT o.first_name, d.name FROM Dogs d JOIN Owners o ON d.owner_id = o.owner_id
SELECT o.first_name, d.name FROM Dogs d JOIN Owners o ON d.owner_id = o.owner_id
SELECT d.name, t.date_of_treatment FROM Dogs d JOIN Breeds b ON d.breed_code = b.breed_code JOIN Treatments t ON d.dog_id = t.dog_id ORDER BY b.breed_code LIMIT 1
SELECT d.name, t.date_of_treatment FROM Dogs d JOIN Treatments t ON d.dog_id = t.dog_id JOIN Breeds b ON d.breed_code = b.breed_code ORDER BY b.breed_code LIMIT 1
SELECT o.first_name, d.name FROM Dogs d JOIN Owners o ON d.owner_id = o.owner_id WHERE o.state = 'Virginia'
SELECT o.first_name, d.name FROM Dogs d JOIN Owners o ON d.owner_id = o.owner_id WHERE o.state = 'Virginia'
SELECT d.date_arrived, d.date_departed FROM Dogs d JOIN Treatments t ON d.dog_id = t.dog_id
SELECT d.date_arrived, d.date_departed FROM Dogs d JOIN Treatments t ON d.dog_id = t.dog_id
SELECT o.last_name FROM Dogs d JOIN Owners o ON d.owner_id = o.owner_id WHERE d.age = (SELECT MIN(age) FROM Dogs)
SELECT o.last_name FROM Dogs d JOIN Owners o ON d.owner_id = o.owner_id WHERE d.age = (SELECT MIN(age) FROM Dogs)
SELECT email_address FROM Professionals WHERE state IN ('Hawaii', 'Wisconsin')
SELECT email_address FROM Professionals WHERE state IN ('Hawaii', 'Wisconsin')
SELECT date_arrived, date_departed FROM Dogs
SELECT date_arrived, date_departed FROM Dogs
SELECT COUNT(DISTINCT dog_id) FROM Treatments
SELECT COUNT(*) FROM Dogs d JOIN Treatments t ON d.dog_id = t.dog_id
SELECT COUNT(DISTINCT p.professional_id) FROM Professionals p JOIN Treatments t ON p.professional_id = t.professional_id
SELECT COUNT(DISTINCT professional_id) FROM Treatments
SELECT professional_id, role_code, first_name, last_name, street, city, state FROM Professionals WHERE city LIKE '%West%'
SELECT professional.role_code, professional.street, professional.city, professional.state FROM Professionals professional WHERE professional.city LIKE '%West%'
SELECT o.first_name, o.last_name, o.email_address FROM Owners o WHERE o.state LIKE '%North%'
SELECT first_name, last_name, email_address FROM Owners WHERE state LIKE '%North%'
SELECT COUNT(*) FROM Dogs WHERE CAST(age AS REAL) < (SELECT AVG(CAST(age AS REAL)) FROM Dogs)
SELECT COUNT(*) FROM Dogs WHERE CAST(age AS REAL) < (SELECT AVG(CAST(age AS REAL)) FROM Dogs)
SELECT MAX(cost_of_treatment) AS most_recent_treatment_cost FROM Treatments
SELECT MAX(cost_of_treatment) AS most_recent_treatment_cost FROM Treatments
SELECT COUNT(*) FROM Dogs WHERE dog_id NOT IN (SELECT dog_id FROM Treatments)
SELECT COUNT(*) FROM Dogs WHERE dog_id NOT IN (SELECT dog_id FROM Treatments)
SELECT COUNT(*) FROM Owners WHERE owner_id NOT IN (SELECT DISTINCT owner_id FROM Dogs)
SELECT COUNT(*) FROM Owners o WHERE NOT EXISTS (SELECT 1 FROM Dogs d WHERE d.owner_id = o.owner_id)
SELECT COUNT(*) AS professional_count FROM Professionals WHERE professional_id NOT IN (SELECT DISTINCT professional_id FROM Treatments)
SELECT COUNT(*) AS professional_count FROM Professionals WHERE professional_id NOT IN ( SELECT DISTINCT professional_id FROM Treatments )
SELECT name, age, weight FROM Dogs WHERE abandoned_yn = '1'
SELECT name, age, weight FROM Dogs WHERE abandoned_yn = '1'
SELECT AVG(CAST(age AS REAL)) FROM Dogs
SELECT AVG(CAST(age AS REAL)) FROM Dogs
SELECT MAX(CAST(age AS INTEGER)) AS oldest_age FROM Dogs
SELECT MAX(CAST(age AS INTEGER)) AS oldest_age FROM Dogs
SELECT charge_type, charge_amount FROM Charges
SELECT charge_type, charge_amount FROM Charges
SELECT MAX(charge_amount) AS most_expensive_charge FROM Charges
SELECT MAX(charge_amount) AS max_charge_amount FROM Charges
SELECT email_address, cell_number, home_phone FROM Professionals
SELECT email_address, cell_number, home_phone FROM Professionals
SELECT DISTINCT b.breed_name, s.size_description FROM Breeds b CROSS JOIN Sizes s
SELECT DISTINCT b.breed_name, s.size_description FROM Dogs d JOIN Breeds b ON d.breed_code = b.breed_code JOIN Sizes s ON d.size_code = s.size_code
SELECT p.first_name, tt.treatment_type_description FROM Professionals p JOIN Treatments t ON p.professional_id = t.professional_id JOIN Treatment_Types tt ON t.treatment_type_code = tt.treatment_type_code
SELECT Professionals.first_name, Treatment_Types.treatment_type_description FROM Professionals JOIN Treatments ON Professionals.professional_id = Treatments.professional_id JOIN Treatment_Types ON Treatments.treatment_type_code = Treatment_Types.treatment_type_code
SELECT COUNT(*) FROM singer
SELECT COUNT(*) FROM singer
SELECT Name FROM singer ORDER BY Net_Worth_Millions ASC
SELECT singer.Name FROM singer ORDER BY singer.Net_Worth_Millions ASC
SELECT singer.Birth_Year, singer.Citizenship FROM singer
SELECT singer.Birth_Year, singer.Citizenship FROM singer
SELECT Name FROM singer WHERE Citizenship != 'France'
SELECT Name FROM singer WHERE Citizenship != 'France'
SELECT Name FROM singer WHERE Birth_Year IN (1948, 1949)
SELECT Name FROM singer WHERE Birth_Year IN (1948, 1949)
SELECT Name FROM singer ORDER BY Net_Worth_Millions DESC LIMIT 1
SELECT Name FROM singer ORDER BY Net_Worth_Millions DESC LIMIT 1
SELECT Citizenship, COUNT(*) AS Singer_Count FROM singer GROUP BY Citizenship
SELECT citizenship, COUNT(*) AS singer_count FROM singer GROUP BY citizenship
SELECT citizenship, COUNT(*) as count FROM singer GROUP BY citizenship ORDER BY count DESC LIMIT 1
SELECT 1
SELECT citizenship, MAX(Net_Worth_Millions) AS max_net_worth FROM singer GROUP BY citizenship
SELECT singer.Citizenship, MAX(singer.Net_Worth_Millions) AS max_net_worth FROM singer GROUP BY singer.Citizenship
SELECT song.Title, singer.Name FROM song JOIN singer ON song.Singer_ID = singer.Singer_ID
SELECT song.Title, singer.Name FROM song JOIN singer ON song.Singer_ID = singer.Singer_ID
SELECT DISTINCT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID WHERE song.Sales > 300000
SELECT DISTINCT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID WHERE song.Sales > 300000
SELECT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Singer_ID HAVING COUNT(song.Song_ID) > 1
SELECT singer.Name FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Singer_ID HAVING COUNT(song.Song_ID) > 1
SELECT singer.Name, SUM(song.Sales) AS total_sales FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Singer_ID, singer.Name
SELECT singer.Name, SUM(song.Sales) AS total_sales FROM singer JOIN song ON singer.Singer_ID = song.Singer_ID GROUP BY singer.Singer_ID, singer.Name
SELECT singer.Name FROM singer WHERE singer.Singer_ID NOT IN (SELECT song.Singer_ID FROM song)
SELECT s.Name AS sname FROM singer s WHERE NOT EXISTS (SELECT 1 FROM song sng WHERE sng.Singer_ID = s.Singer_ID)
SELECT DISTINCT citizenship FROM singer WHERE Birth_Year < 1945 AND Birth_Year > 1955
SELECT DISTINCT Citizenship FROM singer WHERE Birth_Year < 1945 AND Birth_Year > 1955
SELECT COUNT(*) AS total_available_features FROM Other_Available_Features
SELECT feature_type_name FROM Other_Available_Features a JOIN Ref_Feature_Types r ON a.feature_type_code = r.feature_type_code WHERE a.feature_name = 'AirCon'
SELECT property_type_description FROM Ref_Property_Types
SELECT DISTINCT p.property_name FROM Properties p JOIN Ref_Property_Types rpt ON p.property_type_code = rpt.property_type_code WHERE (rpt.property_type_description LIKE '%House%' OR rpt.property_type_description LIKE '%Apartment%') AND p.room_count > 1

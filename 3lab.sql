-- Подсчет количества сотрудников в отделе разработки
SELECT COUNT(*)
FROM "Employees"
WHERE DepartmentID = 1;
-- Подсчет среднего года окончания обучения среди сотрудников
SELECT AVG(GraduationYear)
FROM "Education";
-- Подсчет суммы годов окончания обучения среди сотрудников
SELECT SUM(GraduationYear)
FROM "Education";
-- Нахождение максимального года окончания обучения среди сотрудников
SELECT MAX(GraduationYear)
FROM "Education";
-- Нахождение минимального года окончания обучения среди сотрудников
SELECT MIN(GraduationYear)
FROM "Education";
-- Нахождение минимального года окончания обучения среди сотрудников без использования MIN
SELECT GraduationYear
FROM "Education"
ORDER BY GraduationYear ASC
LIMIT 1;
-- Нахождение максимального года окончания обучения среди сотрудников без использования MAX
SELECT GraduationYear
FROM "Education"
ORDER BY GraduationYear DESC
LIMIT 1;
-- Подсчет количества сотрудников в каждом отделе
SELECT DepartmentID, COUNT(*)
FROM "Employees"
GROUP BY DepartmentID;
-- Подсчет количества сотрудников на каждой должности в каждом отделе
SELECT e.DepartmentID, e.PositionID, COUNT(*)
FROM "Employees" e
JOIN "Departments" d ON e.DepartmentID = d.DepartmentID
JOIN "Positions" p ON e.PositionID = p.PositionID
GROUP BY e.DepartmentID, e.PositionID;
-- Подсчет количества сотрудников, чья дата рождения позже 1 января 1985 года
SELECT COUNT(*)
FROM "Employees"
WHERE BirthDate > (SELECT DATE '1985-01-01');
-- Перемещение всех записей из таблицы Departments, где DepartmentName содержит 'Архив', в таблицу DepartmentArchive
INSERT INTO "Department_archive" (DepartmentID, DepartmentName)
SELECT DepartmentID, DepartmentName
FROM "Departments"
WHERE DepartmentName LIKE '%Архив%';
-- Объединение списка сотрудников из отдела разработки и отдела тестирования
SELECT LastName, FirstName, DepartmentID
FROM "Employees"
WHERE DepartmentID = 1
UNION
SELECT LastName, FirstName, DepartmentID
FROM "Employees"
WHERE DepartmentID = 2;
-- Вывод информации о сотрудниках и их отделах
SELECT e.LastName, e.FirstName, d.DepartmentName
FROM "Employees" e
INNER JOIN "Departments" d ON e.DepartmentID = d.DepartmentID;
--INNER JOIN--
-- Вывод информации о сотрудниках и их отделах
SELECT e.LastName, e.FirstName, d.DepartmentName
FROM "Employees" e
INNER JOIN "Departments" d ON e.DepartmentID = d.DepartmentID;
--LEFT JOIN--
-- Вывод информации о сотрудниках и их отделах, включая сотрудников без отдела
SELECT e.LastName, e.FirstName, d.DepartmentName
FROM "Employees" e
LEFT JOIN "Departments" d ON e.DepartmentID = d.DepartmentID;
--RIGHT JOIN--
-- Вывод информации о сотрудниках и их отделах, включая отделы без сотрудников
SELECT e.LastName, e.FirstName, d.DepartmentName
FROM "Employees" e
RIGHT JOIN "Departments" d ON e.DepartmentID = d.DepartmentID;
--FULL OUTER JOIN--
-- Вывод информации о сотрудниках и их отделах, включая сотрудников без отдела и отделы без сотрудников
SELECT e.LastName, e.FirstName, d.DepartmentName
FROM "Employees" e
FULL OUTER JOIN "Departments" d ON e.DepartmentID = d.DepartmentID;
--Соединение таблицы со своей копией--
-- Соединение таблицы Employees с ее копией, чтобы найти сотрудников с одинаковыми фамилиями
SELECT e1.LastName, e1.FirstName, e2.FirstName AS OtherFirstName
FROM "Employees" e1
JOIN "Employees" e2 ON e1.LastName = e2.LastName AND e1.EmployeeID != e2.EmployeeID;
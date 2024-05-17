-- Выбор всех данных из таблицы Employees
SELECT * FROM "Employees";
-- Выбор только фамилий и имен сотрудников из таблицы Employees
SELECT LastName, FirstName FROM "Employees";
-- Выбор сотрудников, родившихся после 1 января 1990 года
SELECT * FROM "Employees" WHERE BirthDate > '1990-01-01';
-- Выбор сотрудников, родившихся между 1 января 1985 года и 31 декабря 1990 года
SELECT * FROM "Employees" WHERE BirthDate BETWEEN '1985-01-01' AND '1990-12-31';
-- Выбор сотрудников, чьи фамилии начинаются на "Ив"
SELECT * FROM "Employees" WHERE LastName LIKE 'Ив%';
-- Выбор сотрудников с ID 1, 2 или 3
SELECT * FROM "Employees" WHERE EmployeeID IN (1, 2, 3);
-- Выбор всех сотрудников с сортировкой по фамилии в алфавитном порядке
SELECT * FROM "Employees" ORDER BY LastName;
-- Выбор трех самых старших сотрудников
SELECT * FROM "Employees" ORDER BY BirthDate ASC LIMIT 2;
-- Получение декартова произведения таблиц Employees и Departments
SELECT * FROM "Employees", "Departments";
-- Соединение таблиц Employees и Departments по ключу DepartmentID
SELECT e.LastName, e.FirstName, d.DepartmentName
FROM "Employees" e
JOIN "Departments" d ON e.DepartmentID = d.DepartmentID;
-- Соединение таблицы Employees с ее копией, чтобы найти сотрудников с одинаковыми фамилиями
SELECT e1.LastName, e1.FirstName, e2.FirstName AS OtherFirstName
FROM "Employees" e1
JOIN "Employees" e2 ON e1.LastName = e2.LastName AND e1.EmployeeID != e2.EmployeeID;

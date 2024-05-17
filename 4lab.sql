--Представление с вложенным запросом--
CREATE OR REPLACE VIEW EmployeesInLargestDept AS
SELECT e.*
FROM Employees e
WHERE e.DepartmentID = (
    SELECT DepartmentID
    FROM Employees
    GROUP BY DepartmentID
    ORDER BY COUNT(*) DESC
    LIMIT 1
);
--Представление с группировкой--
CREATE OR REPLACE VIEW EmployeeCountPerDept AS
SELECT DepartmentID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;
--Представление с соединением--
CREATE OR REPLACE VIEW EmployeeDeptInfo AS
SELECT e.EmployeeID, e.LastName, e.FirstName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;
--Изменяемое представление с условием WHERE--
CREATE OR REPLACE VIEW YoungEmployees AS
SELECT *
FROM "Employees"
WHERE BirthDate > '1980-01-01'
WITH CHECK OPTION;
-- Выборка данных из представления EmployeesInLargestDept
SELECT * FROM EmployeesInLargestDept;

-- Выборка данных из представления EmployeeCountPerDept
SELECT * FROM EmployeeCountPerDept;

-- Выборка данных из представления EmployeeDeptInfo
SELECT * FROM EmployeeDeptInfo;

-- Выборка данных из представления YoungEmployees
SELECT * FROM YoungEmployees;
-- Вставка нового сотрудника, который попадает под условие WHERE
INSERT INTO YoungEmployees (LastName, FirstName, BirthDate, ContactPhone, Email, PositionID, DepartmentID)
VALUES ('Пушной', 'Сергей', 'Сергеевич' '1990-05-15', '1234567890', 'new.employee@example.com', 1, 1);

-- Обновление существующего сотрудника, чтобы он попал под условие WHERE
UPDATE YoungEmployees
SET BirthDate = '1990-01-01'
WHERE EmployeeID = 1;
-- Попытка вставки нового сотрудника, который не попадает под условие WHERE
-- Это приведет к ошибке из-за WITH CHECK OPTION
INSERT INTO YoungEmployees (LastName, FirstName, BirthDate, ContactPhone, Email, PositionID, DepartmentID)
VALUES ('Old', 'Employee', '1970-05-15', '1234567890', 'old.employee@example.com', 1, 1);

-- Попытка обновления существующего сотрудника, чтобы он не попал под условие WHERE
-- Это приведет к ошибке из-за WITH CHECK OPTION
UPDATE YoungEmployees
SET BirthDate = '1970-01-01'
WHERE EmployeeID = 1;
--Создание и отладка хранимых процедур--
CREATE OR REPLACE PROCEDURE UpdateEmployeeInfo(
    emp_id INT,
    new_phone VARCHAR,
    new_email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Employees
    SET ContactPhone = new_phone, Email = new_email
    WHERE EmployeeID = emp_id;
END;
$$;

-- Вызов процедуры--

--Хранимая процедура с вводимым параметром--
CALL UpdateEmployeeInfo(1, '0987654321', 'updated.email@example.com');
CREATE OR REPLACE PROCEDURE PromoteEmployee(
    emp_id INT,
    new_position_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Employees
    SET PositionID = new_position_id
    WHERE EmployeeID = emp_id;
END;
$$;

-- Вызов процедуры
CALL PromoteEmployee(1, 2);

--Создание и отладка функций посредством вызова для отношения--
CREATE OR REPLACE FUNCTION GetEmployeeFullName(emp_id INT)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
    full_name TEXT;
BEGIN
    SELECT CONCAT(FirstName, ' ', LastName) INTO full_name
    FROM Employees
    WHERE EmployeeID = emp_id;
    RETURN full_name;
END;
$$;

-- Вызов функции
SELECT GetEmployeeFullName(1);

--Пример триггера на вставку--
CREATE OR REPLACE FUNCTION SetDefaultContactPhone()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.ContactPhone IS NULL THEN
        NEW.ContactPhone := 'Unknown';
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER BeforeInsertEmployee
BEFORE INSERT ON Employees
FOR EACH ROW
EXECUTE FUNCTION SetDefaultContactPhone();

--Пример триггера на обновление-- 
CREATE OR REPLACE FUNCTION LogEmployeeUpdate()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO EmployeeLog(EmployeeID, ChangeDate, NewContactPhone, NewEmail)
    VALUES (NEW.EmployeeID, NOW(), NEW.ContactPhone, NEW.Email);
    RETURN NEW;
END;
$$;

CREATE TRIGGER AfterUpdateEmployee
AFTER UPDATE ON Employees
FOR EACH ROW
EXECUTE FUNCTION LogEmployeeUpdate();

--Проверка триггера на вставку--
-- Вставка сотрудника без номера телефона
INSERT INTO Employees (LastName, FirstName, BirthDate, Email, PositionID, DepartmentID)
VALUES ('Test', 'User', '1995-01-01', 'test.user@example.com', 1, 1);

-- Проверка вставки
SELECT * FROM Employees WHERE LastName = 'Test';

--Проверка триггера на обновление--
-- Обновление сотрудника
UPDATE "Employees"
SET ContactPhone = '1231231234', Email = 'new.email@example.com'
WHERE EmployeeID = 1;

-- Проверка логов
SELECT * FROM EmployeeLog WHERE EmployeeID = 1;



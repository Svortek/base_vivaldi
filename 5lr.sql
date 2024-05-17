--Создание роли для чтения данных
CREATE ROLE read_access;
GRANT CONNECT ON DATABASE your_database TO read_access;
GRANT USAGE ON SCHEMA public TO read_access;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO read_access;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO read_access;
--Создание роли для вставки данных
CREATE ROLE insert_access;
GRANT CONNECT ON DATABASE your_database TO insert_access;
GRANT USAGE ON SCHEMA public TO insert_access;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO insert_access;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT INSERT ON TABLES TO insert_access;
--Создание роли для обновления данных
CREATE ROLE update_access;
GRANT CONNECT ON DATABASE your_database TO update_access;
GRANT USAGE ON SCHEMA public TO update_access;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO update_access;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT UPDATE ON TABLES TO update_access;
--Создание роли для удаления данных
CREATE ROLE delete_access;
GRANT CONNECT ON DATABASE your_database TO delete_access;
GRANT USAGE ON SCHEMA public TO delete_access;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO delete_access;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT DELETE ON TABLES TO delete_access;
--Создание пользователя с возможностью подключения к БД
CREATE USER myuser WITH PASSWORD '1111';
--Присвоение прав на создание и изменение БД
ALTER USER myuser CREATEDB;
--Изменение пароля и установка срока действия
ALTER USER myuser WITH PASSWORD '2222' VALID UNTIL '2024-12-31';
--Создание пользователя Admin
CREATE USER admin WITH PASSWORD '1111';
--Присвоение роли суперпользователя
ALTER USER admin WITH SUPERUSER;
--Создание пользователя User
CREATE USER zxc WITH PASSWORD '1111';
GRANT read_access TO zxc;
--Запрет просмотра определенных таблиц
REVOKE SELECT ON TABLE "Documents" FROM zxc;
--Запрет просмотра определенных столбцов
REVOKE SELECT (number) ON TABLE "Documents" FROM user;
--Создание пользователя Manager
CREATE USER manager WITH PASSWORD '1111';
--Присвоение ролей на просмотр и обновление
GRANT read_access, update_access TO manager;
--Удаление пользователя Manager
DROP USER manager;
--Создание группы ролей managers
CREATE ROLE managers;
GRANT read_access, insert_access, update_access TO managers;
--Создание пользователя Manager
CREATE USER manager WITH PASSWORD 'managerpassword';
GRANT managers TO manager;
--Создание пользователя
CREATE USER full_access_user WITH PASSWORD '1111';
--Присвоение прав
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE "Documents" TO full_access_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE "Education" TO full_access_user;

-- 1) Извлечение данных с помощью функций создания JSON.
select to_json(students) from students; --создание 
select row_to_json(students, true) from students; --

-- 2)Загрузка и сохранение JSON-документа
copy (select row_to_json(students) from students) to 'C:\5_sem\DataBase\Lab_5\save.json'; -- копирование извлеченных данных в save 

create temp table student_import(doc json); -- временная таблица (формат  json)
copy student_import from "E:\5_sem\DataBase\Lab_5\load.json"; --импортирование load. Добавление содержимого load. Валидация. 

select s.*
from student_import, json_populate_record(null::students, doc) as s; -- отображение из json в формат таблицы

select *
from student_import -- таблица в формате json (каждая строка - словарь)
drop table student_import;
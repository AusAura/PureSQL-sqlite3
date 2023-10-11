-- Знайти середній бал на потоці (по всій таблиці оцінок).

SELECT ROUND(AVG(m.mark_value), 2) AS total_average
FROM marks m;
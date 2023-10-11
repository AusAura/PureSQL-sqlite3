-- Знайти 5 студентів із найбільшим середнім балом з усіх предметів.

SELECT s.name_uq, AVG(m.mark_value) AS average_mark
FROM marks m
LEFT JOIN students s ON m.student_id_fk = s.id_pk
GROUP BY s.name_uq
ORDER BY average_mark DESC
LIMIT 5;
-- Знайти список курсів, які відвідує студент.

SELECT s.name_uq, sub.name_uq
FROM marks m
LEFT JOIN students s ON m.student_id_fk = s.id_pk
LEFT JOIN subjects sub ON sub.id_pk = m.subject_id_fk
WHERE s.name_uq = ?
ORDER BY s.name_uq;
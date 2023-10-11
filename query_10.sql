-- Список курсів, які певному студенту читає певний викладач.

SELECT DISTINCT s.name_uq, t.name_uq, sub.name_uq
FROM marks m
LEFT JOIN students s ON m.student_id_fk = s.id_pk
LEFT JOIN subjects sub ON sub.id_pk = m.subject_id_fk
LEFT JOIN tutors t ON t.id_pk = sub.tutor_id_fk
WHERE s.name_uq = ? AND t.name_uq = ?
ORDER BY s.name_uq;
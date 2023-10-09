-- Знайти середній бал, який ставить певний викладач зі своїх предметів.

SELECT t.name_uq, sub.name_uq, AVG(m.mark_value)
FROM subjects sub
LEFT JOIN tutors t ON sub.tutor_id_fk = t.id_pk
LEFT JOIN marks m ON m.subject_id_fk = sub.id_pk
GROUP BY sub.name_uq
ORDER BY t.name_uq;
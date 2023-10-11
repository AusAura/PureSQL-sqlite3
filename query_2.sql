--  Знайти студента із найвищим середнім балом з певного предмета

SELECT s.name_uq, MAX(m.mark_value) AS max_mark, sub.name_uq
FROM marks m
LEFT JOIN students s ON m.student_id_fk = s.id_pk
LEFT JOIN subjects sub ON sub.id_pk = m.subject_id_fk
WHERE sub.name_uq = ?
GROUP BY sub.name_uq;
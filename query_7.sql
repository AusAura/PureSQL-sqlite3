-- Знайти оцінки студентів у окремій групі з певного предмета.

SELECT g.name_uq, sub.name_uq, m.mark_value, s.name_uq
FROM marks m
LEFT JOIN students s ON m.student_id_fk = s.id_pk
LEFT JOIN groups g ON s.group_id_fk = g.id_pk
JOIN subjects sub ON sub.id_pk = m.subject_id_fk
WHERE g.name_uq = ? AND sub.name_uq = ?
GROUP BY g.name_uq, sub.name_uq, s.name_uq, m.mark_value
ORDER BY s.name_uq ASC;
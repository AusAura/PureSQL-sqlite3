SELECT g.name_uq, AVG(m.mark_value) AS average_mark
FROM marks m
LEFT JOIN students s ON m.student_id_fk = s.id_pk
LEFT JOIN groups g ON s.group_id_fk = g.id_pk
GROUP BY g.name_uq
ORDER BY average_mark DESC;
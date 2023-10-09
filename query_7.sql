SELECT g.name_uq, m.mark_value, s.name_uq
FROM marks m
LEFT JOIN students s ON m.student_id_fk = s.id_pk
LEFT JOIN groups g ON s.group_id_fk = g.id_pk
GROUP BY m.mark_value
ORDER BY s.name_uq ASC;
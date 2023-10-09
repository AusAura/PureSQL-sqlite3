SELECT g.name_uq, s.name_uq
FROM groups g
LEFT JOIN students s ON g.id_pk = s.group_id_fk
GROUP BY s.name_uq
ORDER BY g.name_uq ASC;
-- Середній бал, який певний викладач ставить певному студентові.

SELECT stundent_name, tutor_name, AVG(average_mark)
FROM (SELECT s.name_uq AS stundent_name, t.name_uq AS tutor_name, AVG(m.mark_value) AS average_mark
	FROM marks m
	LEFT JOIN students s ON m.student_id_fk = s.id_pk
	LEFT JOIN subjects sub ON sub.id_pk = m.subject_id_fk
	LEFT JOIN tutors t ON t.id_pk = sub.tutor_id_fk
	GROUP BY s.name_uq, t.name_uq, sub.name_uq)
GROUP BY stundent_name, tutor_name
ORDER BY stundent_name, tutor_name; 
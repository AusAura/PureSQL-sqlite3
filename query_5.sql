SELECT t.name_uq, sub.name_uq
FROM subjects sub
LEFT JOIN tutors t ON sub.tutor_id_fk = t.id_pk
GROUP BY sub.name_uq;
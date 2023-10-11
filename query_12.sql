-- Оцінки студентів у певній групі з певного предмета на останньому занятті. (по каждому последнему занятию для каждого студента)

SELECT g.name_uq as group_name, sub.name_uq AS subject_name, s.name_uq AS student_name, m.mark_value, today_date as last_date
FROM students s
JOIN marks m ON s.id_pk = m.student_id_fk
JOIN subjects sub ON m.subject_id_fk = sub.id_pk
JOIN groups g ON g.id_pk = s.group_id_fk
WHERE m.today_date = (
    SELECT MAX(today_date)
    FROM marks
    WHERE student_id_fk = s.id_pk
      AND subject_id_fk = sub.id_pk
) AND group_name = ? AND subject_name = ?
ORDER BY group_name, subject_name;
-- Оцінки студентів у певній групі з певного предмета на останньому занятті. (только 1 самое последнее занятие для указанного предмета)

SELECT g.name_uq AS group_name, sub.name_uq AS subject_name, s.name_uq AS student_name, m.mark_value, m.today_date
FROM students s
JOIN marks m ON s.id_pk = m.student_id_fk
JOIN subjects sub ON m.subject_id_fk = sub.id_pk
JOIN groups g ON g.id_pk = s.group_id_fk
WHERE m.today_date = (
    SELECT MAX(today_date)
    FROM marks AS m2
    WHERE m2.subject_id_fk = m.subject_id_fk
) AND group_name = ? AND subject_name = ?
ORDER BY group_name, subject_name;
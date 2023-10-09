import sqlite3, faker
from random import randint
from datetime import datetime, timedelta

database = "./college.db"
script = "./script.sql"
script_triggers = "./triggers.sql"
faker = faker.Faker()

NUM_STUDENTS = 50
NUM_GROUPS = 3
NUM_SUBJECTS = randint(5, 8)
NUM_TUTORS = randint(3, 5)
NUM_MARKS = randint(10, 19)
FAKE_DATA_RANGES = NUM_STUDENTS, NUM_GROUPS, NUM_SUBJECTS, NUM_TUTORS, NUM_MARKS

groups = ["Группа А", "Группа Б", "Группа В", "Группа Г", "Группа Д"]
subjects = [
    "Математика",
    "Физика",
    "Химия Гачи-Мучи",
    "Истории у костра",
    "Иностранный язык",
    "Искусство",
    "Музыка",
    "Оленеводство",
    "Грибоварение",
]


def create_database() -> None:
    with open(script, "r") as fd:
        sql = fd.read()

    with sqlite3.connect(database) as con:
        cur = con.cursor()
        cur.executescript(sql)


def gen_fake_data(data_ranges: tuple) -> tuple:
    def generate_subject_name() -> str:
        while subjects:
            subject = faker.random_element(elements=subjects)
            subjects.remove(subject)
            yield subject
        # raise StopIteration

    def generate_group_name() -> str:
        group = faker.random_element(elements=groups)
        groups.remove(group)
        return group

    fake_students = []
    fake_groups = []
    fake_subjects = []
    fake_tutors = []
    fake_marks = []

    for _ in range(data_ranges[0]):
        fake_students.append(faker.name())

    for _ in range(data_ranges[1]):
        fake_groups.append(generate_group_name())

    subects_gen = generate_subject_name()
    for _ in range(data_ranges[2]):
        fake_subjects.append(next(subects_gen, None))

    for _ in range(data_ranges[3]):
        fake_tutors.append(faker.name())

    for _ in range(data_ranges[4]):
        fake_marks.append(randint(0, 100))

    return fake_students, fake_groups, fake_subjects, fake_tutors, fake_marks


def prepare_data(data: tuple) -> tuple:
    def generate_random_date() -> datetime:
        start_date = datetime(2000, 1, 1)
        end_date = datetime(2023, 12, 31)
        delta = end_date - start_date
        random_days = randint(0, delta.days)
        random_date = start_date + timedelta(days=random_days)
        # random_date = random_date.strftime("%Y-%m-%d")
        return random_date

    students_list = []
    for item in data[0]:
        students_list.append((item, randint(1, NUM_GROUPS)))

    groups_list = []
    for item in data[1]:
        groups_list.append((item,))

    subjects_list = []
    for item in data[2]:
        subjects_list.append((item, randint(1, NUM_TUTORS)))

    tutors_list = []
    for item in data[3]:
        tutors_list.append((item,))

    marks_list = []
    for item in data[4]:
        marks_list.append(
            (
                item,
                randint(1, NUM_STUDENTS),
                randint(1, NUM_SUBJECTS),
                generate_random_date(),
            )
        )

    return students_list, groups_list, subjects_list, tutors_list, marks_list


def insert_data(data: tuple) -> None:
    with sqlite3.connect(database) as con:
        cur = con.cursor()
        sql_students_query = (
            """INSERT INTO students(name_uq, group_id_fk) VALUES (?, ?)"""
        )
        cur.executemany(sql_students_query, data[0])

        sql_groups_query = """INSERT INTO groups(name_uq) VALUES (?)"""
        cur.executemany(sql_groups_query, data[1])

        sql_subjects_query = (
            """INSERT INTO subjects(name_uq, tutor_id_fk) VALUES (?, ?)"""
        )
        cur.executemany(sql_subjects_query, data[2])

        sql_tutors_query = """INSERT INTO tutors(name_uq) VALUES (?)"""
        cur.executemany(sql_tutors_query, data[3])

        sql_marks_query = """INSERT INTO marks(mark_value, student_id_fk, subject_id_fk, today_date) VALUES (?, ?, ?, ?)"""
        cur.executemany(sql_marks_query, data[4])

        con.commit()


def select_data(database: str) -> list:
    with sqlite3.connect(database) as con:
        cur = con.cursor()
        i = 1

        while True:
            sql_file = "query_" + str(i) + ".sql"
            try:
                with open(sql_file, "r") as fh:
                    sql_query = fh.read()
                print(f"EXECUTING ->> {sql_file}")
                cur.execute(sql_query)
                data = cur.fetchall()
                if not data:
                    break
                yield data
                i += 1
            except FileNotFoundError as e:
                print("That was the last query from the files!")
                break


if __name__ == "__main__":
    while True:
        is_regenerate = input("Should I re-generate the database? (yes, no) -->> ")
        if is_regenerate.casefold() == "yes":
            create_database()
            generated_fake_data = gen_fake_data(FAKE_DATA_RANGES)
            prepared_fake_data = prepare_data(generated_fake_data)
            insert_data(prepared_fake_data)
            break
        elif is_regenerate.casefold() == "no":
            break
        else:
            print("I do not understand!")

    data_generator = select_data(database)
    data = next(data_generator, None)
    while data:
        print(data)
        data = next(data_generator, None)

    print('DONE!')
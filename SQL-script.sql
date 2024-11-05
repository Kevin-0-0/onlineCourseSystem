-- SQL script to define database for online course system
-- CREATE DATABASE online_course;
-- USE online_course;
DROP TABLE IF EXISTS student_quiz_attempt;
DROP TABLE IF EXISTS quiz_answer;
DROP TABLE IF EXISTS quiz_question;
DROP TABLE IF EXISTS quiz;
DROP TABLE IF EXISTS student_lesson;
DROP TABLE IF EXISTS enrolment;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS lesson;
DROP TABLE IF EXISTS module;
DROP TABLE IF EXISTS course;

CREATE TABLE course (
id INT AUTO_INCREMENT,
name VARCHAR(500),
description VARCHAR(4000),
price INT,
is_progress_limited TINYINT,
CONSTRAINT pk_course PRIMARY KEY (id)
);

CREATE TABLE module (
id INT AUTO_INCREMENT,
course_id INT,
name VARCHAR(500),
number INT,
CONSTRAINT pk_module PRIMARY KEY (id),
CONSTRAINT fk_module_course
FOREIGN KEY (course_id) REFERENCES course (id)
);

CREATE TABLE lesson (
id INT AUTO_INCREMENT,
module_id INT,
name VARCHAR(500),
number INT,
video_url VARCHAR(500),
lesson_details VARCHAR(4000),
course_order INT,
CONSTRAINT pk_lesson PRIMARY KEY (id),
CONSTRAINT fk_lesson_module
FOREIGN KEY (module_id) REFERENCES module (id)
);

CREATE TABLE student (
id INT AUTO_INCREMENT,
email_address VARCHAR(350),
password VARCHAR(500),
CONSTRAINT pk_student PRIMARY KEY (id)
);

CREATE TABLE enrolment (
course_id INT,
student_id INT,
enrolment_datetime DATETIME,
completed_datetime DATETIME,
CONSTRAINT fk_enrol_course
FOREIGN KEY (course_id) REFERENCES course (id),
CONSTRAINT fk_enrol_student
FOREIGN KEY (student_id) REFERENCES student (id)
);

CREATE TABLE student_lesson (
student_id INT,
lesson_id INT,
completed_datetime DATETIME,
CONSTRAINT fk_stdles_student
FOREIGN KEY (student_id) REFERENCES student (id),
CONSTRAINT fk_stdles_lesson
FOREIGN KEY (lesson_id) REFERENCES lesson (id)
);

CREATE TABLE quiz (
id INT AUTO_INCREMENT,
course_id INT,
name VARCHAR(500),
number INT,
course_order INT,
min_pass_score INT,
is_pass_required TINYINT,
CONSTRAINT pk_quiz PRIMARY KEY (id),
CONSTRAINT fk_quiz_course
  FOREIGN KEY (course_id) REFERENCES course (id)
);

CREATE TABLE quiz_question (
id INT AUTO_INCREMENT,
quiz_id INT,
question_title VARCHAR(500),
CONSTRAINT pk_quizquest PRIMARY KEY (id),
CONSTRAINT fk_quizquest_quiz
FOREIGN KEY (quiz_id) REFERENCES quiz (id)
);

CREATE TABLE quiz_answer (
id INT AUTO_INCREMENT,
question_id INT,
answer_text VARCHAR(500),
is_correct TINYINT,
CONSTRAINT pk_quizans PRIMARY KEY (id),
CONSTRAINT fk_quizans_question
FOREIGN KEY (question_id) REFERENCES quiz_question (id)
);

CREATE TABLE student_quiz_attempt (
student_id INT,
quiz_id INT,
attempt_datetime DATETIME,
score_achieved INT,
CONSTRAINT fk_stdquiz_student
FOREIGN KEY (student_id) REFERENCES student (id),
CONSTRAINT fk_stdquiz_quiz
FOREIGN KEY (quiz_id) REFERENCES quiz (id)
);

SELECT * from student_quiz_attempt;
SELECT * from quiz_answer;
SELECT * from quiz_question;
SELECT * from quiz;
SELECT * from student_lesson;
SELECT * from enrolment;
SELECT * from student;
SELECT * from lesson;
SELECT * from module;
SELECT * from course;
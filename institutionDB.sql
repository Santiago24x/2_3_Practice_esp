-- Creation database
CREATE DATABASE institution;

-- Use database
USE institution;

-- Creation tables 

-- table faculty
CREATE TABLE IF NOT EXISTS `faculty` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  PRIMARY KEY (`id`)
) ;

-- table department
CREATE TABLE IF NOT EXISTS `department` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `location` VARCHAR(45) NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_department_faculty`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `faculty` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;

-- table stateCourse
CREATE TABLE IF NOT EXISTS `stateCourse` (
  `id` INT NOT NULL,
  `type` VARCHAR(12) NULL,
  PRIMARY KEY (`id`)
) ;


-- table stateInscription
CREATE TABLE IF NOT EXISTS `stateInscription` (
  `id` INT NOT NULL,
  `type` VARCHAR(12) NULL,
  PRIMARY KEY (`id`)
) ;

-- table priority
CREATE TABLE IF NOT EXISTS `priority` (
  `id` INT NOT NULL,
  `type` VARCHAR(20) NULL,
  PRIMARY KEY (`id`)
) ;


-- table academicSessions
CREATE TABLE IF NOT EXISTS `academicSessions` (
  `id` INT NOT NULL,
  `semester` INT NULL,
  `academicYear` YEAR NULL,
  PRIMARY KEY (`id`)
) ;

-- table teachers
CREATE TABLE IF NOT EXISTS `teachers` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
) ;

-- table teachersPhones
CREATE TABLE IF NOT EXISTS `teachersPhones` (
  `teachers_id` INT NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `priority_id` INT NOT NULL,
  PRIMARY KEY (`phone`),
  CONSTRAINT `fk_telefonos_teachers1`
    FOREIGN KEY (`teachers_id`)
    REFERENCES `teachers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teachersPhones_priority1`
    FOREIGN KEY (`priority_id`)
    REFERENCES `priority` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;

-- table teachersEmails
CREATE TABLE IF NOT EXISTS `teachersEmails` (
  `teachers_id` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `priority_id` INT NOT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `fk_correo_teachers1`
    FOREIGN KEY (`teachers_id`)
    REFERENCES `teachers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_teachersEmails_priority1`
    FOREIGN KEY (`priority_id`)
    REFERENCES `priority` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;

-- table students
CREATE TABLE IF NOT EXISTS `students` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`)
);


CREATE TABLE IF NOT EXISTS `studentsPhones` (
  `phone` VARCHAR(45) NOT NULL,
  `student_id` INT NOT NULL,
  `priority_id` INT NOT NULL,
  PRIMARY KEY (`phone`),
  CONSTRAINT `fk_telefonos_copy1_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_studentsPhones_priority1`
    FOREIGN KEY (`priority_id`)
    REFERENCES `priority` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;

CREATE TABLE IF NOT EXISTS `studentsEmails` (
  `email` VARCHAR(45) NOT NULL,
  `student_id` INT NOT NULL,
  `priority_id` INT NOT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `fk_correos_copy1_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_studentsEmails_priority1`
    FOREIGN KEY (`priority_id`)
    REFERENCES `priority` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;



CREATE TABLE IF NOT EXISTS `course` (
  `id` INT NOT NULL,
  `name` VARCHAR(100) NULL,
  `code` VARCHAR(25) NULL,
  `description` TEXT NULL,
  `duration` VARCHAR(45) NULL,
  `department_id` INT NOT NULL,
  `teachers_id` INT NOT NULL,
  `stateCourse_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`department_id`)
    REFERENCES `department` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_teachers1`
    FOREIGN KEY (`teachers_id`)
    REFERENCES `teachers` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_course_stateCourse1`
    FOREIGN KEY (`stateCourse_id`)
    REFERENCES `stateCourse` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;

CREATE TABLE IF NOT EXISTS `academicSessions_has_courses` (
  `academicSession_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`academicSession_id`, `course_id`),
  CONSTRAINT `fk_academicSession_has_course_academicSession1`
    FOREIGN KEY (`academicSession_id`)
    REFERENCES `academicSessions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_academicSession_has_course_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;

CREATE TABLE IF NOT EXISTS `exam` (
  `student_id` INT NOT NULL,
  `id` INT NULL,
  `grade` FLOAT NULL,
  `course_id` INT NOT NULL,
  CONSTRAINT `fk_exam_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_exam_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;

CREATE TABLE IF NOT EXISTS `inscription` (
  `id` INT NOT NULL,
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  `state_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_inscription_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscription_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inscription_state1`
    FOREIGN KEY (`state_id`)
    REFERENCES `stateInscription` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;

CREATE TABLE IF NOT EXISTS `assistance` (
  `id` INT NOT NULL,
  `date` DATE NULL,
  `student_id` INT NOT NULL,
  `course_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_assistance_student1`
    FOREIGN KEY (`student_id`)
    REFERENCES `students` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_assistance_course1`
    FOREIGN KEY (`course_id`)
    REFERENCES `course` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ;

CREATE OR REPLACE TRIGGER check_joining_date
AFTER 
INSERT OR UPDATE ON user_details
FOR EACH ROW
BEGIN
  IF: new.joining_date<to_date('01/01/2000','dd/mm/yyyy')THEN
  raise_application_error(-20002, 'Joining date must be after year 1999');
  END IF;
END;
/

UPDATE user_details SET joining_date = to_date('14/01/1999', 'dd/mm/yyyy') WHERE user_id = 102;


CREATE OR REPLACE TRIGGER check_mail
AFTER
INSERT OR UPDATE ON user_details
FOR EACH ROW
BEGIN
  IF: new.email not like '%@%' THEN
  raise_application_error(-20003, 'Email id must include @');
  END IF;
END;
/

INSERT INTO user_details (user_id, username, email) VALUES (121, 'Riya', 'riyagmail.com');

CREATE OR REPLACE TRIGGER check_phno
AFTER
INSERT OR UPDATE ON user_details
FOR EACH ROW
BEGIN
  IF: new.phone_number not like '__________' THEN
  raise_application_error(-20003, 'Phone no. must be of 10 digits');
  END IF;
END;
/

UPDATE user_details SET phone_number = 59358333923 WHERE user_id = 102;


CREATE OR REPLACE TRIGGER check_member_deletion
AFTER 
DELETE ON user_details
FOR EACH ROW
BEGIN
  IF: old.branch = 'MBBS' THEN
  RAISE_APPLICATION_ERROR(-20005, 'Premium member cannot be deleted');
END IF;
END;
/

SELECT branch, count(*) from user_details group by branch; 
DELETE FROM user_details where username = 'Aarya';
/

create view cs_members as select user_id, username, address, branch from user_details WHERE branch = 'CS';

SELECT * FROM cs_members;

UPDATE cs_members SET address = 'Bibvewadi' where username = 'Saniya';

DELETE FROM cs_members where user_id = 112;

INSERT INTO cs_members VALUES(121, 'Riya', 'Ambegaon', 'CS');

CREATE VIEW adults AS SELECT username, age, branch, address, joining_date FROM user_details WHERE age > 20;

SELECT age, count(*) from user_details group by age;
SELECT * FROM adults;
INSERT INTO adults VALUES('Ajinkya', '22', 'Mechanical', 'Ambegaon', to_date('03/12/2021','dd/mm/yyyy'));
UPDATE adults SET age = 22 where username = 'Rohan'; 
DELETE from adults WHERE age = 23; 

/*COMPLEX VIEW*/
CREATE TABLE Students
  (
    std_no NUMBER PRIMARY KEY,
    std_name VARCHAR2(50),
    Marks NUMBER,
    HOD VARCHAR2(50),
    dept_no NUMBER
  );

DESC students;
select * from students;

CREATE TABLE student_department
  ( 
     Dept_no NUMBER PRIMARY KEY,
     Dept_name VARCHAR2(50)
  );
DESC student_department;

INSERT INTO Students VALUES
    (1,'Soham Shirsat', 950,'LOSHMA',30
    );
  INSERT INTO Students VALUES
    (2,'Nikita Shitole', 900,'MADHUSUDHAN',20
    ) ;
  INSERT INTO Students VALUES
    (3,'Vedant Jadhav', 850,'VEERENDRA',10
    );
  INSERT INTO Students VALUES
    (4,'Vedant Jagtap',900,'SUDHARMA',40
    );
  INSERT INTO Students VALUES
    (5,'Aarya Pisal',1000,'SUDHARMA',40
    );
  COMMIT;
  
  INSERT INTO student_department VALUES
    (10,'IT'
    );
  INSERT INTO student_department VALUES
    (20,'CS'
    );
  INSERT INTO student_department VALUES
    (30,'Mechanical'
    );
  INSERT INTO student_department VALUES
    (40,'AI'
    );
  COMMIT;
select * from student_department;

CREATE VIEW std_dept_view (std_no, std_name, Dept_name) AS
SELECT std.std_no,
       std.std_name,
       dept.dept_name
FROM Students std, student_department dept WHERE std.dept_no=dept.dept_no;

SELECT * FROM std_dept_view;
UPDATE std_dept_view  SET STD_NAME ='Nupur Varu'  WHERE std_no = 5;
DESC std_dept_view;

CREATE VIEW std_dept_view1_GRPBY(
cnt_stds,Dept_name) AS
SELECT COUNT(std_name) cnt_stds, Dept_name FROM Students std, student_Department dept
WHERE std.dept_no=dept.dept_no GROUP BY dept.Dept_name;

select * from std_dept_view1_GRPBY;


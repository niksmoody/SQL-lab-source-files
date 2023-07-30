CREATE or REPLACE FUNCTION GET_YEARS(joining_date date) RETURN NUMBER
is
BEGIN
RETURN(round(((sysdate-joining_date)/365)));
END;
/
SELECT username, joining_date, round((sysdate-joining_date)/365), GET_YEARS(joining_date) as years_joined from bookpeople ORDER BY user_id;

CREATE FUNCTION MEMBERSHIP(joining_date date) RETURN CHAR is
BEGIN
if (round((sysdate-joining_date)/365) > 5) then
RETURN('PREMIUM');
else
RETURN('BASIC');
END IF;
END;
/
SELECT username, GET_YEARS(joining_date) as years_joined, MEMBERSHIP(joining_date) as membership from user_details ORDER BY membership;


CREATE [OR REPLACE] TRIGGER trigger_name  
{BEFORE | AFTER | INSTEAD OF }  
{INSERT [OR] | UPDATE [OR] | DELETE}  
[OF col_name]  
ON table_name  
[REFERENCING OLD AS o NEW AS n]  
[FOR EACH ROW]  
WHEN (condition)   
DECLARE 
   Declaration-statements 
BEGIN  
   Executable-statements 
EXCEPTION 
   Exception-handling-statements 
END;

SELECT round((sysdate-joining_date)/30.417) from bookpeople ORDER BY user_id;


CREATE OR REPLACE FUNCTION  total_fee (joining_date DATE) RETURN NUMBER IS
BEGIN
  RETURN(300*round((sysdate-joining_date)/30.417));
END;
/

SELECT username, joining_date, sysdate, total_fee(joining_date) as total_fee FROM user_details order by total_fee(joining_date) DESC;

CREATE OR REPLACE FUNCTION CAL(a number, b number, c number, op1 char, op2 char) RETURN NUMBER IS
BEGIN
if op1 = '+' and op2 = '+' then
return(a+b+c);
elsif op1='-' and op2='-' then
return(a-b-c);
elsif op1='+' and op2='-' then
return(a+b-c);
elsif op1='-' and op2='+' then
return(a-b+c);
elsif op1='*' and op2='*' then
return(a*b*c);
elsif op1='*' and op2='/' then
return(a*b/c);
elsif op1='/' and op2='*' then
return(a/b*c);
elsif op1='/' and op2='/' then
return(a/b/c);
elsif op1='+' and op2='*' then
return(a+b*c);
elsif op1='*' and op2='+' then
return(a*b+c);
elsif op1='-' and op2='/' then
return(a-b/c);
elsif op1='/' and op2='-' then
return(a/b-c);
elsif op1='+' and op2='/' then
return(a+b/c);
elsif op1='/' and op2='+' then
return(a/b+c);
elsif op1='-' and op2='*' then
return(a-b*c);
else
return(a*b-c);
END IF;
END;
/
select cal(26,27,66,'-','+') from dual;


CREATE OR REPLACE PROCEDURE "INSERTMEMBER"
(user_id IN NUMBER, username IN VARCHAR2, phone_number IN NUMBER)
is
begin
insert into user_details(user_id, username, phone_number) values(user_id, username, phone_number);
dbms_output.put_line('member added successfully');
end;
/

execute insertmember(122,'Janhvi', 8527295710);

BEGIN
insertmember(121,'Aliya', 9472950284);
END;
/

SELECT * FROM USER_DETAILS ORDER BY USER_ID;

CREATE OR REPLACE PROCEDURE "DELETE_MEMBER"
(id IN NUMBER) IS
BEGIN
   DELETE FROM user_details where user_id = id;
   dbms_output.put_line('member deleted successfully');
END;
/

BEGIN
   delete_member(121);
END;
/
EXECUTE DELETE_MEMBER(122);


CREATE OR REPLACE PROCEDURE "UPDATE_MEMBER"
(name IN VARCHAR, agee in NUMBER, ID IN NUMBER) IS
BEGIN
   UPDATE user_details SET username = name, age = agee WHERE user_id = id;
   dbms_output.put_line('Member Updated Successfully');
END;
/

BEGIN
  UPDATE_MEMBER('Amisha', 18, 106);
END;
/

SELECT * FROM USER_DETAILS WHERE USER_ID = 102;
EXECUTE UPDATE_MEMBER('Nina', 22, 105);

CREATE OR REPLACE PROCEDURE "SELECT_MEMBER"
(ID IN NUMBER) IS
BEGIN
DECLARE
   IDs NUMBER;
   Names VARCHAR(20);
   Add VARCHAR(20);
   Join DATE;
   
  BEGIN
    SELECT user_id, username, address, joining_date INTO IDs, Names, Add, Join FROM USER_DETAILS WHERE USER_ID = ID;
    DBMS_OUTPUT.PUT_LINE('User Details');
    DBMS_OUTPUT.PUT_LINE('ID: '||IDs);
    DBMS_OUTPUT.PUT_LINE('Name: '||Names);
    DBMS_OUTPUT.PUT_LINE('Address: '||Add);
    DBMS_OUTPUT.PUT_LINE('Joining Date: '||Join);

  END;
END;
/

BEGIN
  SELECT_MEMBER(102);
END;
/

EXECUTE SELECT_MEMBER(105);

CREATE OR REPLACE PROCEDURE "SQUARE_AREA"
(side in NUMBER) IS
BEGIN
DECLARE
area NUMBER;

   BEGIN
     SELECT power(side, 2) into area from dual;
     DBMS_OUTPUT.PUT_LINE('Area calculated successfully');
     DBMS_OUTPUT.PUT_LINE('Area of square is '||area);
   END; 
END;
/

BEGIN
  SQUARE_AREA(5);
END;
/
EXECUTE SQUARE_AREA (7);


/*TRIGGERS*/
CREATE OR REPLACE TRIGGER AGE_CHECK
AFTER
INSERT OR UPDATE ON user_details
FOR EACH ROW
BEGIN
  IF: new.age<18 THEN
  raise_application_error(-20001, 'Age should not be less than 18');
  END IF;
END;
/

INSERT INTO user_details (user_id, username, age) VALUES (121, 'Riya', 15);

UPDATE user_details SET age = 18 WHERE user_id = 110;










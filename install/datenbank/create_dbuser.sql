-- Start of DDL Script for User WK
-- Generated 16-Feb-2010 22:21:47 from SYS@ORCL

CREATE USER wk
IDENTIFIED BY wk
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
/
GRANT CREATE VIEW TO wk
/
GRANT UNLIMITED TABLESPACE TO wk
/
GRANT CONNECT TO wk
/
GRANT RESOURCE TO wk
/
ALTER USER wk DEFAULT ROLE ALL
/


-- End of DDL Script for User WK

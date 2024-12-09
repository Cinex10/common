--Question 1
SELECT GRANTEE, TABLE_NAME, PRIVILEGE FROM DBA_TAB_PRIVS WHERE GRANTOR = 'GANDALF';

--2
SELECT COUNT(*) FROM GANDALF.SKIPPER;

--3
SELECT v.block# as block, d.object_name, v.status FROM v$bh v, dba_objects d WHERE v.OBJD = d.OBJECT_ID AND OWNER = 'GANDALF' AND OBJECT_NAME='SKIPPER';


-- les blocs de données en mémoire vive associés au tablespace DATA_ETUD

SELECT DISTINCT b.block# as blocks FROM v$bh b JOIN DBA_DATA_FILES d on d.FILE_ID = b.FILE# WHERE d.TABLESPACE_NAME='DATA_ETUD';

--Question 5
SELECT DISTINCT dbms_rowid.rowid_block_number(rowid) as Block FROM GANDALF.SKIPPER;

--Question 7
SELECT l.object_id, o.object_name, l.session_id, l.ORACLE_USERNAME, l.OS_USER_NAME, s.machine, s.program
FROM v$locked_object l, v$session s, dba_objects o
WHERE owner = 'GANDALF' AND o.object_name = 'SKIPPER' AND l.session_id = s.sid AND l.object_id = o.object_id;

--Question 8
SELECT a.SID as sessionBloquante, s1.username as userBloquante, b.SID as sessionBloquee, s2.username as userBloquee, b.request, b.CTIME
FROM v$lock a JOIN v$lock b ON a.ID1 = b.ID1 AND a.ID2 = b.ID2 JOIN v$session s1 ON a.SID = s1.SID JOIN v$session s2 ON b.SID = s2.SID
WHERE a.SID != b.SID AND b.request > 0 AND a.block = 1;
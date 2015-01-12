/*begin-sql on-error=warn             -- !will issues warning message if
                                   -- tables do not exist
        drop table {item_table};
        drop table {cost_table};
        drop table {report_table};
end-sql

begin-sql on-error=warn           --  ! Will create */ -- table if table
                                  -- does not exist
--         create table {item_table}
--             (major       VARCHAR2(5),
--              minor       VARCHAR2(5),
--              vendor      VARCHAR2(4),
--              cat         VARCHAR2(5),
--              style       VARCHAR2(5),
--              description VARCHAR2(30),
--              vsn         VARCHAR2(30),
--              i_size      VARCHAR2(3),
--              )
--              @
-- 
DROP TABLE NEWONE @
CREATE TABLE NEWONE(
MONEY DOUBLE NOT NULL
GENERATED ALWAYS AS((EMPLOYEE.SALARY + EMPLOYEE.BONUS)/0.2)
)
@
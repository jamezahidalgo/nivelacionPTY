-- Crea unidades de programación
CREATE OR REPLACE FUNCTION fn_totalColaboradores(p_empresa NUMBER) RETURN NUMBER IS
    v_total NUMBER;
BEGIN
    SELECT COUNT(co_rut) INTO v_total
    FROM colaborador
    WHERE empresa_em_codigo = p_empresa;
    RETURN v_total;
END;

CREATE OR REPLACE PACKAGE pkg_empresa IS
    PROCEDURE pr_create(p_nombre VARCHAR2);
    PROCEDURE pr_read(p_codigo NUMBER, p_nombre OUT VARCHAR2);
    PROCEDURE pr_update(p_codigo VARCHAR2, p_nombre VARCHAR2);
    PROCEDURE pr_readAll(p_records OUT SYS_REFCURSOR);
END;
CREATE OR REPLACE PACKAGE BODY pkg_empresa IS
    -- Create
    PROCEDURE pr_create(p_nombre VARCHAR2) IS
    BEGIN
        INSERT INTO empresa VALUES(seq_empresa.NEXTVAL, p_nombre);
    EXCEPTION WHEN DUP_VAL_ON_INDEX THEN
        INSERT INTO error_proceso VALUES(seq_error.NEXTVAL, 'Empresa duplicada');
    END;
    -- Read
    PROCEDURE pr_read(p_codigo NUMBER, p_nombre OUT VARCHAR2) IS
    BEGIN
        SELECT em_nombre INTO p_nombre
        FROM empresa
        WHERE em_codigo = p_codigo;
    END;
    -- Update
    PROCEDURE pr_update(p_codigo VARCHAR2, p_nombre VARCHAR2) IS
    BEGIN
        UPDATE empresa
        SET em_nombre = p_nombre
        WHERE em_codigo = p_codigo;
    END;
    PROCEDURE pr_readAll(p_records OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN p_records FOR SELECT * FROM empresa;
    END;
END;

-- Test del procedimiento para retornar el cursor
SET SERVEROUTPUT ON;
DECLARE
    v_cursor SYS_REFCURSOR;
    v_nombre empresa.em_nombre%TYPE;
BEGIN
    pkg_empresa.pr_readAll(v_cursor);
    LOOP
        FETCH v_cursor INTO v_nombre;
        EXIT WHEN v_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_nombre);
    END LOOP;
    CLOSE v_cursor;
END;
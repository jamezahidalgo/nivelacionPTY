-- Generado por Oracle SQL Developer Data Modeler 19.4.0.350.1424
--   en:        2021-08-05 11:07:41 CLT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE TABLE colaborador (
    co_rut            NUMBER NOT NULL,
    co_nombre         VARCHAR2(50) NOT NULL,
    empresa_em_codigo    NUMBER NOT NULL,
    comuna_cm_codigo  NUMBER NOT NULL
);

ALTER TABLE colaborador ADD CONSTRAINT colaborador_pk PRIMARY KEY ( co_rut );

CREATE TABLE comuna (
    cm_codigo  NUMBER NOT NULL,
    cm_nombre  VARCHAR2(50) NOT NULL
);

ALTER TABLE comuna ADD CONSTRAINT comuna_pk PRIMARY KEY ( cm_codigo );

CREATE TABLE empresa (
    em_codigo     NUMBER NOT NULL,
    em_nombre  VARCHAR2(50) NOT NULL
);

ALTER TABLE empresa ADD CONSTRAINT empresa_pk PRIMARY KEY ( em_codigo );

ALTER TABLE colaborador
    ADD CONSTRAINT colaborador_comuna_fk FOREIGN KEY ( comuna_cm_codigo )
        REFERENCES comuna ( cm_codigo );

ALTER TABLE colaborador
    ADD CONSTRAINT colaborador_empresa_fk FOREIGN KEY ( empresa_em_codigo )
        REFERENCES empresa ( em_codigo );

CREATE SEQUENCE seq_error;
CREATE TABLE error_proceso(
    er_id NUMBER PRIMARY KEY,
    er_descripcion VARCHAR2(60) NOT NULL
);

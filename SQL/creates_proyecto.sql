DROP TABLE DIRECCIONES CASCADE CONSTRAINTS;
DROP TABLE KILOMETROS CASCADE CONSTRAINTS;
DROP TABLE GASTOS CASCADE CONSTRAINTS;
DROP TABLE CENTRO CASCADE CONSTRAINTS;
DROP TABLE TRABAJADOR CASCADE CONSTRAINTS;
DROP TABLE LOGIN CASCADE CONSTRAINTS;
DROP TABLE AVISO CASCADE CONSTRAINTS;
DROP TABLE VEHICULO CASCADE CONSTRAINTS;
DROP TABLE VIAJE CASCADE CONSTRAINTS;
DROP TABLE PARTE CASCADE CONSTRAINTS;
 
 
CREATE TABLE direcciones (
  id_dir NUMBER,
  provincia VARCHAR(20),
  ciudad VARCHAR(20),  
  calle VARCHAR2(30)  NOT NULL,
  numero NUMBER(3)  NOT NULL,
  piso NUMBER(30),
  mano VARCHAR2(3),
  codigo_postal NUMBER(5),
  CONSTRAINT dir_id_pk PRIMARY KEY (id_dir)
);
 
INSERT INTO DIRECCIONES VALUES (01, 'Álava', 'Vitoria-Gasteiz', 'C/ San Bernardo',
12, 1, 'D', 01006);
INSERT INTO DIRECCIONES VALUES (20, 'Álava', 'Vitoria-Gasteiz', 'C/ Escuela',
1, NULL, NULL, 01006);
  
CREATE TABLE kilometros (
  id_km NUMBER,
  km_inicio NUMBER(5,3),
  km_final NUMBER(5,3),
  CONSTRAINT km_id_pk PRIMARY KEY (id_km)
);
  
CREATE TABLE gastos (
  id_gasto NUMBER, 
  gasoil NUMBER(3,2),
  peaje NUMBER(2,2),
  dietas NUMBER(3,2),
  otros NUMBER(5,2),
  CONSTRAINT gas_id_pk PRIMARY KEY (id_gasto)
);
  
CREATE TABLE Centro ( 
  id_centro NUMBER(2),
  Nombre VARCHAR2 (20) NOT NULL,
  Direccion NUMBER NOT NULL,
  Telefono NUMBER (9) NOT NULL,
  CONSTRAINT cen_cod_pk PRIMARY KEY (id_centro),
  CONSTRAINT cen_dir_fk FOREIGN KEY (Direccion) REFERENCES Direcciones(id_dir)
);
 
INSERT INTO CENTRO VALUES (01, 'Programación Pepe', 20, 945656565);
  
CREATE TABLE Trabajador (
  DNI VARCHAR2 (9),
  Nombre VARCHAR2 (20) NOT NULL,
  Apellido1 VARCHAR2 (30) NOT NULL,
  Apellido2 VARCHAR2 (30) NOT NULL,
  Direccion NUMBER (5) NOT NULL,
  Tel_Emp NUMBER (9) NOT NULL,
  Tel_Per NUMBER (9),
  Salario NUMBER (7,2),
  Fecha_Nac DATE,
  tipo VARCHAR2(20),
  id_Centro NUMBER (2) NOT NULL,
  CONSTRAINT tra_dni_pk PRIMARY KEY (DNI),
  CONSTRAINT tra_cen_fk FOREIGN KEY (id_Centro) REFERENCES Centro(id_centro),
  CONSTRAINT tra_dir_fk FOREIGN KEY (Direccion) REFERENCES Direcciones(id_dir),
  CONSTRAINT tra_tipo_ck CHECK (lower(tipo) in ('logistica','administracion'))
);
 
INSERT INTO TRABAJADOR VALUES ('12312312A', 'Asier', 'Suárez','Ubierna',
01, 945945945, 688688688, 2000.00, TO_DATE('1997/01/01', 'yyyy/mm/dd'),
'administracion', 01);
 
CREATE TABLE Login (
  DNI VARCHAR2(9),
  usuario VARCHAR2(20) NOT NULL,
  contraseña VARCHAR2(20) NOT NULL,
  CONSTRAINT logn_dni_pk PRIMARY KEY (DNI),
  CONSTRAINT logn_dni_fk FOREIGN KEY (DNI) REFERENCES Trabajador(DNI)  
);
 
INSERT INTO LOGIN VALUES ('12312312A', 'asuarez', 'asuarez');
  
CREATE TABLE aviso (
  id_aviso NUMBER,
  descripcion VARCHAR2(200),
  DNI VARCHAR2(9),
  CONSTRAINT avi_id_pk PRIMARY KEY (id_aviso),
  CONSTRAINT avi_dni_fk FOREIGN KEY (DNI) REFERENCES Trabajador(DNI)
);
  
CREATE TABLE Vehiculo (
  Matricula VARCHAR2(10),
  Marca VARCHAR2(20),
  Modelo VARCHAR2(20),
  Peso NUMBER(5,3) NOT NULL,
  CONSTRAINT veh_mat_pk PRIMARY KEY (Matricula)
);
  
CREATE TABLE Parte (
  Albaran NUMBER,
  Matricula VARCHAR2(10) NOT NULL,
  DNI VARCHAR2 (9) NOT NULL,
  Kilometros NUMBER NOT NULL,
  Validacion VARCHAR2(2) NOT NULL,
  Gastos NUMBER,
  Incidencias VARCHAR2(300),
  CONSTRAINT par_alb_pk PRIMARY KEY (Albaran),
  CONSTRAINT par_dni_fk FOREIGN KEY (DNI) REFERENCES Trabajador(DNI),
  CONSTRAINT par_mat_fk FOREIGN KEY (Matricula) REFERENCES Vehiculo (Matricula),
  CONSTRAINT par_val_ck CHECK (lower(Validacion) IN ('si','no')),
  CONSTRAINT par_gas_fk FOREIGN KEY (Gastos) REFERENCES Gastos(id_gasto),
  CONSTRAINT par_km_fk FOREIGN KEY (Kilometros) REFERENCES Kilometros(id_km)
);
  
CREATE TABLE viaje (
  id_viaje NUMBER,
  hora_ini NUMBER(2,2) NOT NULL,
  hora_fin NUMBER(2,2) NOT NULL,
  albaran NUMBER,
  CONSTRAINT via_id_pk PRIMARY KEY (id_viaje),
  CONSTRAINT via_alb_fk FOREIGN KEY (albaran) REFERENCES parte (albaran)
);
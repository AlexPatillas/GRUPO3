SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE LECTURA_TRABAJADORES
IS
CURSOR CURSOR_TRABAJADORES IS
  SELECT DNI,NOMBRE,APELLIDO1,APELLIDO2,DIRECCION,TEL_EMP,TEL_PER,SALARIO,FECHA_NAC,TIPO,ID_CENTRO FROM TRABAJADOR;
  REG CURSOR_TRABAJADORES%ROWTYPE;
BEGIN 
  OPEN CURSOR_TRABAJADORES;
LOOP
  FETCH CURSOR_TRABAJADORES INTO REG;
  EXIT WHEN CURSOR_TRABAJADORES%NOTFOUND;
  DBMS_OUTPUT.PUT_LINE(reg.DNI || ' ' || reg.NOMBRE || ' ' || REG.APELLIDO1 || ' ' || REG.APELLIDO2 || ' ' || REG.DIRECCION || ' ' || REG.TEL_EMP || ' ' || REG.TEL_PER || ' ' || REG.SALARIO || ' ' || REG.FECHA_NAC || ' ' || REG.TIPO || ' ' || REG.ID_CENTRO);
END LOOP;
CLOSE CURSOR_TRABAJADORES;
END;




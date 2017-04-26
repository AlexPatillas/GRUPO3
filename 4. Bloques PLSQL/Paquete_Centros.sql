CREATE OR REPLACE PACKAGE BODY GESTIONAR_CENTRO 
IS
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  
  PROCEDURE VISUALIZAR_LISTA_CENTRO(C_CENTROS OUT CURSOR_CENTROS)
  IS
  BEGIN 
    OPEN C_CENTROS
    FOR
      SELECT * FROM CENTRO;    
  END;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==
  
  PROCEDURE VISUALIZAR_DATOS_CENTRO(P_ID IN NUMBER, C_CENTROS OUT CURSOR_CENTROS,PNUM_TRABAJADORES OUT NUMBER)
  IS
  BEGIN
    OPEN C_CENTROS
    FOR 
      SELECT * 
      FROM CENTRO
      WHERE ID_CENTRO = P_ID;
    SELECT COUNT(DNI) AS "Trabajadores del centro" INTO PNUM_TRABAJADORES
    FROM TRABAJADOR
    WHERE ID_CENTRO = P_ID;
      IF PNUM_TRABAJADORES IS NULL THEN
      RAISE_APPLICATION_ERROR (-20012, 'Tabla trabajadores vacía');
      END IF;
  END;
  
--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==--==

  PROCEDURE VISUALIZAR_DATOS_CENTRO_NOMBRE(P_NOMBRE IN VARCHAR2, C_CENTROS OUT CURSOR_CENTROS,PNUM_TRABAJADORES OUT NUMBER)
  IS
  BEGIN
    OPEN C_CENTROS FOR
      SELECT *
      FROM CENTRO 
      WHERE UPPER(NOMBRE)=UPPER(P_NOMBRE);
    SELECT COUNT(DNI) AS "Trabajadores del centro" INTO PNUM_TRABAJADORES
    FROM TRABAJADOR 
    WHERE UPPER(NOMBRE)=UPPER(P_NOMBRE);
    IF PNUM_TRABAJADORES IS NULL THEN
      RAISE_APPLICATION_ERROR(-20100, 'Tabla de trabajadores vacía');
    END IF;
  END;
  
END;
--Procedimiento de almacenado que permite reemplazar la sentencia DBMS_OUTPUT.PUT_LINE por un cualquier otro nombre
/
CREATE OR REPLACE PROCEDURE PL
(
  CADENA VARCHAR2
)
IS
BEGIN
DBMS_OUTPUT.PUT_LINE(CADENA);
END;
/
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--Procedimiento de alamcenado que permite actualizar la renta de cualquier vivienda 

CREATE OR REPLACE PROCEDURE actualizaRentaPropiedad
(
id_propiedad NUMBER,
nueva_renta number
)
IS
BEGIN
  UPDATE propiedad
    SET renta=nueva_renta
    WHERE id_propiedad = id_propiedad;
    EXCEPTION-------------------------Exception que captura el error al no encontrar una propiedad
    WHEN NO_DATA_FOUND THEN
    PL('La propiedad ingresada no existe');

END actualizaRentaPropiedad;

/
--Bloque anónimo que permite comprobar el procedimiento
--id_propiedad corresponde al numero 1 del primer parámetro, mientras que nueva_renta corresponde al segundo parámetr 20.000
BEGIN
  actualizaRentaPropiedad(1,200000);
END;
/
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--Función que deuelve el valor de una propiedad ingresada según el identificadoe

CREATE OR REPLACE FUNCTION fn_Obtener_renta
(
  id_pro number
) 
RETURN NUMBER
IS
  valor NUMBER;
BEGIN
  SELECT renta 
  INTO valor
  FROM propiedad
  WHERE id_propiedad = id_pro;
  return(valor);
EXCEPTION 
WHEN NO_DATA_FOUND THEN
  return 0;
END ;
/
--Bloque anónimo que permite ver los datos de la función
--El número 1 del parámetro corresponde al id_propiedad 1
DECLARE
  renta_pro NUMBER;
BEGIN
	renta_pro := fn_Obtener_renta(1);
  pl(renta_pro);
END; 
/
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

---Trigger que no permite realizar inserciones, elimincaciones ni actualizaciones de datos en arriendo los fines de semanas

CREATE OR REPLACE TRIGGER TR_semanaHora
after insert or delete or update on arriendo
FOR EACH ROW
DECLARE
BEGIN
 IF to_char(SYSDATE,'FMday')='Sabado' OR to_char(SYSDATE,'FMday')='domingo'  
THEN
    raise_application_error(-20002,'IMPOSIBLE INGRESAR DATOS EN FIN DE 
SEMANA');
  END IF;
END;
/

--Trigger que muestra los cambios en las rentas de las propieadades

CREATE OR REPLACE TRIGGER trg_muestraCambioRenta
BEFORE DELETE OR INSERT OR UPDATE ON propieadades
FOR EACH ROW
WHEN (NEW.id_propiedad > 0)
DECLARE
   renta_diferencia number;
BEGIN
   sal_diff := :NEW.salary  - :OLD.renta;
   dbms_output.put_line('Renta antigua: ' || :OLD.renta);
   dbms_output.put_line('Nueva renta: ' || :NEW.renta);
   dbms_output.put_line('Direrencia en renta: ' || renta_diferencia);
END;
/

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
--Cursor que permite ver la cantidad de visitas de una propiedad y el nombre del dueño
DECLARE 
	CURSOR C1 IS
		SELECT COUNT(vi.propiedad_id_propiedad) Visitas, 
		pr.nombre Nombre
		FROM Visita vi 
    INNER JOIN Propiedad pr
		ON vi.Propiedad_id_propiedad = pr.id_propiedad
		JOIN Propietario pr
		ON pr.Propiedad_id_propiedad  = pr.id_propiedad
		GROUP BY pr.nombre
		HAVING COUNT(vi.propiedad_id_propiedad) >1;
BEGIN
	FOR c_visitas IN C1 LOOP
		dbms_output.put_line('CONTADOR DE VISITAS: ' || c_visitas.visitas||
    ' NOMBRE DE PROPIETARIO: ' || c_visitas.nombre);
	END LOOP;
END;
/

--FUNCION QUE RETORNA DATOS DEL CURSOR

CREATE OR REPLACE FUNCTION fx_retornaCursor
  RETURN SYS_REFCURSOR
AS
  C1 SYS_REFCURSOR;
BEGIN
  OPEN C1 FOR 
  SELECT COUNT(vi.propiedad_id_propiedad) Visitas, pr.nombre Nombre
    FROM Visita vi 
    INNER JOIN Propiedad pr
    ON vi.Propiedad_id_propiedad=pr.id_propiedad
    JOIN Propietario pr
    ON pr.Propiedad_id_propiedad=pr.id_propiedad
    GROUP BY pr.nombre
    HAVING COUNT(vi.propiedad_id_propiedad)>1;

    --EXCEPTION
     --WHEN NO_DATA_FOUND THEN
      --DBMS_OUTPUT.PUT_LINE('No se ha encontrado al propietario'|| nombre);
  RETURN C1;
END fx_retornaCursor;
/
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--CURSOR QUE MUESTRA DATOS DE LOS CLIENTES REGUSTRADOS EN LA CORREDORA DE PROPIEADADES
DECLARE
CURSOR C_CLIENTES IS

SELECT *
FROM CLIENTE;
CLI C_CLIENTES%ROWTYPE;

BEGIN
OPEN C_CLIENTES;

LOOP

FETCH C_CLIENTES INTO CLI;
EXIT WHEN C_CLIENTES%NOTFOUND;
SYS.dbms_output.put_line('Nombre cliente: '|| CLI.NOMBRE);
SYS.dbms_output.put_line('Dirección: '|| CLI.DIRECCION);
SYS.dbms_output.put_line('Teléfono: '|| CLI.telefono);
SYS.dbms_output.put_line('Correo: '|| CLI.email);
END LOOP;
CLOSE C_CLIENTES;
END;
/

--FUNCION QUE RETORNA LOS DATOS DEL CURSOR

CREATE OR REPLACE FUNCTION fx_retornaClientes 
  RETURN SYS_REFCURSOR
AS
  C1 SYS_REFCURSOR;
BEGIN
  OPEN C1 FOR 

SELECT *
FROM CLIENTE;

EXCEPTION
 WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No se han encontrado datos');
  RETURN C1;
END fx_retornaClientes;
/
--TRIGGER QUE REGISTRA EN UNA TABLA ANEXA AL MOMENTO DE INGRESAR UN NUEVO CLIENTE A LA CORREDORA


CREATE OR REPLACE TRIGGER cliente_despues_insertar
AFTER insert
   ON cliente
   FOR EACH ROW

DECLARE
   v_username varchar(150);

BEGIN
  --Busca usuario (empleado) quien ingreso un nuevo cliente a la corredora
   SELECT user 
   INTO v_username
   FROM dual;

   -- Ingresa info a la tabla audita clientes
   INSERT INTO audita_clientes
   ( id_cliente,
     rut,
     nombre,
     apellido,
     dv,
     fecha_ingreso,
     ingresado_por )
   VALUES
   ( :new.id_cliente,
     :new.rut,
     :new.nombre,
     :new.apellido,
     :new.dv,
      sysdate,
      v_username );
END;

/



------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------

--PROCEDIMIENTO DE ALAMCENADO QUE INSERTA UNA NUEVA CIUDAD A LA BASE DE DATOS 
--EN CASO DE EXPANDIR LAS OFICINAS DE LA CORREDORA
CREATE OR REPLACE PROCEDURE INSERTA_CIUDAD
(
	LIDCIUDAD NUMBER,
	LNOMCIUDAD VARCHAR2
)
IS
BEGIN
INSERT INTO CIUDAD VALUES(LIDCIUDAD,LNOMCIUDAD);

END INSERTA_CIUDAD;


/
--PROCEDIMIENTO QUE INGRESA DATOS A LA TABLA TOTPROPEMPLEADO
--A-----------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE INICIALIZAPROPIEDADEMPLEADO
IS
BEGIN
  FOR REG IN (SELECT E.NUMEMPLEADO NUEMPLEADO, COUNT(P.NUMPROPIEDAD) TOTPROP
              FROM EMPLEADO E LEFT JOIN PROPIEDAD P 
              ON E.NUMEMPLEADO=P.NUMEMPLEADO
              GROUP BY E.NUMEMPLEADO) 
  LOOP
    INSERT INTO TOTPROPEMPLEADO VALUES (REG.NUEMPLEADO, REG.TOTPROP);
    END LOOP;
END INICIALIZAPROPIEDADEMPLEADO;

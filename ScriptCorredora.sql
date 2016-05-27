--Región de borrado de objetos
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

Drop table audita_clientes  cascade constraint;
Drop table arriendo cascade constraint;
Drop table ciudad cascade constraint;
Drop table cliente cascade constraint;
Drop table empleado cascade constraint;
Drop table oficina cascade constraint;
Drop table propiedad cascade constraint;
Drop table propietario cascade constraint;
Drop table publicacion cascade constraint;
Drop table tipo_usuario cascade constraint;
Drop table visita cascade constraint;

--Región de creación de objetos
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------


create table audita_clientes
(
id_cliente number, 
rut number,
nombre varchar2(200),
apellido varchar2(200),
dv varchar2(150),
fecha_ingreso date,
ingresado_por varchar2(150)
);



CREATE TABLE Arriendo
  (
    id_arriendo            NUMBER NOT NULL ,
    renta                  NUMBER NOT NULL ,
    forma_pago             VARCHAR2(50) NOT NULL,
    inicio_renta           DATE NOT NULL ,
    fin_renta              DATE NOT NULL ,
    Propiedad_id_propiedad NUMBER NOT NULL
  ) ;
ALTER TABLE Arriendo ADD CONSTRAINT Arriendo_PK PRIMARY KEY ( id_arriendo ) ;


CREATE TABLE Ciudad
  (
    id_ciudad     NUMBER NOT NULL ,
    nombre_ciudad VARCHAR2 (100) NOT NULL
  ) ;
ALTER TABLE Ciudad ADD CONSTRAINT Ciudad_PK PRIMARY KEY ( id_ciudad ) ;


CREATE TABLE Cliente
  (
    id_cliente   NUMBER NOT NULL ,
    rut          NUMBER NOT NULL ,
    dv           CHAR (1) NOT NULL ,
    nombre       VARCHAR2 (100) NOT NULL ,
    apellido     VARCHAR2 (150) NOT NULL ,
    estado_civil VARCHAR2 (20) NOT NULL ,
    telefono     VARCHAR2 (15) NOT NULL ,
    direccion    VARCHAR2 (150) NOT NULL ,
    email        VARCHAR2 (150) ,
    sexo         CHAR (1) NOT NULL 
  ) ;
  ALTER TABLE Cliente ADD CONSTRAINT Cliente_PK PRIMARY KEY ( id_cliente ) ;


CREATE TABLE Empleado
  (
    id_empleado 	              NUMBER NOT NULL ,
    rut                       NUMBER (10) NOT NULL ,
    dv                        CHAR (1) NOT NULL ,
    nombre                    VARCHAR2 (100) NOT NULL ,
    apellido                  VARCHAR2 (100) NOT NULL ,
    cargo                     VARCHAR2 (100) NOT NULL ,
    sexo                      CHAR (1) NOT NULL ,
    fech_nac                  DATE NOT NULL ,
    estado_civil              VARCHAR2 (20) NOT NULL ,
    direccion                 VARCHAR2 (150) NOT NULL ,
    username                  VARCHAR2 (50) NOT NULL ,
    pass                      VARCHAR2 (50) NOT NULL ,
    Oficina_id_oficina        NUMBER NOT NULL ,
    Tipo_usuario_id_tipo_user NUMBER NOT NULL
  ) ;
ALTER TABLE Empleado ADD CONSTRAINT Empleado_PK PRIMARY KEY ( id_empleado ) ;


CREATE TABLE Oficina
  (
    id_oficina NUMBER NOT NULL ,
    direccion  VARCHAR2 (150) NOT NULL ,
    cod_postal NUMBER
  ) ;
ALTER TABLE Oficina ADD CONSTRAINT Oficina_PK PRIMARY KEY ( id_oficina ) ;


CREATE TABLE Propiedad
  (
    id_propiedad               NUMBER NOT NULL ,
    direccion                  VARCHAR2 (150) NOT NULL ,
    cod_postal                 NUMBER ,
    tipo_propiedad             VARCHAR2 (150) NOT NULL ,
    cantidad_habi              NUMBER NOT NULL ,
    cantidad_baths             NUMBER NOT NULL ,
    renta                      NUMBER NOT NULL ,
    Empleado_id_empleado       NUMBER NOT NULL ,
    Ciudad_id_ciudad           NUMBER NOT NULL ,
    Publicacion_id_publicacion NUMBER NOT NULL
  ) ;
ALTER TABLE Propiedad ADD CONSTRAINT Propiedad_PK PRIMARY KEY ( id_propiedad ) ;


CREATE TABLE Propietario
  (
    id_propietario         NUMBER NOT NULL ,
    rut                    NUMBER NOT NULL ,
    dv                     CHAR (1) NOT NULL ,
    nombre                 VARCHAR2 (100) NOT NULL ,
    apellido               VARCHAR2 (150) NOT NULL ,
    estado_civil           VARCHAR2 (100) NOT NULL ,
    telefono               VARCHAR2 (15) NOT NULL ,
    direccion              VARCHAR2 (150) NOT NULL ,
    email                  VARCHAR2 (150) ,
    Propiedad_id_propiedad NUMBER NOT NULL
  ) ;
ALTER TABLE Propietario ADD CONSTRAINT Propietario_PK PRIMARY KEY ( id_propietario ) ;


CREATE TABLE Publicacion
  (
    id_publicacion NUMBER NOT NULL ,
    inicio_publi   DATE NOT NULL ,
    fin_publi      DATE NOT NULL ,
    medio          VARCHAR2 (150) NOT NULL ,
    comentario     VARCHAR2 (300)
  ) ;
ALTER TABLE Publicacion ADD CONSTRAINT Publicacion_PK PRIMARY KEY ( id_publicacion ) ;


CREATE TABLE Tipo_usuario
  (
    id_tipo_user NUMBER NOT NULL ,
    nombre_tipo  VARCHAR2 (150) NOT NULL ,
    descripcion  VARCHAR2 (200)
  ) ;
ALTER TABLE Tipo_usuario ADD CONSTRAINT Tipo_usuario_PK PRIMARY KEY ( id_tipo_user ) ;


CREATE TABLE Visita
  (
    id_visita              NUMBER NOT NULL ,
    fecha                  DATE NOT NULL ,
    comentario             VARCHAR2 (200) ,
    Propiedad_id_propiedad NUMBER NOT NULL ,
    id_cliente             NUMBER NOT NULL
  ) ;
ALTER TABLE Visita ADD CONSTRAINT Visita_PK PRIMARY KEY ( id_visita ) ;


--Región de llaves foráneas
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------

ALTER TABLE Arriendo ADD CONSTRAINT Arriendo_Propiedad_FK FOREIGN KEY ( Propiedad_id_propiedad ) REFERENCES Propiedad ( id_propiedad ) ;

ALTER TABLE Empleado ADD CONSTRAINT Empleado_Oficina_FK FOREIGN KEY ( Oficina_id_oficina ) REFERENCES Oficina ( id_oficina ) ;

ALTER TABLE Empleado ADD CONSTRAINT Empleado_Tipo_usuario_FK FOREIGN KEY ( Tipo_usuario_id_tipo_user ) REFERENCES Tipo_usuario ( id_tipo_user ) ;

ALTER TABLE Propiedad ADD CONSTRAINT Propiedad_Ciudad_FK FOREIGN KEY ( Ciudad_id_ciudad ) REFERENCES Ciudad ( id_ciudad ) ;

ALTER TABLE Propiedad ADD CONSTRAINT Propiedad_Empleado_FK FOREIGN KEY ( Empleado_id_empleado ) REFERENCES Empleado ( id_empleado ) ;

ALTER TABLE Propiedad ADD CONSTRAINT Propiedad_Publicacion_FK FOREIGN KEY ( Publicacion_id_publicacion ) REFERENCES Publicacion ( id_publicacion ) ;

ALTER TABLE Propietario ADD CONSTRAINT Propietario_Propiedad_FK FOREIGN KEY ( Propiedad_id_propiedad ) REFERENCES Propiedad ( id_propiedad ) ;

ALTER TABLE Visita ADD CONSTRAINT Visita_Cliente_FK FOREIGN KEY (id_cliente ) REFERENCES Cliente (id_cliente ) ;

ALTER TABLE Visita ADD CONSTRAINT Visita_Propiedad_FK FOREIGN KEY ( Propiedad_id_propiedad ) REFERENCES Propiedad ( id_propiedad ) ;


--Región de inserión de datos
----------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------

--Regiòn de inserción de datos tabla Ciudad

insert into ciudad (id_ciudad,nombre_ciudad)values(1, 'Santiago');
insert into ciudad (id_ciudad,nombre_ciudad)values(2, 'Valparaiso');
insert into ciudad (id_ciudad,nombre_ciudad)values(3, 'Temuco');
insert into ciudad (id_ciudad,nombre_ciudad)values(4, 'Concepción');
insert into ciudad (id_ciudad,nombre_ciudad)values(5, 'Punta Arenas');

--Regiòn de inserción de datos tabla Oficina

insert into oficina (id_oficina,direccion,cod_postal)values(1, 'Fernández Concha 700, Las Condes',100);
insert into oficina (id_oficina,direccion,cod_postal)values(2, 'Príncipe de Gales 6141, La Reina. ',101);
insert into oficina (id_oficina,direccion,cod_postal)values(3, 'Javiera Carrera Sur 564, La Reina',102);
insert into oficina (id_oficina,direccion,cod_postal)values(4, 'Calle Agustinas 2009, Santiago',103);
insert into oficina (id_oficina,direccion,cod_postal)values(5, 'Av. Martín Lutero 01200,Temuco',104);

--Regiòn de inserción de datos tabla Tipo Usuario
insert into tipo_usuario (id_tipo_user,nombre_tipo,descripcion)values(1, 'Admin','Administrador del sitio');
insert into tipo_usuario (id_tipo_user,nombre_tipo,descripcion)values(2, 'Gerente','Revision de viviendas');
insert into tipo_usuario (id_tipo_user,nombre_tipo,descripcion)values(3, 'Empleado',' Renta de viviendas');
insert into tipo_usuario (id_tipo_user,nombre_tipo,descripcion)values(4, 'Recuros Humanos',' Gestión de empleados');

--Regiòn de inserción de datos tabla Empleado 
insert into empleado (id_empleado,rut,dv,nombre,apellido,cargo,sexo,fech_nac,estado_civil,direccion,username,pass,oficina_id_oficina,tipo_usuario_id_tipo_user)
values(1,17292158,'K','Margarita','Canales Muñoz','Corredor de propiedades','F','06/01/1988','Soltera','Av. Kennedy 2090, Las Condes','MaruCanales','1234',1,1);

insert into empleado (id_empleado,rut,dv,nombre,apellido,cargo,sexo,fech_nac,estado_civil,direccion,username,pass,oficina_id_oficina,tipo_usuario_id_tipo_user)
values(2,16589456,'2','Cristian','Popa Polando','Gerente general','M','20/12/1988','Casado','Av. Cerro Colorado, La Reina','CriPopa','1234',2,2);

insert into empleado (id_empleado,rut,dv,nombre,apellido,cargo,sexo,fech_nac,estado_civil,direccion,username,pass,oficina_id_oficina,tipo_usuario_id_tipo_user)
values(3,17292158,'K','Natalia','Galindo Muñoz','Corredor de propiedades','F','07/02/1988','Casada','Condell 1047, Santiago Centro',' NatGalindo','1234',3,3);

insert into empleado (id_empleado,rut,dv,nombre,apellido,cargo,sexo,fech_nac,estado_civil,direccion,username,pass,oficina_id_oficina,tipo_usuario_id_tipo_user)
values(4,17677090,'9','Andrea','Sidgman Guzmán','Recursos Humanos','F','02/05/1988','Soltera','Marathon 110, Ñuñoa','AndSidgman','1234',4,4);

--Regiòn de inserción de datos tabla Publicación
insert into publicacion (id_publicacion,inicio_publi,fin_publi,medio,comentario)values(1,'02/01/2016','01/02/2016','Diario La Tercera','Publicación válidad');
insert into publicacion (id_publicacion,inicio_publi,fin_publi,medio,comentario)values(2,'03/05/2016','04/06/2016','Diario Publimetro','Publicación válidad');
insert into publicacion (id_publicacion,inicio_publi,fin_publi,medio,comentario)values(3,'04/06/2016','05/07/2016','Sitio web Trovil.cl','Publicación válidad');
insert into publicacion (id_publicacion,inicio_publi,fin_publi,medio,comentario)values(4,'05/07/2016','06/08/2016','Diario El Mercurio','Publicación válidad');
insert into publicacion (id_publicacion,inicio_publi,fin_publi,medio,comentario)values(5,'06/08/2016','07/09/2016','Diraio Inmobiliario','Publicación válidad');


--Regiòn de inserción de datos tabla Propiedad



insert into propiedad (id_propiedad,direccion,cod_postal,tipo_propiedad,cantidad_habi,cantidad_baths,renta,empleado_id_empleado,ciudad_id_ciudad,publicacion_id_publicacion)
values(1,'Agustinas 972 Santiago Centro',200,'Departamento',2,1,250000,1,1,1);

insert into propiedad (id_propiedad,direccion,cod_postal,tipo_propiedad,cantidad_habi,cantidad_baths,renta,empleado_id_empleado,ciudad_id_ciudad,publicacion_id_publicacion)
values(2,'Manquehue Norte 1796, Las Condes',201,'Casa',4,2,55000,2,2,2);

insert into propiedad (id_propiedad,direccion,cod_postal,tipo_propiedad,cantidad_habi,cantidad_baths,renta,empleado_id_empleado,ciudad_id_ciudad,publicacion_id_publicacion)
values(3,' Av. Circunvalación las Flores 12870, Las Condes',203,'Casa',5,3,835000,3,3,3);

insert into propiedad (id_propiedad,direccion,cod_postal,tipo_propiedad,cantidad_habi,cantidad_baths,renta,empleado_id_empleado,ciudad_id_ciudad,publicacion_id_publicacion)
values(4,' Santa Mónica 2239, Santiago Centro',204,'Departamento Estudio',1,1,250000,4,4,4);


--Regiòn de inserción de datos tabla Arriendo
insert into arriendo (id_arriendo,renta,forma_pago,inicio_renta,fin_renta,propiedad_id_propiedad)values(1,250000,'Efectivo','01/01/2015','01/12/2015',1);
insert into arriendo (id_arriendo,renta,forma_pago,inicio_renta,fin_renta,propiedad_id_propiedad)values(2,550000,'Tarjeta de crédito','01/02/2015','01/11/2015',2);
insert into arriendo (id_arriendo,renta,forma_pago,inicio_renta,fin_renta,propiedad_id_propiedad)values(3,600000,'Cheque','01/03/2015','01/10/2015',3);
insert into arriendo (id_arriendo,renta,forma_pago,inicio_renta,fin_renta,propiedad_id_propiedad)values(4,970000,'Efectivo','01/04/2015','01/09/2015',4);

--Regiòn de inserción de datos tabla Cliente
insert into cliente(id_cliente,rut,dv,nombre,apellido,estado_civil,telefono,direccion,email,sexo)
values(1,67444289,'5','Maria Jóse','Poblete Muñoz','Soltera','44780912','Av. Libertador Bernardo O`Higgins 621,Santiago Centro','cotpmunoz@hotmail.com','F');

insert into cliente(id_cliente,rut,dv,nombre,apellido,estado_civil,telefono,direccion,email,sexo)
values(2,67333456,'7','Rossana','Guerrero Flores','Casada','6755670','Camino El Alba 9280, Las Condes','rossgerrero@hotmail.com','F');

insert into cliente(id_cliente,rut,dv,nombre,apellido,estado_civil,telefono,direccion,email,sexo)
values(3,12345098,'2','Cristian','Toro Carreño','Soltero','56435600','Tomás Moro 1651, Valparíso','torolive@live.com','M');

insert into cliente(id_cliente,rut,dv,nombre,apellido,estado_civil,telefono,direccion,email,sexo)
values(4,19787123,'K','Hector','Gonzalez Duarte','Soltero','67891212','Av. Colón 9188, Temuco','denuevolomimismo@gmail.com','M');

--Regiòn de inserción de datos tabla Propietario

insert into propietario(id_propietario,rut,dv,nombre,apellido,estado_civil,telefono,direccion,email,propiedad_id_propiedad)
values(1,65345986,'6','Romina','Gonzalez Cáceres','Soltera','67550910','Cerro Altar 6811, Santiago Centro','romybunniquist@gmail.coM',1);

insert into propietario(id_propietario,rut,dv,nombre,apellido,estado_civil,telefono,direccion,email,propiedad_id_propiedad)
values(2,17898094,'2','Angela','Lopez','Mazuela','45432380','Alcántara 1320, Las Condes ','angitaLopez@gmail.com',2);

insert into propietario(id_propietario,rut,dv,nombre,apellido,estado_civil,telefono,direccion,email,propiedad_id_propiedad)
values(3,1828267,'K','Mónica','Frenzel','Casada','661 8779','Fernandez Concha 1678, Las Condes ','mfrenzel@unab.cl',3);

insert into propietario(id_propietario,rut,dv,nombre,apellido,estado_civil,telefono,direccion,email,propiedad_id_propiedad)
values(4,19276567,'1','Silvina','Zapata de Matiello','Casada','661-8288','Fernandez Concha 1890, Las Condes ','ssilvina@unab.cl',4);


--Regiòn de inserción de datos tabla Visita

insert into visita (id_visita,fecha,comentario,propiedad_id_propiedad,id_cliente)
values(1,'03/06/2016','Cliente arrendará la casa',1,1);

insert into visita (id_visita,fecha,comentario,propiedad_id_propiedad,id_cliente)
values(2,'04/06/2016','Sin comentarios',2,2);

insert into visita (id_visita,fecha,comentario,propiedad_id_propiedad,id_cliente)
values(3,'06/06/2016','Cliente conforme',1,1);

insert into visita (id_visita,fecha,comentario,propiedad_id_propiedad,id_cliente)
values(4,'13/07/2016','Cliente se sintió agusto en la vivienda',4,4);

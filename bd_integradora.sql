use rincon_de_las_brujas;
create table categorias(
id_categoria int not null primary key auto_increment,
nombre varchar(30) not null);

create table productos(
id_producto int not null primary key auto_increment,
nom_producto varchar(50),
precio decimal(10,2),
existencias int,
talla char(1) not null,
color varchar(15) not null,
categoria int not null, constraint fk_producto_categoria foreign key(categoria) references categorias(id_categoria));

create table orden_apartado(
id_ordenapartado int not null primary key auto_increment,
fecha date not null,
cliente varchar(50) not null,
contacto text);

create table detalle_apartado(
reg_detalle int not null primary key auto_increment,
forma_pago enum('efectivo','transferencia'),
fecha date not null,
producto int not null, constraint fk_producto_apartado foreign key(producto) references productos(id_producto),
cantidad int not null);

alter table detalle_apartado add column 
orden_apartado int not null;

describe detalle_apartado;


create table reporte_apartado(
rep_apartado int not null primary key auto_increment,
deta_apartado int not null, constraint fk_reporte_apartado foreign key (deta_apartado) references detalle_apartado(reg_detalle),
proxima_abono date,
abono decimal (10,2),
estado varchar(15) not null);

create table orden_venta(
n_orden int not null primary key auto_increment,
pro_orve int not null,constraint fk_producto_orden_venta foreign key(pro_orve) references productos(id_producto),
cantidad_pro int
);

create table detalle_venta(
id_deta_venta int not null primary key auto_increment,
n_orven int not null,constraint fk_Nodenventa_orden_venta foreign key(n_orven) references orden_venta(n_orden),
forma_pago enum('efectivo','transferencia'),
fecha date
);


delimiter //
create procedure reg_productos (in nom_producto varchar(50),precio decimal(10,2),talla char(1),color varchar(15),categoria int,descripcion text)
begin
insert into productos (nom_producto,precio,talla,color,categoria,descripcion) values (nom_producto,precio,talla,color,categoria,descripcion);
end //

call reg_productos ('Pantalón vaquero',180.00,'M','azul rey',1,'Pantalón vaquero de tela de algódon marca Levis talla mediana color azul rey');

select * from productos;

describe orden_venta;

delimiter //
create procedure new_venta (in producto int, cantidad int)
begin
insert into orden_venta (pro_orve,cantidad_pro) values (producto,cantidad);
end //

call new_venta (2,2);

select * from orden_venta;


delimiter //
create procedure new_apartado (in fecha date,cliente varchar(50),contacto text)
begin
insert into orden_apartado (fecha,cliente,contacto) values (fecha,cliente,contacto);
end //

call new_apartado ('2023-07-02','Aarón Villa','8714032760');

select * from orden_apartado;

/* 4.- Bítacora que genera un nuevo reporte de apartado*/

delimiter //
create trigger new_registro_apartado
after insert on nomina for each row begin
insert into bitacora_salarios set
empleado = new.id, nuevo_salario = new.salario_base, anterior_salario = old.salario_base, fecha = new.fecha;
end // 


/* Diparador para saber el pago inicial segun el porcentaje de x apartado */

/* Vista que va a mostrar el abono de las ordenes de venta */

alter table 
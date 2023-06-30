create database rincon_de_las_brujas;
use rincon_de_las_brujas
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

create table reporte_apartado(
rep_apartado int not null primary key auto_increment,
deta_apartado int not null, constraint fk_reporte_apartado (deta_apartado) references detalle_apartado(reg_detalle),
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
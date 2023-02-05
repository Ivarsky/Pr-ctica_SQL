-- modelo de flota de vehiculos

create schema vehicle_fleet authorization fxuxmiqo;

--1. tablas de referencia

-- tabla de color de vehiculo:

create table vehicle_fleet.color(
	idColor varchar(20) not null, --PK
	name_color varchar(200) not null
);

alter table vehicle_fleet.color
add constraint idColor_PK primary key (idColor);

--MARCAS Y MODELOS Y GRUPOS

-- tabla grupo empresarial:

create table vehicle_fleet.corp_group(
	idGroup varchar(20) not null, --PK
	name_group varchar(200) not null
);

alter table vehicle_fleet.corp_group
add constraint idGroup_PK primary key (idGroup);

-- tabla de marca:

create table vehicle_fleet.brand(
	idBrand varchar(20) not null, --PK
	corp_group varchar(20) not null, --FK
	brand_name varchar(200) not null
);
	--PK 
alter table vehicle_fleet.brand
add constraint brand_PK primary key (idBrand);

	--FK
alter table vehicle_fleet.brand
add constraint group_FK foreign key (corp_group)
references vehicle_fleet.corp_group (idGroup);

-- tabla de modelo:
create table vehicle_fleet.model(
	idModel varchar(20) not null, --PK
	brand varchar(20) not null, --FK
	model_name varchar(200) not null
);
	--PK 
alter table vehicle_fleet.model
add constraint model_PK primary key (idModel);

	--FK
alter table vehicle_fleet.model
add constraint brand_FK foreign key (brand)
references vehicle_fleet.brand (idBrand);

-- SEGURO:

-- tabla de compañia aseguradora

create table vehicle_fleet.insurance_company(
	idCompany varchar(20) not null, --PK	
	company_name varchar(200) not null
);
	--PK 
alter table vehicle_fleet.insurance_company
add constraint company_PK primary key (idCompany);

-- tabla de poliza

create table vehicle_fleet.insurance_policy(
	idPolicy varchar(20) not null, --PK
	insurance_company varchar(20) not null, --FK
	policy_num varchar(200) not null
);
	--PK 
alter table vehicle_fleet.insurance_policy
add constraint policy_PK primary key (idPolicy);

	--FK
alter table vehicle_fleet.insurance_policy
add constraint company_FK foreign key (insurance_company)
references vehicle_fleet.insurance_company (idCompany);


-- tabla de moneda 
create table vehicle_fleet.currency(
	idCurrency varchar(20) not null, --PK
	currency_name varchar(20) not null
);
	--PK 
alter table vehicle_fleet.currency
add constraint currency_PK primary key (idCurrency);


-- tabla de coche:
create table vehicle_fleet.vehicle(
	idCar varchar(20) not null, --PK
	model varchar(20) not null, --FK
	color varchar(20) not null, --FK
	plate_num varchar(200) not null, 
	kilometers int not null default 0,
	insurance_policy varchar(20) not null, --FK
	purchase_date date not null default '4000-01-01'
);

	--PK
alter table vehicle_fleet.vehicle 
add constraint vehicle_PK primary key (idCar);

	--FK
alter table vehicle_fleet.vehicle 
add constraint model_FK foreign key (model)
references vehicle_fleet.model (idModel);
 
alter table vehicle_fleet.vehicle 
add constraint color_FK foreign key (color)
references vehicle_fleet.color (idColor);

alter table vehicle_fleet.vehicle 
add constraint insurance_FK foreign key (insurance_policy)
references vehicle_fleet.insurance_policy (idPolicy);


-- tabla de revisiones:
create table vehicle_fleet.car_test(
	idCar varchar(20) not null, --FK, PK
	idTest varchar(20) not null, --PK
	kilometers int not null default 0,
	test_date date not null default '4000-01-01',
	amount int not null default 0,
	currency varchar(20) not null --FK
);

	--PK 
alter table vehicle_fleet.car_test 
add constraint test_PK primary key (idCar, idTest);

	--FK
alter table vehicle_fleet.car_test 
add constraint car_test_FK foreign key (idCar)
references vehicle_fleet.vehicle (idCar);

alter table vehicle_fleet.car_test 
add constraint currency_FK foreign key (currency)
references vehicle_fleet.currency (idCurrency);


--CARGA DE DATOS:

-- GRUPOS DE MARCAS---------------------

--toyota:
insert into vehicle_fleet.corp_group 
(idgroup, name_group)
values ('TOY', 'TOYOTA');

--volkswagen:
insert into vehicle_fleet.corp_group 
(idgroup, name_group)
values ('VWG', 'VOLKSWAGEN');

--renault-nissan:
insert into vehicle_fleet.corp_group 
(idgroup, name_group)
values ('RN', 'RENAULT-NISSAN');

--MARCAS-----------------------------------------

--toyota:
insert into vehicle_fleet.brand 
(idbrand, corp_group, brand_name)
values ('01TOY', 'TOY', 'TOYOTA');

--lexus:
insert into vehicle_fleet.brand 
(idbrand, corp_group, brand_name)
values ('02LEX', 'TOY', 'LEXUS');

--volkswagen:
insert into vehicle_fleet.brand 
(idbrand, corp_group, brand_name)
values ('03VWGN', 'VWG', 'VOLKSWAGEN');

--seat:
insert into vehicle_fleet.brand 
(idbrand, corp_group, brand_name)
values ('04SE', 'VWG', 'SEAT');

--audi:
insert into vehicle_fleet.brand 
(idbrand, corp_group, brand_name)
values ('05AU', 'VWG', 'AUDI');

--renault:
insert into vehicle_fleet.brand 
(idbrand, corp_group, brand_name)
values ('06RE', 'RN', 'RENAULT');

--nissan:
insert into vehicle_fleet.brand 
(idbrand, corp_group, brand_name)
values ('07NIS', 'RN', 'NISSAN');

--MODELOS-------------------------------

--toyota:
insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('COR', '01TOY', 'COROLLA');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('PRI', '01TOY', 'PRIUS');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('RAV', '01TOY', 'RAV4');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('YAR', '01TOY', 'YARIS');

--lexus:
insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('LERX', '02LEX', 'RX');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('LERC', '02LEX', 'RCF');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('LELS', '02LEX', 'LS');

--volkswagen:
insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('VOL01', '03VWGN', 'POLO');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('VOL02', '03VWGN', 'GOLF');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('VOL03', '03VWGN', 'PASSAT');

--seat:
insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('SE01', '04SE', 'IBIZA');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('SE02', '04SE', 'LEON');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('SE03', '04SE', 'ATECA');

--audi:
insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('AUD01', '05AU', 'A4');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('AUD02', '05AU', 'A5');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('AUD03', '05AU', 'A6');

--renault:
insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('RE01', '06RE', 'CLIO');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('RE02', '06RE', 'MEGANE');

--nissan:
insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('NIS01', '07NIS', 'QASHQAI');

insert into vehicle_fleet.model 
(idmodel, brand, model_name)
values ('NIS02', '07NIS', 'PATROL');

select *
from vehicle_fleet.model;


--SEGUROS----------------------------------------------

insert into vehicle_fleet.insurance_company 
(idcompany, company_name)
values ('LD', 'LINEA DIRECTA');

insert into vehicle_fleet.insurance_company 
(idcompany, company_name)
values ('AX', 'AXA');

insert into vehicle_fleet.insurance_company 
(idcompany, company_name)
values ('MP', 'MAPFRE');

insert into vehicle_fleet.insurance_company 
(idcompany, company_name)
values ('AL', 'ALLIANZ');

insert into vehicle_fleet.insurance_company 
(idcompany, company_name)
values ('MM', 'MUTUA MADRILEÑA');

--POLIZAS-------------------------------------------------

--linea directa
insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('LD01', 'LD', 'LD001');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('LD02', 'LD', 'LD002');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('LD03', 'LD', 'LD003');

-- axa:
insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('AX01', 'AX', 'AXA001');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('AX02', 'AX', 'AXA002');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('AX03', 'AX', 'AXA003');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('AX04', 'AX', 'AXA004');

--MAPFRE:

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('MP01', 'MP', 'MAP001');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('MP02', 'MP', 'MAP002');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('MP03', 'MP', 'MAP003');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('MP04', 'MP', 'MAP004');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('MP05', 'MP', 'MAP005');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('MP06', 'MP', 'MAP006');

--ALLIANZ:
insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('AL01', 'AL', 'AL001');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('AL02', 'AL', 'AL002');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('AL03', 'AL', 'AL003');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('AL04', 'AL', 'AL004');

--MUTUA MADRILEÑAñ
insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('MM01', 'MM', 'MM001');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('MM02', 'MM', 'MM002');

insert into vehicle_fleet.insurance_policy 
(idpolicy, insurance_company, policy_num)
values ('MM03', 'MM', 'MM003');

--MONEDA------------------------------------------------
insert into vehicle_fleet.currency 
(idcurrency, currency_name)
values ('EUR', 'EURO');

insert into vehicle_fleet.currency 
(idcurrency, currency_name)
values ('USD', 'DOLAR ESTADOUNIDENSE');

insert into vehicle_fleet.currency 
(idcurrency, currency_name)
values ('MXN', 'PESO MEXICANO');

--COLORES----------------------------------------------
insert into vehicle_fleet.color 
(idcolor, name_color)
values ('01', 'NEGRO');

insert into vehicle_fleet.color 
(idcolor, name_color)
values ('02', 'BLANCO');

insert into vehicle_fleet.color 
(idcolor, name_color)
values ('03', 'ROJO');

insert into vehicle_fleet.color 
(idcolor, name_color)
values ('04', 'GRIS');

--COCHES----------------------------------------------------
insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR01', 'COR', '01', '1111AAA', '30000', 'LD01', '2021-01-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR02', 'PRI', '02', '2222AAA', '70000', 'LD02', '2021-02-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR03', 'RAV', '03', '3333AAA', '45000', 'LD03', '2021-03-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR04', 'YAR', '04', '4444AAA', '100000', 'AX01', '2020-01-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR05', 'LERX', '01', '5555AAA', '60000', 'AX02', '2021-04-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR06', 'LERC', '02', '6666AAA', '120000', 'AX03', '2020-04-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR07', 'LELS', '03', '7777AAA', '80000', 'AX04', '2021-06-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR08', 'VOL01', '04', '8888AAA', '60000', 'MP01', '2021-07-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR09', 'VOL02', '01', '9999AAA', '40000', 'MP02', '2021-08-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR10', 'VOL03', '02', '1111BBB', '20000', 'MP03', '2021-09-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR11', 'SE01', '03', '2222BBB', '150000', 'MP04', '2020-10-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR12', 'SE02', '04', '3333BBB', '120000', 'MP05', '2020-11-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR13', 'SE03', '01', '4444BBB', '130000', 'MP06', '2020-12-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR14', 'AUD01', '02', '5555BBB', '70000', 'AL01', '2019-01-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR15', 'AUD02', '03', '6666BBB', '80000', 'AL02', '2019-02-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR16', 'AUD03', '04', '7777BBB', '90000', 'AL03', '2019-03-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR17', 'RE01', '01', '8888BBB', '50000', 'AL04', '2022-01-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR18', 'RE02', '02', '9999BBB', '200000', 'MM01', '2022-02-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR19', 'NIS01', '03', '1111CCC', '20000', 'MM02', '2022-03-01');

insert into vehicle_fleet.vehicle 
(idcar, model, color, plate_num, kilometers, insurance_policy, purchase_date)
values ('CAR20', 'NIS02', '04', '2222CCC', '150000', 'MM03', '2022-04-01');

--REVISIONES-----------------------------------------------------------------------
--CAR01
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR01', '001', 10000, '2022-06-01', 45, 'EUR');

--CAR02
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR02', '001', 60000, '2023-02-01', 45, 'EUR');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR02', '002', 45000, '2022-09-01', 45, 'EUR');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR02', '003', 35000, '2021-09-01', 45, 'EUR');

--CAR03
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR03', '001', 20000, '2021-09-01', 50, 'USD');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR03', '002', 40000, '2022-12-01', 50, 'USD');

--CAR04
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR04', '001', 80000, '2020-05-01', 800, 'MXN');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR04', '002', 90000, '2021-05-01', 800, 'MXN');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR04', '003', 99000, '2022-05-01', 800, 'MXN');

--CAR05
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR05', '001', 40000, '2021-10-01', 50, 'EUR');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR05', '002', 50000, '2022-10-01', 50, 'EUR');

--CAR06
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR06', '001', 90000, '2020-10-01', 45, 'USD');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR06', '002', 100000, '2020-10-01', 45, 'USD');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR06', '003', 110000, '2020-10-01', 45, 'USD');

--CAR07
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR07', '001', 60000, '2021-10-01', 750, 'MXN');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR07', '002', 70000, '2022-10-01', 750, 'MXN');

--CAR08
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR08', '001', 40000, '2021-11-01', 55, 'EUR');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR08', '002', 50000, '2022-11-01', 55, 'EUR');

--CAR09
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR09', '001', 50000, '2022-08-01', 60, 'USD');

--CAR10
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR10', '001', 15000, '2022-09-01', 825, 'MXN');

--CAR11
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR11', '001', 140000, '2021-03-01', 60, 'EUR');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR11', '002', 120000, '2022-03-01', 60, 'EUR');

--CAR12
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR12', '001', 100000, '2021-05-01', 40, 'USD');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR12', '002', 110000, '2022-05-01', 40, 'USD');

--CAR13
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR13', '001', 110000, '2021-02-01', 725, 'MXN');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR13', '002', 120000, '2022-02-01', 725, 'MXN');

--CAR14
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR14', '001', 30000, '2019-04-01', 40, 'EUR');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR14', '002', 40000, '2020-04-01', 40, 'EUR');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR14', '003', 50000, '2021-04-01', 40, 'EUR');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR14', '004', 60000, '2022-04-01', 40, 'EUR');

--CAR15
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR15', '001', 40000, '2019-09-01', 50, 'USD');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR15', '002', 50000, '2020-09-01', 50, 'USD');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR15', '003', 60000, '2021-09-01', 50, 'USD');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR15', '004', 70000, '2022-09-01', 50, 'USD');

--CAR16
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR16', '001', 50000, '2019-11-01', 900, 'MXN');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR16', '002', 60000, '2020-11-01', 900, 'MXN');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR16', '003', 70000, '2021-11-01', 900, 'MXN');

insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR16', '004', 80000, '2022-11-01', 900, 'MXN');

--CAR17
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR17', '001', 40000, '2022-07-01', 60, 'EUR');

--CAR18
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR18', '001', 190000, '2022-08-01', 40, 'USD');

--CAR19
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR19', '001', 10000, '2022-09-01', 800, 'MXN');

--CAR20
insert into vehicle_fleet.car_test  
(idcar, idtest, kilometers, test_date, amount, currency)
values ('CAR20', '001', 140000, '2022-10-01', 40, 'EUR');










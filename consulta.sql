/*
Habrá que generar una consulta SQL para sacar el siguiente listado de coches activos que
hay en keepcoding:
- Nombre modelo, marca y grupo de coches (los nombre de todos)
- Fecha de compra
- Matricula
- Nombre del color del coche
- Total kilómetros
- Nombre empresa que está asegurado el coche
- Número de póliza
*/

select a.idcar, a.plate_num, a.kilometers, a.purchase_date, b.name_color, d.brand_name, c.model_name, e.name_group, g.company_name, f.policy_num
from vehicle_fleet.vehicle a inner join vehicle_fleet.color b
on a.color  = b.idcolor  
inner join vehicle_fleet.model c
on a.model = c.idmodel 
inner join vehicle_fleet.brand d 
on c.brand = d.idbrand 
inner join vehicle_fleet.corp_group e 
on d.corp_group = e.idgroup 
inner join vehicle_fleet.insurance_policy f 
on a.insurance_policy = f.idpolicy 
inner join vehicle_fleet.insurance_company g 
on f.insurance_company = g.idcompany 
where 1 = 1

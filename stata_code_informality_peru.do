clear all
set more off


***Run the code from here**
use enaho01a-2004-2023-500.dta, clear

gen double fac500n = .
replace fac500n = fac500_p  if fac500n != .
replace fac500n = fac500a if fac500n == .

*RESIDENTE HABITUAL
gen resident=1 if (p204==1 & p205==2) | (p204==2 & p206==1)
recode resident (.=0)

********DEPARTAMENTOS*******

*arealima es LIMA METROPOLITANA
gen arealima=.
replace arealima=2 if real(ubigeo)>=150100 & real(ubigeo)<160000
replace arealima=1 if real(ubigeo)>=150100 & real(ubigeo)<=150143

gen dpto= real(substr(ubigeo,1,2))
*agrupamos Callao y LIMA Metropolitana como Lima*
replace dpto=15 if dpto==7
replace dpto=26 if arealima==2 & dpto==15
label define dpto 1"Amazonas" 2"Ancash" 3"Apurimac" 4"Arequipa" 5"Ayacucho" 6"Cajamarca" 8"Cusco" 9"Huancavelica" 10"Huanuco" 11"Ica" /*
*/12"Junin" 13"La Libertad" 14"Lambayeque" 15"Lima*" 16"Loreto" 17"Madre de Dios" 18"Moquegua" 19"Pasco" 20"Piura" 21"Puno" 22"San Martin" /*
*/23"Tacna" 24"Tumbes" 25"Ucayali" 26"Lima provincias" 

label val dpto dpto


****Actividades económicas

**Revisión 3

recode p506 (111/200=1) (500=2) (1010/1429=3) (1500/3720=4) (4010/4100=5) (4510/4550=6) (5010/5270=7) (5510/5520=8) (6010/6420=9) (6510/6720=10) (7010/7499=11) (7510/7530=12) (8010/8090=13) (8510/8532=14) (9000/9309=15) (9500=16) (9900/9999=17), gen(actividadr3)
label define actividadr3 1 "Agricultura, Ganadería, Caza y Silvicultura" 2 "Pesca" 3 "Explotación de Minas y Canteras" 4 "Industrias Manufactureras" 5 "Suministro de electricidad, gas y agua" 6 "Construcción" 7 "Comercio" 8 "Hoteles y Restaurantes" 9 "Transporte, Almacenamiento y Comunicaciones" 10 "Intermediación Financiera" 11 "Actividades Inmobiliarias, Empresariales y de Alquiler" 12 "Administración Pública" 13 "Enseñanza" 14 "Actividades de Servicios Sociales y de Salud (Privada)" 15 "Otras ctividades de Servicios Comunitarias, sociales y personales" 16 "Hogares Privados con servicio doméstico" 17 "Organizaciones y Organos extraterritoriales"
label values actividadr3 actividadr3

recode actividadr3 (1=0) (2=1) (3=2) (4=3) (6=4) (7=5) (8=6) (9=7) (12=8) (5 = 9) (10 11 13 14 15 16 17=10), gen(act_eco2)
label define act_eco_et 0 "Agricultura, Ganadería, Caza y Silvicultura" 1 "Pesca" 2 "Mineria" 3 "Industrias Manufactureras" 4 "Construcción" 5 "Comercio" 6 "Hoteles y Restaurantes" 7 "Transporte" 8 "Administración Pública"  9 "Electricidad, agua" 10 "Otros"
label values act_eco2 act_eco_et

**Revisión 4

recode p506r4 (111/240=1) (311/322=2) (510/990=3) (1010/3320=4) (3510/3530=5) (3600/3900=6) (4100/4390=7) (4510/4799=8) (4911/5320=9) (5510/5630=10) (5811/6399=11) (6411/6630=12) (6810/6820=13) (6910/7500=14) (7710/8299=15) (8411/8430=16) (8510/8550=17) (8610/8890=18) (9000/9329=19) (9411/9609=20) (9700/9820=21) (9900=22), gen(actividadr4)
label define actividadr4 1 "Agricultura, Ganadería, Caza y Silvicultura" 2 "Pesca" 3 "Explotación de Minas y Canteras" 4 "Industrias Manufactureras" 5 "Suministro de electricidad y gas" 6 "Suministro de agua" 7 "Construcción" 8 "Comercio" 9 "Transporte y almacenamiento" 10 "Alojamiento y Restaurantes" 11 "Información y comunicaciones" 12"Intermediación Financiera" 13 "Actividades Inmobiliarias" 14 "Actividades profesionales, científicas y técnicas" 15 "Actividades de servicios administrativos y de apoyo" 16 "Administración Pública" 17 "Enseñanza" 18 "Antención de la salud humana y asistencia social" 19 "Actividades artísticas, de entretenimiento y recreativas" 20 "Otras actividades de servicios" 21 "Actividades de los hogares como empleadores"  22 "Organizaciones y órganos extraterritoriales"
label values actividadr4 actividadr4

recode actividadr4 (1=0) (2=1) (3=2) (4=3) (5 6 =4) (7=5) (8=6) (9=7) (10=8) (11=9) (16=10) (12 13 14 15 17 18 19 20 21 22=11), gen(act_eco4)
label define act_eco4 0 "Agropecuario" 1 "Pesca" 2 "Mineria" 3 "Manufactura" 4 "Electricidad, agua y gas" 5 "Construcción" 6 "Comercio" 7 "Transporte y almacenamiento" 8 "Alojamiento y resaturantes" 9 "Información y comunicaciones" 10 "Administración pública" 11 "Otros servicios"
label values act_eco4 act_eco4



***Tamaño de empresa***

*Construyendo tamaño de empresa para calcular cuasisociedades.
gen Num_Trab_OP2=.
replace Num_Trab_OP2=1 if p512b>=1 & p512b<=5
replace Num_Trab_OP2=2 if p512b>=6 & p512b<=10
replace Num_Trab_OP2=3 if p512b>=11 & p512b<=50
replace Num_Trab_OP2=4 if p512b>=51 & p512b<=9998
replace Num_Trab_OP2=9 if p512b==9999
replace Num_Trab_OP2=9 if p512b==.
label var Num_Trab_OP2 "Número de trabajadores (ocupación principal)"
label define Num_Trab_OP2 1 "Micro" 2 "Pequeñas" 3 "Medianas" 4 "Grandes" 9 "NEP"
label value Num_Trab_OP2 Num_Trab_OP2
*Recodificando a los missing (9) para llegar al total, repartiéndolos según tamaño implícito.
replace Num_Trab_OP2=1 if p507==2
replace Num_Trab_OP2=1 if p507==6
replace Num_Trab_OP2=2 if Num_Trab_OP2==9 & p512a==2
replace Num_Trab_OP2=3 if Num_Trab_OP2==9 & p512a==3
replace Num_Trab_OP2=4 if Num_Trab_OP2==9 & p512a >= 4 & p512a < 6 
replace Num_Trab_OP2=4 if Num_Trab_OP2==9 & p510<4



*Urbano/Rural
gen area=estrato
recode area (1/5=1)(6/8=2)
lab define labarea 1"Urbana" 2"Rural"
lab val area labarea
tab area


***Trabajadores independientes***
*drop tipo_trab
gen tipo_trab=.
replace tipo_trab = 1 if (p507==3 | p507==4) //asalariado
replace tipo_trab = 2 if (p507==2) | (p507==1 & Num_Trab_OP2==1) // indep 
replace tipo_trab = 3 if (p507==6) //empleado hogar
replace tipo_trab = 4 if (p507==1 & Num_Trab_OP2>1) // patrono
replace tipo_trab = 5 if (p507==5) // TFNR
replace tipo_trab = 6 if (p507==7) // ND

*label drop tipo_trab
label var tipo_trab "categoría ocupacional"
label define tipo_trab 1 "Asalariado" 2 "Autoempleado" 3 "Hogar" 4 "Patrono" 5 "TFNR" 6 "ND"
label value tipo_trab tipo_trab


***Ingreso promedio por trabajo*** 
recode i524a1 d529t i530a d536 i538a1 d540t i541a d543 d544t(.=0)

egen ingtrabw = rowtotal(i524a1 d529t i530a d536 i538a1 d540t i541a d543 d544t)

gen ingtra_n=ingtrabw/12

label var ingtrabw "ingreso por trabajo anual"
label var ingtra_n "ingreso por trabajo mensual nominal"


***Genero trimestres
*gen trim = .
*replace trim = 1 if mes ==1 | mes == 2 | mes == 3
*replace trim = 2 if mes ==4 | mes == 5 | mes == 6
*replace trim = 3 if mes ==7 | mes == 8 | mes == 9
*replace trim = 4 if mes ==10 | mes == 11 | mes == 12

*gen aotrim = real(string(aÑo) + string(trim))

recode ocupinf (2=0)

xtile ingre_deci23_dep = i524a1 if i524a1>0 & ocu500==1 & resident==1 & aÑo==2023 [pw=fac500n], nq(5)

table ingre_deci23_dep if tipo_trab==1 & aÑo==2023 & ocu500==1 & resident==1 [iw=fac500n], c(mean i524a1) row col format(%12.4fc)
table ingre_deci23_dep if tipo_trab==1 & aÑo==2023 & ocu500==1 & resident==1 [iw=fac500n], c(mean ocupinf) row col format(%12.4fc)

xtile ingre_decil23_dep = i524a1 if i524a1>0 & ocu500==1 & resident==1 & aÑo==2023 [pw=fac500n], nq(10)

table ingre_decil23_dep if tipo_trab==1 & aÑo==2023 & ocu500==1 & resident==1 [iw=fac500n], c(mean i524a1) row col format(%12.4fc)
table ingre_decil23_dep if tipo_trab==1 & aÑo==2023 & ocu500==1 & resident==1 & ocupinf==1 [iw=fac500n], c(mean i524a1) row col format(%12.4fc)
table ingre_decil23_dep if tipo_trab==1 & aÑo==2023 & ocu500==1 & resident==1 [iw=fac500n], c(mean ocupinf) row col format(%12.4fc)

xtile ingre_decil23 = ingtra_n if ingtra_n>0 & ocu500==1 & resident==1 & aÑo==2023 [pw=fac500n], nq(10)

table ingre_decil23 if aÑo==2023 & ocu500==1 & resident==1 [iw=fac500n], c(mean ingtra_n) row col format(%12.4fc)
table ingre_decil23 if aÑo==2023 & ocu500==1 & resident==1 & ocupinf==1 [iw=fac500n], c(mean ingtra_n) row col format(%12.4fc)
table ingre_decil23 if aÑo==2023 & ocu500==1 & resident==1 [iw=fac500n], c(mean ocupinf) row col format(%12.4fc)





/*
**Deciles 2021 asalariados**
xtile ing_dec_21_1 = ingtra_n if ingtra_n>0 & ocu500==1 & resident==1 & aÑo==2021 & tipo_trab==1 [pw=fac500n], nq(10)
xtile ing_dec_21_2 = ingtra_n if ingtra_n>0 & ocu500==1 & resident==1 & aÑo==2021 & tipo_trab== [pw=fac500n], nq(10)
*/
/* p301a
	
1 sin nivel	
2 inicial	
3 primaria incompleta	
4 primaria completa	
5 secundaria incompleta	
6 secundaria completa	
7 superior no universitaria incompleta	
8 superior no universitaria completa	
9 superior universitaria incompleta	
10 superior universitaria completa
11 post-grado universitario
12

*/

***Salidas***

**Según categoría ocupacional**
*Formal*
table ocupinf tipo_trab if aÑo==2021 & ocu500==1 & resident==1 [iw=fac500n], row col format(%12.0fc) // informal
table ocupinf tipo_trab if aÑo==2021 & ingtra_n>0 & ocu500==1 & resident==1 [iw=fac500n], c(mean ingtra_n) row col format(%12.0fc) // informal ingresos
table ocupinf tipo_trab if aÑo==2021 & area==1 & ocu500==1 & resident==1 [iw=fac500n], row col format(%12.0fc) // area urbana
table ocupinf tipo_trab if aÑo==2021 & ingtra_n>0 & area==1 & ocu500==1 & resident==1 [iw=fac500n], c(mean ingtra_n) row col format(%12.0fc) // area urbana

*Act*
table act_eco4 tipo_trab if aÑo==2021 & ocu500==1 & resident==1 [iw=fac500n], row col format(%12.0fc)
table act_eco4 tipo_trab if aÑo==2021 & ocu500==1 & resident==1 [iw=fac500n], row col format(%12.0fc)
table act_eco4 aÑo if ocu500==1 & resident==1 [iw=fac500n], row col format(%12.0fc)

*Educac*
table p301a tipo_trab if aÑo==2021 & ocu500==1 & resident==1 [iw=fac500n], row col format(%12.0fc)

*Deciles*
table ing_dec_21_1 if tipo_trab==1 & aÑo==2021 & ingtra_n>0 & ocu500==1 & resident==1 [iw=fac500n], c(mean ingtra_n) row col format(%12.0fc)
table ing_dec_21_2 if tipo_trab==2 & aÑo==2021 & ingtra_n>0 & ocu500==1 & resident==1 [iw=fac500n], c(mean ingtra_n) row col format(%12.0fc)




*Afiliados*

drop if p558b1 >= 12 & p558b1!=.
drop if p558b2 >= 2021 & p558b2!=.

destring mes, replace
gen aport_meses = (aÑo - p558b2 ) * 12 - (mes - p558b1)  


table aÑo  tipo_trab if ocu500==1 & resident==1 [iw=fac500n], row col format(%12.0fc)

*Frecuencia de pago*
table aÑo p523 tipo_trab if ocu500==1 & resident==1 [iw=fac500n], row col format(%12.0fc)



***PEA OCUPADA***

table ocupinf aÑo  if aÑo>=2007 & ocu500==1 & resident==1 [iw=fac500n], row col format(%15.0fc)
table p507 aÑo  if ocu500==1 & resident==1 [iw=fac500n], row col format(%15.0fc)


table ocupinf aÑo if ingtra_n>0 & (p507==3 | p507==4) & ocu500==1 & resident==1 [iw=fac500n], c(mean ingtra_n) row col format(%10.0fc)


table dpto aÑo if ocu500==1 & resident==1 [iw=fac500n], c(mean ocupinf) row format(%10.4fc)
table dpto aÑo if ocu500==1 & resident==1 & ocupinf==1 [iw=fac500n], row format(%12.2fc)



table aniorec act_eco2 if ocu500==1 & resident==1 [iw=fac500n], row format(%18.6fc)

***PEA OCUPADA FEMENINA***
*table dpto aniorec if ocu500==1 & resident==1 & p207==2 [iw=fac500n], row format(%18.6fc)

***PEA OCUPADA MASCULINA***
*table dpto aniorec if ocu500==1 & resident==1 & p207==1 [iw=fac500n], row format(%18.6fc)

***PEA Ocupada por sector***
table  actividadr3 if aniorec==2019 & ocu500==1 & resident==1 [iw=fac500n], row format(%18.6fc)




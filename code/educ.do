use "C:\Users\citro\Desktop\ntu106-2\計量經濟學\final project\srdanew\sh2010.dta", clear
gen educjob =1 if sh10d21_4==1|sh10d21_4==2
replace educjob=0 if educjob==.
use "C:\Users\citro\Desktop\ntu106-2\計量經濟學\final project\cpn2014.dta", clear
recast int cpn14e22_4
gen educjob =1 if cpn14e22_4==1|cpn14e22_4==2
replace educjob=0 if educjob==.

import excel "C:\Users\citro\Desktop\ntu106-2\計量經濟學\final project\ndata.xlsx", sheet("ndata") firstrow

encode gender , gen(gender_group)
encode feduc , gen(feduc_group)
encode educ , gen(educ_group)
encode public_private, gen(public_private_group)
//敘述性統計1.能夠發揮所學的比例: 廣設大學前0.4998廣設大學後0.5000
sum educjob if cpn2014==0
sum educjob if cpn2014==1
//***敘述性統計1.能夠發揮所學的比例(for受過高等教育的人): 廣設大學前0.5332廣設大學後0.4975
sum educjob if gotocollege ==1 & cpn2014==1
sum educjob if gotocollege ==1 & cpn2014==0
//敘述性統計1.能夠發揮所學的比例(for沒受高等教育的人): 廣設大學前0.4711廣設大學後0.4970
sum educjob if gotocollege ==0 & cpn2014==0
sum educjob if gotocollege ==0 & cpn2014==1

//敘述性統計2.升學概況:念大學(國立大學、私立大學、國立科技大學、私立科技大學)的比例: 廣設大學前0.7534 廣設大學後0.8551
tab educd if cpn2014==1
tab educd if cpn2014==0
//敘述性統計3.薪資




//有沒有念大學
gen gotocollege = 1 if educd=="公立一般大學"| educd=="私立一般大學"| educd=="公立科技大學" |educd=="私立科技大學" | educd=="國外大學"
replace gotocollege = 0 if gotocollege==.
sum gotocollege if cpn2014==1
//0.7369
sum gotocollege if cpn2014==0
//0.6776
tab educd if cpn2014==1
tab educd if cpn2014==0
//能否發揮所學educjob

//有沒有念大學
gen college_educ = 1 if educ=="一般大學"|educ=="博士"|educ=="大學"|educ=="技術學院或科技大學"|educ=="碩士"
replace college_educ=0 if college_educ==.
//碩士
gen master = 1 if educ=="碩士"
replace master = 0 if master ==.
//博士
gen phd = 1 if educ=="博士"
replace phd=0 if phd ==.
//碩士+博士
gen higheduc = 1 if master==1|phd==1
replace higheduc = 0 if higheduc==.

//敘述性統計
tabulate educ
tabulate educ if cpn2014==1
sum college_educ if cpn2014==1
//有念大學(一般大學+博士+技術學院或科技大學+碩士+大學)的比例=0.8572
tabulate educ if cpn2014==0
sum college_educ if cpn2014==0
//有念大學(一般大學+博士+技術學院或科技大學+碩士+大學)的比例=0.8667

//來看90年度就讀高中v.s.90年度就讀國中(cpn2104)在接受更高等教育(碩士)上面的差異
sum master if cpn2014==1
//0.2007
sum phd if cpn2014==1
//0.0042
sum higheduc if cpn2014==1
//0.2049

sum master if cpn2014==0
//0.1946
sum phd if cpn2014==0
//0.0100
sum higheduc if cpn2014==0
//0.2046



//大學畢業後的薪水(加權)
replace wsalary =. if wsalary ==0
//現在的薪水(加權)
replace wsalarynow =. if wsalarynow ==0

//性別
gen genderdmy=1 if gender=="男"
replace genderdmy=0 if gender=="女"


//教育年數
gen yeduc=0
replace yeduc=16 if educ=="一般大學"
replace yeduc=16 if educ=="技術學院或科技大學"
replace yeduc=18 if educ=="碩士"
replace yeduc=22 if educ=="博士"
replace yeduc=12 if educ=="高職"
replace yeduc=11 if educ=="二專"
replace yeduc=16 if educ=="大學"
replace yeduc=14 if educ=="五專"
replace yeduc=12 if educ=="高中"
replace yeduc=9 if educ=="國中"
//增加變數：父親的教育水準: 國小/國中/高中/大學/碩士/博士
encode feduc, gen(feduc_group)
//增加變數：唸的科系
encode educsubj, gen(educsubj_group)
//回歸
reg wsalary genderdmy yeduc college cpn2014
reg wsalarynow genderdmy yeduc college cpn2014

reg wsalary genderdmy yeduc college i.feduc_group i.educsubj_group cpn2014
reg wsalarynow genderdmy yeduc college i.feduc_group i.educsubj_group cpn2014


encode titlenow, gen(titlenow_group)
wsalarynow gender_group feduc_group educsubj_group cpn2014 yeduc college_educ public_private_educ
ln(wsalarynow)gender_group feduc_group cpn2014 yeduc college_educ public_private_educ educjob score educsubj_group wsalary 

reg lnwsalarynow gender_group feduc_group cpn2014 yeduc college_educ public_private_educ educjob educsubj_group wsalary titlenow_group scalenow managernow
reg lnwsalarynow i.gender_group i.feduc_group cpn2014 yeduc college_educ public_private_educ educjob i.educsubj_group lnwsalary i.title1_group scalenow managernow yearswork




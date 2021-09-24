//cpn2014
use "C:\Users\citro\Desktop\ntu106-2\計量經濟學\final project\srdanew\國中2014\cpn2014.dta", clear
replace cpn14e19_1=. if cpn14e19_1>1000000
replace cpn14e19_1=. if cpn14e19_1==0

//第一份工作薪水
replace cpn14e13_1=. if cpn14e13_1>1000000
replace cpn14e13_1=.  if cpn14e13_1==0
mean cpn14e13_1

mean cpn14e13_1 if cpn14b4f2_2_s10==1|cpn14b4f2_2_s10==8|cpn14b4f2_2_s10==6|cpn14b4f2_2_s10==3
// 有念大學19189.16
mean cpn14e13_1 if cpn14b4f2_2_s10==9|cpn14b4f2_2_s10==97
//  沒念大學17795.28

//現在的工作薪水
replace cpn14e19_1=. if cpn14e19_1>1000000
replace cpn14e19_1=. if cpn14e19_1==0
mean cpn14e19_1 if cpn14b4f2_2_s10==1|cpn14b4f2_2_s10==8|cpn14b4f2_2_s10==6|cpn14b4f2_2_s10==3
//有念大學  30504.27
mean cpn14e19_1 if cpn14b4f2_2_s10==9|cpn14b4f2_2_s10==97
//沒念大學  31607.76

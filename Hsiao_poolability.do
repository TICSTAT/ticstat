use "C:\Users\Dany\Desktop\mes_travaux\Panel\base_innov_bon", replace
xtset Id Year

codebook Id Year
//GDP_percap Fi_Innov KAOPEN Invest Gov EDU  

*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*                      Hsiao's Poolability Test (1986)             *
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*

// tels stata not to pause or display the  ---more--- message before the end of the set of commands
set more off 

//initialise variables

local SSR=0
local N=35
local T=16
local K=6

* compute SSR or unconstrained sum squares: Estimations by contries
forvalues i=1/35 {
    qui reg GDP_percap KAOPEN Invest Gov EDU Fi_Innov if Id==`i'  
local SSR=`SSR'+e(rss)
    }
di `SSR'

* Compute SSRC1 or constrained ss : pooled model
    qui reg GDP_percap KAOPEN Invest Gov EDU Fi_Innov

local SSRC1=e(rss)
di `SSRC1'

*Compute the Fisher statistics(F1) for the first test :  N=25 T=10 K=5


local F1 = ((`SSRC1'-`SSR')*(`N'*(`T'-(`K'+1))))/(`SSR'*(`N'-1)*(`K'+1))
di `F1'

* P_value for F1
di "dof1= " (`N'-1)*(`K'+1) " dof2= " (`N'*`T'-`N'*(`K'+1))
local PVF1=Ftail((`K'+1)*(`N'-1),(`N'*(`T'-(`K'+1))),`F1')

* compute SSRC2: SS of residuals for an individual effect model
qui xtreg GDP_percap KAOPEN Invest Gov EDU Fi_Innov, fe

local SSRC2=e(rss)
di `SSRC2'
*Compute the Fisher statistics(F2) for the second test :  N=25 T=10 K=5
local F2=((`SSRC2'-`SSR')*(`N'*(`T'-(`K'+1))))/(`SSR'*(`N'-1)*`K')
di `F2'
*P_value for F2
di "dof1= " `K'*(`N'-1) " dof2= " (`N'*`T'-`N'*(`K'+1))
local PVF2=Ftail(`K'*(`N'-1),(`N'*`T'-`N'*(`K'+1)),`F2')

*Computing the last Fisher statistics (F3) : to compare pooled model to individual effect model 
local F3=(`SSRC1'-`SSRC2')*(`N'*(`T'-1)-`K')/(`SSRC2'*(`N'-1))
di `F3'

*P_value for F3
di "dof1 = " (`N'-1) "  dof2 = " (`N'*(`T'-1)-`K')
local PVF3=Ftail((`N'-1),(`N'*(`T'-1)-`K'),`F3')


*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*         Summary of displayed results for Hsiao (1986) test       *
*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*Sum Squares
di in y " SSR = " in gr `SSR' // what is displayed must be stored inside a variable so here is y
di in y " SSRC1 = " in gr `SSRC1'
di in y " SSRC2 = " in gr `SSRC2'
*Fishers statistics
di in y "F1((K+1)*(N-1), N*T-N*(K+1)) = " in gr `F1'
di in y "F2(K*(N-1),(N*T-N*(K+1))) = " in gr `F2'
di in y "F3((N-1),(N*(T-1)-K)) = " in gr `F3'

*pvalues
//H01 : All coefficient are constants (equal individual effects(an intercep) and equal slope coefficients)
//(if not rejected => run a poolled OLS model) 
//(if rejected => go to the next test) 
di in y "PvalF1 = " in gr `PVF1'
//H02 : All slope coefficient are equal
//(if not rejected => go to the next test )
//(if rejected => run OLS models by contries)
di in y "PvalF2 = " in gr `PVF2' 
//H03 : all constants or individual effects are equal
//( if rejected => run individual effect model)
//( if not rejected => run a poolled OLS model)
di in y "PvalF3 = " in gr `PVF3'



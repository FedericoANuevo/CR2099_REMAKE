pro FRANKENSTEIN_RATIO,WRITE=WRITE
  
  common comunes,tm,wt,nband,demc,PHI,parametrizacion,Tmin,Tmax,nr,nth,np,rad,lat,lon,lambda,WTc
  common results_tomo,tfbe,sfbe,N_e

  !PATH = Expand_Path('+/data1/tomography/SolarTom_idl') + ':' + !PATH

   
  root_dir   = '/data1/'
  dir        = root_dir+'DATA/ldem_files/'

; ===============================================================================  
  suffix     = 'CR2099_AIA_compound2'
  file_3bands='LDEM.CR2099_aia_Hollow_3Bands_gauss1_lin_Norm-median_singlStart'
; file-name of filter-rato run 
  file_Ne  = 'Ne_ratio_CR2099_AIA171-193A.dat'
  file_Te  = 'Te_ratio_CR2099_AIA171-193A.dat'
; Grid settings (nr, nth, and np are in common comunes)
  rmin = 1.0 &   rmax = 1.3 
; ===============================================================================  

; Read the LDEM 3-bands run   
  read_ldem,file_3bands,/ldem,/gauss1,dir=dir
    R_3bands = total( abs(1.-sfbe/tfbe), 4 ) / float(nband)
  fbe_3bands = tfbe
   Ne_3bands = N_e
   Tm_3bands = Tm
   WT_3bands = WT
 demc_3bands = demc   
  ZDA_3bands = where(demc eq -999.)
 
; Read the data-cube for filter-ratio run
  xread,file=file_Ne,nr=nr,nt=nth,np=np,map=Ne_ratio,dir=dir
  xread,file=file_Te,nr=nr,nt=nth,np=np,map=Te_ratio,dir=dir
     
; Set threshholds to handle CNSs (AEVs).
  R_th   = 0.25
    
; Initialize compound results to 3Bands
  N_e =   Ne_3bands
  Tm  =   Tm_3bands
  WT  =   WT_3bands
  R   =    R_3bands
 demc = demc_3bands
 ldem_flag = fltarr(nr,nth,np)
 
; Assign 2bands results where 3Bands has ZDA only due to third band (so that 2bands has no ZDA for sure).
  index = where (fbe_3bands(*,*,*,0) gt 0. AND fbe_3bands(*,*,*,1) gt 0. AND fbe_3bands(*,*,*,2) le 0.)
  N_e (index) =    Ne_ratio(index)
  Tm  (index) =    Te_ratio(index)
  WT  (index) =    0.
  R   (index) =    +1.e-7
  demc(index) =    +666.
  ldem_flag(index) = 2.

; Assign filter-ratio results where 3Bands has CNS.
  index = where (demc_3bands ne -999. AND R_3bands gt R_th AND Ne_ratio ne -666.)
  N_e (index) =    Ne_ratio(index)
  Tm  (index) =    Te_ratio(index)
  WT  (index) =    0
  R   (index) =    +1.e-7
  demc(index) =    +666.
  ldem_flag(index) = 2.
  
; Assign 2bands results where 3Bands has Tm ~ 0.5 MK. 
  index = where(Tm_3bands gt 0.5e6 and Tm_3bands lt 0.55e6)
  N_e (index) =    Ne_ratio(index)
  Tm  (index) =    Te_ratio(index)
  WT  (index) =    0
  R   (index) =    +1.e-7
  demc(index) =    +666.
  ldem_flag(index) = 2.

  

; Determine ZDA and CNS indexes for compound result
  ZDA   = where(demc eq -999.)
  CNS   = where( (demc ne -999.  AND R gt R_th) or N_e eq -666.)


  IF keyword_set(write) then begin
      N_e(CNS) = -666.
      Tm (CNS) = -666.
      WT (CNS) = -666.
    ; Save the results  
      openw,1,dir+'Ne_'+suffix+'.dat'
      writeu,1,float(N_e)
      close,1
      openw,1,dir+'Te_'+suffix+'.dat'
      writeu,1,float(Tm) 
      close,1
      openw,1,dir+'WT_'+suffix+'.dat'
      writeu,1,float(WT) 
      close,1
      openw,1,dir+'LDEM-flag_'+suffix+'.dat'
      writeu,1,ldem_flag 
      close,1
      
      RETURN
  ENDIF

  
   
; Display compund results
  Nesat = N_e
  Tmsat = Tm
  Rsat  = R

  superhigh = R_th      & p=where(demc ne -999. AND R gt superhigh) & if p(0) ne -1 then Rsat(p)=superhigh
  superlow  = 0.01      & p=where(demc ne -999. AND R le superlow)  & if p(0) ne -1 then Rsat(p)=superlow
  
  
  if ZDA(0) ne -1 then begin
     Nesat(ZDA)=0.
     Tmsat(ZDA)=0.
     Rsat (ZDA)=0.
  endif

  if CNS(0) ne -1 then begin
     Nesat(CNS)= 1.e16
     Tmsat(CNS)= 1.e12
     Rsat (CNS)= R_th
  endif


  r0A     = [1.025,1.105,1.245]  
  minA_Ne = (r0A*0.+1.E-6)
  maxA_Ne = [3.5  ,2.5  ,1.5 ]
  minA_Te = r0A*0. + 0.5
  maxA_Te = r0A*0  + 2.5 

  

  xdisplay,map=Nesat,file='Ne_'+suffix,nr=nr,nt=nth,rmin=rmin,rmax=rmax,r0A=r0A,win=0, clrtbl= 25,$
           titulo='Ne [10!U8!Ncm!U-3!N]' ,units=1.e8, minA=minA_Ne, maxA=maxA_Ne, /add_bw
  xdisplay,map=tmsat,file='Tm_'+suffix,nr=nr,nt=nth,rmin=rmin,rmax=rmax,r0A=r0A,win=0, clrtbl= 25,$
           titulo='Tm [MK]'              ,units=1.e6, minA=minA_Te, maxA=maxA_Te, /add_bw
  xdisplay,map=Rsat, file='R_' +suffix,nr=nr,nt=nth,rmin=rmin,rmax=rmax,r0A=r0A,win=0, clrtbl= 12,$
           titulo='R'                               , minA=(r0A*0.+1.E-6), maxA=(r0A*0.+0.25)

  return
end

pro FRANKENSTEIN,NFS=NFS,WRITE=WRITE

  common comunes,tm,wt,nband,demc,PHI,parametrizacion,Tmin,Tmax,nr,nth,np,rad,lat,lon,lambda,WTc
  common results_tomo,tfbe,sfbe,N_e

  !PATH = Expand_Path('+/data1/tomography/SolarTom_idl') + ':' + !PATH

  root_dir = '/data1/'
  if keyword_set(NFS) then root_dir='/media/Data1/data1/'
  dir  =root_dir+'DATA/ldem_files/'

; =========================================================
; EUVI-A  
  file_3bands = 'LDEM.CR2099_euvi.A_Hollow_3Bands_gauss1_lin_Norm-median_singlStart' 
  file_2bands = 'LDEM.CR2099_euvi.A_Hollow_2Bands_gauss1_lin_Norm-median_singlStart'  
  suffix      = 'CR2099_EUVIA_compound1'
; EUVI-B  
; file_3bands = 'LDEM.CR2099_euvi.B_Hollow_3Bands_gauss1_lin_Norm-median_singlStart' 
; file_2bands = 'LDEM.CR2099_euvi.B_Hollow_2Bands_gauss1_lin_Norm-median_singlStart'  
; suffix      = 'CR2099_EUVIB_compound1'
; =========================================================     

  
  read_ldem,file_3bands,/ldem,/gauss1,dir=dir
    R_3bands = total( abs(1.-sfbe/tfbe), 4 ) / float(nband)
   R0_3bands = reform( (abs(1.-sfbe/tfbe))(*,*,*,0) )
   R1_3bands = reform( (abs(1.-sfbe/tfbe))(*,*,*,1) )
   R2_3bands = reform( (abs(1.-sfbe/tfbe))(*,*,*,2) )
  fbe_3bands = tfbe
   Ne_3bands = N_e
   Tm_3bands = Tm
 demc_3bands = demc   
  ZDA_3bands = where(demc eq -999.)

  read_ldem,file_2bands,/ldem,/gauss1,dir=dir
     R_2bands = total( abs(1.-sfbe/tfbe), 4 ) / float(nband)
   fbe_2bands = tfbe
    Ne_2bands = N_e
    Tm_2bands = Tm
 demc_2bands = demc 
  ZDA_2bands = where(demc eq -999.)
   
; Set threshholds to handle CNSs.
  R_th_3b   = 0.25
  R_th_2b   = 0.25
  R_th_comp = 0.25
  
; Initialize compound results to 3Bands
  N_e =   Ne_3bands
  Tm  =   Tm_3bands
  R   =    R_3bands
 demc = demc_3bands

; Assign 2bands results where 3Bands has ZDA only due to third band (so that 2bands has no ZDA for sure).
  index = where (fbe_3bands(*,*,*,0) gt 0. AND fbe_3bands(*,*,*,1) gt 0. AND fbe_3bands(*,*,*,2) le 0.)
  N_e (index) =    Ne_2bands(index)
  Tm  (index) =    Tm_2bands(index)
  R   (index) =     R_2bands(index)
  demc(index) =  demc_2bands(index)


; Assign 2bands results where 3Bands has CNS and 2Bands do not.
  index = where (demc_3bands ne -999. AND R_3bands gt R_th_3b AND R_2bands lt R_th_2b)
  N_e (index) =    Ne_2bands(index)
  Tm  (index) =    Tm_2bands(index)
  R   (index) =     R_2bands(index)
  demc(index) =  demc_2bands(index)


; Determine ZDA and CNS indexes for compound result
  ZDA   = where(demc eq -999.)
  CNS   = where(demc ne -999.  AND R gt R_th_comp)


  IF keyword_set(write) then begin
     N_e(CNS) = -666.
     Tm (CNS) = -666.
   ; Save the results  
     openw,1,dir+'Ne_'+suffix+'.dat'
     writeu,1,float(N_e)
     close,1
     openw,1,dir+'Te_'+suffix+'.dat'
     writeu,1,float(Tm) 
     close,1
     RETURN
  ENDIF
  
  
; Display compound results
  Nesat = N_e
  Tmsat = Tm
  Rsat  = R

  superhigh = R_th_comp & p=where(demc ne -999. AND R gt superhigh) & if p(0) ne -1 then Rsat(p)=superhigh
  superlow  = 0.01      & p=where(demc ne -999. AND R le superlow)  & if p(0) ne -1 then Rsat(p)=superlow
  
  
  if ZDA(0) ne -1 then begin
     Nesat(ZDA)=0.
     Tmsat(ZDA)=0.
     Rsat (ZDA)=0.
  endif

  if CNS(0) ne -1 then begin
     Nesat(CNS)= 1.e16
     Tmsat(CNS)= 1.e12
     Rsat (CNS)= R_th_comp
  endif


  r0A     = [1.025,1.105,1.155,1.205,1.245]  
  minA_Ne = (r0A*0.+1.E-6)
  maxA_Ne = [3.5  ,2.5  ,2.2, 2.0, 1.5 ]
  minA_Te = r0A*0. + 0.5
  maxA_Te = r0A*0  + 2.5 
  
  
  
  xdisplay,map=Nesat,file='Ne_'+suffix,nr=nr,nt=nth,rmin=1.0,rmax=1.3,r0A=r0A,win=0, clrtbl= 25,$
           titulo='Ne [10!U8!Ncm!U-3!N]' ,units=1.e8, minA=minA_Ne, maxA=maxA_Ne, /add_bw
  xdisplay,map=tmsat,file='Tm_'+suffix,nr=nr,nt=nth,rmin=1.0,rmax=1.3,r0A=r0A,win=0, clrtbl= 25,$
           titulo='Tm [MK]'              ,units=1.e6, minA=minA_Te, maxA=maxA_Te, /add_bw
  xdisplay,map=Rsat, file='R_' +suffix,nr=nr,nt=nth,rmin=1.0,rmax=1.3,r0A=r0A,win=0, clrtbl= 12,$
           titulo='R'                               , minA=(r0A*0.+1.E-6), maxA=(r0A*0.+0.25)


  
  
  return
end

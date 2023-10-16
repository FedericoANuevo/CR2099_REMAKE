pro carrington_maps,NFS=NFS,write=write

; COMMONS with the DEMT products   
  common comunes,tm,wt,nband,demc,PHI,parametrizacion,Tmin,Tmax,nr,nth,np,rad,lat,lon,lambda,WTc
  common results_tomo,tfbe,sfbe,N_e

; Path to use the x-tools  
  !PATH = Expand_Path('+/data1/tomography/SolarTom_idl') + ':' + !PATH

; Define the root directory  
  root_dir = '/data1/'
  if keyword_set(NFS) then root_dir='/media/Data1/data1/'
; Directory where is the DEMT file  
  dir  =root_dir+'DATA/ldem_files/'
; DEMT file  
  file ='LDEM.CR2099_euvi.A_Hollow_3Bands_gauss1_lin_Norm-median_singlStart' & suffix = 'CR2099_EUVIA_3Bands'
; file ='LDEM.CR2099_euvi.A_Hollow_2Bands_gauss1_lin_Norm-median_singlStart' & suffix = 'CR2099_EUVIA_2Bands' 
  file ='LDEM.CR2099_euvi.B_Hollow_3Bands_gauss1_lin_Norm-median_singlStart' & suffix = 'CR2099_EUVIB_3Bands'
; file ='LDEM.CR2099_euvi.B_Hollow_2Bands_gauss1_lin_Norm-median_singlStart' & suffix = 'CR2099_EUVIA_2Bands' 

; Read the DEMT file  
  if not keyword_set(write) then read_ldem,file,/ldem,/gauss1,dir=dir
; Write the DEMT producs as data-cubes  
  if     keyword_set(write) then begin
     read_ldem,file,/ldem,/gauss1,dir=dir,/write,/mark_AEVs
     RETURN
  endif

; Calculate Score R, ZDAs, and CNSs 
  ratio = sfbe/tfbe &  R = total( abs(1.-ratio), 4 ) / float(nband)
  ZDA   = where(demc eq -999.)
  R_th  = 0.25 & CNS = where(demc ne -999.  AND R gt R_th)

; New arrays to plot  
  Nesat = N_e
  Tmsat = Tm
  Rsat  = R
; Para que los voxeles con R << 1 se vean verde oscuro y no negro:  
  superlow=0.01  & p=where(demc ne -999. AND R le superlow)  & if p(0) ne -1 then Rsat(p)=superlow

; Mark ZDAs  (as black)
  if ZDA(0) ne -1 then begin
     Nesat(ZDA)=0.
     Tmsat(ZDA)=0.
     Rsat (ZDA)=0.
  endif
; Mark AEVs (CNSs, as white)
  if CNS(0) ne -1 then begin
     Nesat(CNS)= 1.e16
     Tmsat(CNS)= 1.e12
     Rsat (CNS)= R_th
  endif

; Range to heights to plot 
  r0A     = [1.025,1.105,1.205,1.245]
; r0A     = [1.155,1.205,1.245]
; min and max values to N_e plots  
  minA_Ne = (r0A*0.+1.E-6)
  maxA_Ne = [3.5  ,2.5  ,2.0, 1.5 ] 
; maxA_Ne = [2.5  ,1.5  ,1.0 ]/1.5
; min and max values to T_m plots  
  minA_Te = r0A*0. + 0.5
  maxA_Te = r0A*0  + 2.5 
   
; Make the lat-lon maps for N_e, T_m, and Score R with x-tools routines
  xdisplay,map=Nesat,file='Ne_'+suffix,nr=nr,nt=nth,rmin=1.0,rmax=1.3,r0A=r0A,win=0, clrtbl= 25,$
           titulo='Ne [10!U8!Ncm!U-3!N]', units=1.e8, minA=minA_Ne, maxA=maxA_Ne, /add_bw
  xdisplay,map=tmsat,file='Tm_'+suffix,nr=nr,nt=nth,rmin=1.0,rmax=1.3,r0A=r0A,win=0, clrtbl= 25,$
           titulo='Tm [MK]',units=1.e6, minA=minA_Te, maxA=maxA_Te, /add_bw
  xdisplay,map=Rsat, file='R_' +suffix,nr=nr,nt=nth,rmin=1.0,rmax=1.3,r0A=r0A,win=0, clrtbl= 12,$
           titulo='R',minA=(r0A*0.+1.E-6), maxA=(r0A*0.+0.25) ;,/add_bw

   
  return
end

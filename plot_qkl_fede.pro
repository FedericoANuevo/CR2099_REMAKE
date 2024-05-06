
pro plot_qkl_euvi
; root directory;
  root_dir = '/data1/'
; TRFs directory:
  Qkldir = root_dir+'DATA/EUV_TRFs_and_PassBands/'
; TRFs files
; Qklfiles = ['Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
;             'Qkl_195_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
;             'Qkl_284_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out']
  Qklfiles = ['Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_195_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_284_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out']

  qklfiles = Qkldir+qklfiles
; Bands to use:
  bandsindexes = [0,1,2]
; Temperature grid parameters
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  DT   =  5.e-4                 ; MK 
; call to main routine
  plot_qkl,qklfiles,Tmin,Tmax,DT,bandsindexes
  
  
  return
end


pro plot_qkl_aia
; root directory;
  root_dir = '/data1/'
; TRFs directory:
  Qkldir = root_dir+'DATA/EUV_TRFs_and_PassBands/'
; TRFs files
  Qklfiles = ['Qkl_094_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_131_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_193_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_211_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_335_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ]
  qklfiles = Qkldir+qklfiles
; Bands to use:
  bandsindexes = [2,3,4]
; Temperature grid parameters
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  DT   =  5.e-4                 ; MK 
; call to main routine
  plot_qkl,qklfiles,Tmin,Tmax,DT,bandsindexes
  return
end


; MAIN-ROUTINE
pro plot_qkl,qklfiles,Tmin,Tmax,DT,bandsindexes

  qklfiles  = qklfiles  (bandsindexes)
  nband     = n_elements(bandsindexes) 
; Change Tmin and Tmax to K and calculate de number of temp. bins
  Tmin = Tmin*1.e6                   ; K
  Tmax = Tmax*1.e6                   ; K
  DT   = DT  *1.e6                   ; K 
  nTbins=LONG((Tmax-Tmin)/DT) ; Number of Temp bins
; Read the TRF files
  read_Qkl,qklfiles,logT,kernel,nband
; Interpol the TRF to a linear grid and create the temperature grid
  Interpol_Qkl,logT,kernel,nband,nTbins,Tmin,Tmax,Qkl,X 
; Temperature grid in K  
  T      = x*Tmin
; Vectors to store T_max and FWHM of TRFs  
  Tmax_v = fltarr(nband)
  fwhm_v = fltarr(nband)
; This loop in bands plot the TRFs and calculate the T_max and FWHM of
; each TRF  
  for iband=0,nband-1 do begin
     if iband eq 0 then plot,T/1.e6,Qkl(iband,*)/max(Qkl(iband,*))
     oplot,T/1.e6,Qkl(iband,*)/max(Qkl(iband,*))
     i_Tmax = (where( Qkl(iband,*) eq max(Qkl(iband,*))))(0)
     Tmax_V(iband) = T(i_Tmax)/1.e6
     fa = abs(Qkl(iband,0:i_Tmax-1)-0.5*max(Qkl(iband,0:i_Tmax-1)))
     ia = where( fa eq min(fa))
     Ta =( T(0:i_Tmax-1))(ia)
     fb = abs(Qkl(iband,i_Tmax:nTbins-1)-0.5*max(Qkl(iband,i_Tmax:nTbins-1)))
     ib = where( fb eq min(fb))
     Tb =( T(i_Tmax:nTbins-1))(ib)
     fwhm_v(iband)= (Tb - Ta)/1.e6
  endfor
; Print T_max and FWHM of TRFs   
  print,'Tmax [MK]: ',tmax_v
  print,'FWHM [MK]: ',fwhm_v
  
  STOP
  return
end


; ======================= SUB-ROUTINES ==================================

pro read_Qkl,qklfiles,logT,kernel,nband

; Initialize variables to read  
  x        =''
  N_e      =0.
  logem    =0.
  inst_fwhm=0.
  Ntemp    =0.
  w1       =0.
  w2       =0.
  wbin     =0.
  Nlambda  =0.
  psi      =0.
  psi_const=fltarr(nband)
  tt       =0.
  ii       =0.

; Read the TRFs from ASCII files  
  for ip=0,nband-1 do begin ; band loop
     openr,1,qklfiles(ip)
     for i=1,4 do readf,1,x
     readf,1,n_e,logem
     readf,1,x
     readf,1,Inst_fwhm, NTemp, w1, w2, wbin, Nlambda
     readf,1,x
     readf,1,psi
     psi_const(ip)=psi
     readf,1,x
     if ip eq 0 then begin
        kernel=fltarr(nband,ntemp) ; Initialize Q_k array
        logT  =fltarr(ntemp)       ; Initialize log(T_e) array
     endif
     for i=0,ntemp-1 do begin   ; Temperature loop
        readf,1,tt,ii
        if ip eq 0 then logT(i)=tt
        kernel(ip,i)=ii
     endfor                     ; Finish Temperature loop
     close,1
  endfor                        ; Finish band loop
  kernel=kernel*1.d0            ; convert to double presition
  return
end


pro Interpol_Qkl,logT,kernel,nband,nTbins,Tmin,Tmax,Qkl,X

; Select range of interest
  range=where( (logT ge alog10(Tmin)) AND (logT le alog10(Tmax)) )
  range=[min(range)-1,range,max(range)+1]

; Select the temperature range to be used:
; and correct Tmin and Tmax
  logaT  = [logT(    range)]
  skernel = kernel(*,range)
; Tmin   = 10.^min(logaT) 
; Tmax   = 10.^max(logaT)

; derive x = T/Tmin from log(T)   
  Xold = 10.^logaT/Tmin

; Decide NEW grid
; Make  X = T/Tmin
  DT_L = (Tmax-Tmin) / float(nTbins)
  T_L  = Tmin + DT_L /2. + DT_L *findgen(nTbins)
  X    = T_L /Tmin
     
; Interpolate logaT into the X-grid
  logaT = interpol(logaT,Xold,X)

; Make the Qkl array, interpolated into the X-grid
  Qkl=dblarr(nband,nTbins)
  for ib=0,nband-1 do Qkl(ib,*) = interpol(skernel(ib,*),Xold,X) ;,/spline)

;Check interpolation:
goto,skip
    window,0
    plot,10.^logT/1.e6,kernel(0,*),xr=[0.5,5],/ylog,xtitle='T!de!n [MK]',title='TRFs'
    for ib=0,nband-1 do oplot,10.^logT/1.e6   ,kernel(ib,*)
    for ib=0,nband-1 do oplot,X*Tmin/1.e6,        Qkl(ib,*),psym=4,th=4
    window,1
    if nband ne 2 then STOP
    plot,X*Tmin/1.e6,Qkl(0,*)/Qkl(1,*),xtitle='T!de!n [MK]',title='Ratio Qa/Qb'
    STOP
skip:
return
end

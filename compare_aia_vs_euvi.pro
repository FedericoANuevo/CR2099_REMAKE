
; ratio       = values_A/values_B
; ratio       = AIA/EUVI

; Uso EUVI = EUVI-B por similitud con Fig 6 Nuevo et al. (2015)

pro compare_aia_vs_euvi,str=str,nch=nch,sch=sch

; --------------------------------------------------------------
  if keyword_set(str) then begin
     lat_range   = [-40., 40.]
     lon_range   = [  0.,180.]
     region_name = 'STR: '
     comp_suffix = 'aia_vs_euvi_STR'
  endif
; --------------------------------------------------------------
  if keyword_set(nch) then begin
     lat_range   = [70., 90.]
     lon_range   = [ 0.,180.]
     region_name = 'NCH: '
     comp_suffix = 'aia_vs_euvi_NCH'
  endif
; --------------------------------------------------------------
  if keyword_set(sch) then begin
     lat_range   = [-90.,-70]
     lon_range   = [ 0.,360.]
     region_name = 'SCH: '
     comp_suffix = 'aia_vs_euvi_SCH'
  endif
; ------------------------------------------------------------  
    
; Path to use x-tools in SolarTom_idl  
  !PATH = Expand_Path('+/data1/tomography/SolarTom_idl') + ':' + !PATH


; Instrumental rmin and rmax 
  Irmin =  1.02
  Irmax =  1.25
; Grid settings
  rmin  = 1.0
  rmax  = 1.3
  nr    = 30
  nt    = 90
  np    = 2*nt

  
; A => SDO/AIA
; ======================================================================  
  dirA     = '/data1/DATA/ldem_files/'
; fileA    = 'LDEM.CR2099_aia_Hollow_3Bands_gauss1_lin_Norm-median_singlStart'
; fileA    = 'CR2099_AIA_compound1.dat'
  fileA    = 'LDEM.CR2099_aia_Hollow_3Bands_131-193A_gauss1_lin_Norm-median_singlStart'
; fileA    = 'LDEM.CR2099_aia_Hollow_2Bands_gauss1_lin_Norm-median_singlStart'
; fileA    = 'ratio_CR2099_AIA171-193A.dat'
  fileA_Ne = 'Ne_'+fileA
  fileA_Te = 'Te_'+fileA
  labelA   = 'AIA'
; ======================================================================  

; B => STEREO/EUVI
; ======================================================================  
  dirB     = '/data1/DATA/ldem_files/'
  fileB    = 'LDEM.CR2099_euvi.B_Hollow_3Bands_gauss1_lin_Norm-median_singlStart'
; fileB    = 'CR2099_EUVIB_compound1.dat'
; fileB    = 'LDEM.CR2099_euvi.B_Hollow_2Bands_gauss1_lin_Norm-median_singlStart'
; fileB    = 'ratio_CR2099_EUVI-B_171-195A.dat' 
  fileB_Ne = 'Ne_'+fileB
  fileB_Te = 'Te_'+fileB
  labelB   = 'EUVI'
; ======================================================================    

  

  
;  Call to xcompare (from x-tools)
; ========================================================================================
; N_e  (electron density)
  r0A = [1.025,1.105,1.245]
  units = 1.e8
  min_rat = 0.1 +  0. * r0A
  max_rat = 3.5 +  0. * r0A
  histo_x_tit='N!de!n ratio AIA/EUVI'
  xcompare,dirA=dirA,dirB=dirB,fileA=fileA_Ne,fileB=fileB_Ne,nrA=nr,ntA=nt,rminA=rmin,rmaxA=rmax,$
           lat_range=lat_range,lon_range=lon_range, comp_suffix='Ne_'+comp_suffix,$
           histo_x_tit=histo_x_tit,tit='',rad_y_tit='N!De!N [10!u8!n cm!u-3!n]',$
           rgA=[Irmin,Irmax],r0A=r0A,LabelA=labelA,LabelB=labelB,$
           h_rg=[Irmin,Irmax],max_ratio=max_rat,min_ratio=min_rat,units=units,region_name=region_name
; -------------------------------------------------------------------------------------------
; T_e   (electron temperature)
  r0A = [1.025,1.105,1.245]
  units = 1.e6
  min_rat = 0.1 +  0. * r0A
  max_rat = 3.5 +  0. * r0A
  histo_x_tit='T!de!n ratio AIA/EUVI'
  xcompare,dirA=dirA,dirB=dirB,fileA=fileA_Te,fileB=fileB_Te,nrA=nr,ntA=nt,rminA=rmin,rmaxA=rmax,$
           lat_range=lat_range,lon_range=lon_range, comp_suffix='Te_'+comp_suffix,$
           histo_x_tit=histo_x_tit,tit='',rad_y_tit='T!De!N [MK]',$
           rgA=[Irmin,Irmax],r0A=r0A,LabelA=labelA,LabelB=labelB,$
           h_rg=[Irmin,Irmax],max_ratio=max_rat,min_ratio=min_rat,units=units,region_name=region_name

; ========================================================================================   


  
  
  
  return
end



  

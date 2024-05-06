
pro ldem_actual_aia_fov_total
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_aia_fov_total.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp
; Bandas a utilizar:
  bandsindexes = [2,3,4] 
; Parametros de grilla (35x90x180)  
  nr    = 35   & nth   = 90
  rmin  = 1.00 & rmax  = 1.35  & dr = (rmax-rmin)/nr
  Irmin = 1.02 & Irmax = 1.30
  i_inst_rmax = round((Irmax - rmin)/dr);-1
  i_inst_rmin = round((Irmin - rmin)/dr)
; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['',$
              '',$
              'x_aia.171.CR2099_hollow_NEW_Irmax1.3_Rmin1.00_Rmax1.35_IRmax1.30_35x90x180_BF4_L0.7',$
              'x_aia.193.CR2099_hollow_NEW_Irmax1.3_Rmin1.00_Rmax1.35_IRmax1.30_35x90x180_BF4_L0.3',$
              'x_aia.211.CR2099_hollow_NEW_Irmax1.3_Rmin1.00_Rmax1.35_IRmax1.30_35x90x180_BF4_L0.2',$      
              '']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_aia_Hollow_3Bands_Irmax1.3'
; ================== hasta aquí =========================================

; No es relevante para DEMT
; ------------------------------------------------ 
  npx         = 1024 ; para DEM-2D
  fact        = 4.   ; para parametrization EQ.           
  binfactor   = 2    ; para DEM-2D
; ------------------------------------------------
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_094_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_131_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_193_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_211_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_335_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ]
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /aia,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax,i_inst_rmin=i_inst_rmin

  return
end

pro ldem_actual_aia_fov1
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_aia_fov1.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp
; Bandas a utilizar:
  bandsindexes = [2,3,4] 
; Parametros de grilla (20x90x180)  
  nr    = 20   & nth   = 90
  rmin  = 1.00 & rmax  = 1.20  & dr = (rmax-rmin)/nr
  Irmin = 1.02 & Irmax = 1.15
  i_inst_rmax = round((Irmax - rmin)/dr);-1
  i_inst_rmin = round((Irmin - rmin)/dr)
; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['',$
              '',$
              'x_aia.171.CR2099_hollow_NEW_fov1_Rmin1.00_Rmax1.20_IRmax1.15_20x90x180_BF4_L0.6',$
              'x_aia.193.CR2099_hollow_NEW_fov1_Rmin1.00_Rmax1.20_IRmax1.15_20x90x180_BF4_L0.5',$
              'x_aia.211.CR2099_hollow_NEW_fov1_Rmin1.00_Rmax1.20_IRmax1.15_20x90x180_BF4_L0.3',$      
              '']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_aia_Hollow_3Bands_fov1'
; ================== hasta aquí =========================================

; No es relevante para DEMT
; ------------------------------------------------ 
  npx         = 1024 ; para DEM-2D
  fact        = 4.   ; para parametrization EQ.           
  binfactor   = 2    ; para DEM-2D
; ------------------------------------------------
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_094_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_131_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_193_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_211_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_335_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ]
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /aia,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax,i_inst_rmin=i_inst_rmin

  return
end

pro ldem_actual_aia_fov2
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_aia_fov2.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp
; Bandas a utilizar:
  bandsindexes = [2,3,4] 
; Parametros de grilla (20x90x180)  
  nr    = 20   & nth   = 90
  rmin  = 1.15 & rmax  = 1.35  & dr = (rmax-rmin)/nr
  Irmin = 1.15 & Irmax = 1.30
  i_inst_rmax = round((Irmax - rmin)/dr);-1
  i_inst_rmin = round((Irmin - rmin)/dr)
; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['',$
              '',$
              'x_aia.171.CR2099_hollow_NEW_fov2_Rmin1.15_Rmax1.35_IRmax1.30_20x90x180_BF4_L1.4',$
              'x_aia.193.CR2099_hollow_NEW_fov2_Rmin1.15_Rmax1.35_IRmax1.30_20x90x180_BF4_L1.0',$
              'x_aia.211.CR2099_hollow_NEW_fov2_Rmin1.15_Rmax1.35_IRmax1.30_20x90x180_BF4_L0.9',$      
              '']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_aia_Hollow_3Bands_fov2'
; ================== hasta aquí =========================================

; No es relevante para DEMT
; ------------------------------------------------ 
  npx         = 1024 ; para DEM-2D
  fact        = 4.   ; para parametrization EQ.           
  binfactor   = 2    ; para DEM-2D
; ------------------------------------------------
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_094_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_131_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_193_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_211_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_335_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ]
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /aia,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax,i_inst_rmin=i_inst_rmin

  return
end

pro ldem_actual_aia_Irmax_1_2
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_aia_Irmax_1_2.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp
; Bandas a utilizar:
  bandsindexes = [2,3,4] 
; Parametros de grilla (25x90x180)  
  nr    = 25   & nth   = 90
  rmin  = 1.00 & rmax  = 1.25  & dr = (rmax-rmin)/nr
  Irmin = 1.02 & Irmax = 1.20
  i_inst_rmax = round((Irmax - rmin)/dr);-1
  i_inst_rmin = round((Irmin - rmin)/dr)
; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['',$
              '',$
              'x_aia.171.CR2099_hollow_NEW_Irmax1.2_Rmin1.0_Rmax1.25_IRmax1.2_25x90x180_BF4_L0.6',$
              'x_aia.193.CR2099_hollow_NEW_Irmax1.2_Rmin1.0_Rmax1.25_IRmax1.2_25x90x180_BF4_L0.4',$
              'x_aia.211.CR2099_hollow_NEW_Irmax1.2_Rmin1.0_Rmax1.25_IRmax1.2_25x90x180_BF4_L0.2',$      
              '']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_aia_Hollow_3Bands_Irmax1.2'
; ================== hasta aquí =========================================

; No es relevante para DEMT
; ------------------------------------------------ 
  npx         = 1024 ; para DEM-2D
  fact        = 4.   ; para parametrization EQ.           
  binfactor   = 2    ; para DEM-2D
; ------------------------------------------------
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_094_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_131_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-20.0MK.out',$
              'Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_193_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_211_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ,$
              'Qkl_335_chianti.ioneq_sun_coronal_1992_feldman_ext.abund.AIA-OptimalWaveRange-photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10.Nosum_Te0.1-5.0MK.out' ]
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /aia,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax,i_inst_rmin=i_inst_rmin

  return
end

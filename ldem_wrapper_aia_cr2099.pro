;--------------------------------------------------------------------------------
; Wrapper-1
; Solución HOLLOW 3-bandas usando FBE lambda_opt de cada banda.

pro ldem_actual_aia_hollow_3bands
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_aia_hollow_3bands.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp, es un número standard. El resultado es insensible a este número, siempre que sea razonable.

; Bandas a utilizar:
  bandsindexes = [2,3,4] 

  nr          =   30
  i_inst_rmax =   25            ; Poner aquí el índice de grilla radial de INST_RMAX del cálculo de FBEs.
  nth         =   90
  npx         = 1024
  fact        = 4.              ; Esta entrada es para una parametrización LDEM alternativa a Gauss1, no se usa por ahora pero la ponemos porque el código la espera.
  binfactor   = 2               ; Esto se usa para análisis DEM de imágenes, para reducir el tamaño. No se usa para LDEM.

; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['x_aia.094.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.52',$
              'x_aia.131.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.39',$
              'x_aia.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.63',$
              'x_aia.193.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.37',$
              'x_aia.211.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.5' ,$      
              'x_aia.335.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.38']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_aia_Hollow_3Bands'
; ================== hasta aquí =========================================
  
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
          /aia,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax

  return
end

; Wrapper-2
; Solución HOLLOW 2-bandas usando FBE lambda_opt de cada banda.

pro ldem_actual_aia_hollow_2bands
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_aia_hollow_2bands.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp, es un número standard. El resultado es insensible a este número, siempre que sea razonable.

; Bandas a utilizar:
  bandsindexes = [2,3] 

  nr          =   30
  i_inst_rmax =   25            ; Poner aquí el índice de grilla radial de INST_RMAX del cálculo de FBEs.
  nth         =   90
  npx         = 1024
  fact        = 4.              ; Esta entrada es para una parametrización LDEM alternativa a Gauss1, no se usa por ahora pero la ponemos porque el código la espera.
  binfactor   = 2               ; Esto se usa para análisis DEM de imágenes, para reducir el tamaño. No se usa para LDEM.

; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['x_aia.094.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.52',$
              'x_aia.131.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.39',$
              'x_aia.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.63',$
              'x_aia.193.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.37',$
              'x_aia.211.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.5' ,$      
              'x_aia.335.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.38']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_aia_Hollow_2Bands'
; ================== hasta aquí =========================================
  
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
          /aia,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax

  return
end


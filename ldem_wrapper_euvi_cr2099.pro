;--------------------------------------------------------------------------------
; Wrapper-1
; Solución HOLLOW 3-bandas usando FBE lambda_opt de cada banda para EUVI-A

pro ldem_actual_euviA_hollow_3bands
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_euviA_hollow_3bands.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp, es un número standard. El resultado es insensible a este número, siempre que sea razonable.

; Bandas a utilizar:
  bandsindexes = [0,1,2] 

  nr          =   30
  i_inst_rmax =   25            ; Poner aquí el índice de grilla radial de INST_RMAX del cálculo de FBEs.
  nth         =   90
  npx         = 1024
  fact        = 4.              ; Esta entrada es para una parametrización LDEM alternativa a Gauss1, no se usa por ahora pero la ponemos porque el código la espera.
  binfactor   = 2               ; Esto se usa para análisis DEM de imágenes, para reducir el tamaño. No se usa para LDEM.

; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['x_euviA.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.35',$
              'x_euviA.195.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.21',$      
              'x_euviA.284.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.28']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_euvi.A_Hollow_3Bands'
; ================== hasta aquí =========================================
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_195_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_284_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out']
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /euvi,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax

  return
end

 ;--------------------------------------------------------------------------------
; Wrapper-2
; Solución HOLLOW 3-bandas usando FBE lambda_opt de cada banda para EUVI-B

pro ldem_actual_euviB_hollow_3bands
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_euviB_hollow_3bands.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp, es un número standard. El resultado es insensible a este número, siempre que sea razonable.

; Bandas a utilizar:
  bandsindexes = [0,1,2] 

  nr          =   30
  i_inst_rmax =   25            ; Poner aquí el índice de grilla radial de INST_RMAX del cálculo de FBEs.
  nth         =   90
  npx         = 1024
  fact        = 4.              ; Esta entrada es para una parametrización LDEM alternativa a Gauss1, no se usa por ahora pero la ponemos porque el código la espera.
  binfactor   = 2               ; Esto se usa para análisis DEM de imágenes, para reducir el tamaño. No se usa para LDEM.

; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['x_euviB.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.38',$
              'x_euviB.195.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.49',$      
              'x_euviB.284.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.41']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_euvi.B_Hollow_3Bands'
; ================== hasta aquí =========================================
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_195_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_284_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out']
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /euvi,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax

  return
end

; Wrapper-3
; Solución HOLLOW 2-bandas usando FBE lambda_opt de cada banda para EUVI-A

pro ldem_actual_euviA_hollow_2bands
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_euviA_hollow_2bands.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp, es un número standard. El resultado es insensible a este número, siempre que sea razonable.

; Bandas a utilizar:
  bandsindexes = [0,1] 

  nr          =   30
  i_inst_rmax =   25            ; Poner aquí el índice de grilla radial de INST_RMAX del cálculo de FBEs.
  nth         =   90
  npx         = 1024
  fact        = 4.              ; Esta entrada es para una parametrización LDEM alternativa a Gauss1, no se usa por ahora pero la ponemos porque el código la espera.
  binfactor   = 2               ; Esto se usa para análisis DEM de imágenes, para reducir el tamaño. No se usa para LDEM.

; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['x_euviA.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.35',$
              'x_euviA.195.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.21',$      
              'x_euviA.284.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.28']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_euvi.A_Hollow_2Bands'
; ================== hasta aquí =========================================
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_195_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_284_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out']
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /euvi,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax

  return
end

;--------------------------------------------------------------------------------
; Wrapper-4
; Solución HOLLOW 2-bandas usando FBE lambda_opt de cada banda para EUVI-B

pro ldem_actual_euviB_hollow_2bands
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_euviB_hollow_3bands.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp, es un número standard. El resultado es insensible a este número, siempre que sea razonable.

; Bandas a utilizar:
  bandsindexes = [0,1] 

  nr          =   30
  i_inst_rmax =   25            ; Poner aquí el índice de grilla radial de INST_RMAX del cálculo de FBEs.
  nth         =   90
  npx         = 1024
  fact        = 4.              ; Esta entrada es para una parametrización LDEM alternativa a Gauss1, no se usa por ahora pero la ponemos porque el código la espera.
  binfactor   = 2               ; Esto se usa para análisis DEM de imágenes, para reducir el tamaño. No se usa para LDEM.

; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['x_euviB.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.38',$
              'x_euviB.195.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.49',$      
              'x_euviB.284.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.41']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_euvi.B_Hollow_2Bands'
; ================== hasta aquí =========================================
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_195_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_284_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out']
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /euvi,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax

  return
end


; Wrapper-5
; Solución HOLLOW 3-bandas usando FBE lambda_opt de cada banda para EUVI-A
; Modificamos Q_k(T_e) de k = 284 A para eliminar el segundo maximo de
; sensibilidad termica a bajas temperaturas ( ~ 0.6 MK).

pro ldem_actual_euviA_hollow_3bands_test
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_euviA_hollow_3bands.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp, es un número standard. El resultado es insensible a este número, siempre que sea razonable.

; Bandas a utilizar:
  bandsindexes = [0,1,2] 

  nr          =   30
  i_inst_rmax =   25            ; Poner aquí el índice de grilla radial de INST_RMAX del cálculo de FBEs.
  nth         =   90
  npx         = 1024
  fact        = 4.              ; Esta entrada es para una parametrización LDEM alternativa a Gauss1, no se usa por ahora pero la ponemos porque el código la espera.
  binfactor   = 2               ; Esto se usa para análisis DEM de imágenes, para reducir el tamaño. No se usa para LDEM.

; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['x_euviA.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.35',$
              'x_euviA.195.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.21',$      
              'x_euviA.284.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.28']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_euvi.A_Hollow_3Bands'
; ================== hasta aquí =========================================
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_195_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_284_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIA-S1a-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out']
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /euvi,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax

  return
end
;--------------------------------------------------------------------------------
; Wrapper-6
; Solución HOLLOW 3-bandas usando FBE lambda_opt de cada banda para EUVI-B
; Modificamos Q_k(T_e) de k = 284 A para eliminar el segundo maximo de
; sensibilidad termica a bajas temperaturas ( ~ 0.6 MK).


pro ldem_actual_euviB_hollow_3bands_test
;   NOTA: El BATCH correspondiente es:
;   ldem_actual_euviB_hollow_3bands.batch
  
;=====================Editar parámetros desde aquí=======================
; Grilla de Temperatura para determinar la LDEM:
  Tmin =  0.5                   ; MK
  Tmax =  3.5                   ; MK
  L    =  171                   ; Es el Nbins de Temp, es un número standard. El resultado es insensible a este número, siempre que sea razonable.

; Bandas a utilizar:
  bandsindexes = [0,1,2] 

  nr          =   30
  i_inst_rmax =   25            ; Poner aquí el índice de grilla radial de INST_RMAX del cálculo de FBEs.
  nth         =   90
  npx         = 1024
  fact        = 4.              ; Esta entrada es para una parametrización LDEM alternativa a Gauss1, no se usa por ahora pero la ponemos porque el código la espera.
  binfactor   = 2               ; Esto se usa para análisis DEM de imágenes, para reducir el tamaño. No se usa para LDEM.

; FBE directory:
  dir    = '/media/Data1/data1/tomography/bindata/'
; FBES lambda_opt (determinado por auto_cv):
  datafiles= ['x_euviB.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.38',$
              'x_euviB.195.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.49',$      
              'x_euviB.284.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.41']
; Sufijo para indicar el periodo (rotacion de Carrington)
  CRstring= 'CR2099'
; Sufijo para indicar instrumento, disk/hollow, numero de bandas utilizadas:
  Expstring= '_euvi.B_Hollow_3Bands'
; ================== hasta aquí =========================================
  
; Qkl directory:
  Qkldir = '/media/Data1/data1/DATA/EUV_TRFs_and_PassBands/'
; Qkl files
  Qklfiles = ['Qkl_171_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_195_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out',$
              'Qkl_284_chianti.ioneq_sun_coronal_1992_feldman_ext.abund_EUVIB-S1b-Filter_OptimalWaveRange_photons-Abund-1e-3-ALL-withCONTINUUM_Ne1E08_C10_Te0.1-5.0MK.out']
; Agrego el path del directorio:
  Qklfiles   = Qkldir + Qklfiles
                               
; Armar sufijo de salida y correr:
  suffix = CRstring+Expstring 
  ldem_actual,Tmin,Tmax,datafiles,qklfiles,bandsindexes,suffix,dir,L,nr,nth,npx,binfactor,fact,$
          /euvi,/norm_median,/ldem,/gauss1,/single,/linear,/rebin,i_inst_rmax=i_inst_rmax

  return
end

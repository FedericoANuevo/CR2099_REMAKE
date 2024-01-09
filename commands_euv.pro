

pro commands

; EDIT THIS SECTION ONLY!
; ===========================================================================================
  basedir     = './'
  filename    = 'commands_aia_CR2099_hollow_NEW_fov2.txt'
  file_suffix = 'CR2099_hollow_NEW_fov2'
  exe_suffix  = 'cr2099_hollow_new_fov2'

  instrBUILD='AIABUILD' 
; instrBUILD='EUVIBUILD' & spacecraft='stereo-A'
  tomtype   ='hollow' ; 'disk'

  rmin   = 1.15   & rmin_str = '1.15'  
  rmax   = 1.35   & rmax_str = '1.35' 
; Irmin  = 0.00   & Irmin_str= '0.00'
  Irmax  = 1.30   & Irmax_str= '1.30'
  Nr     = 20     & Nr_str   = '20'
  Nth    = 90     & Nth_str  = '90'
  Nph    = 180    & Nph_str  = '180'
  BF     = 4      & BF_str   = '4'
  reg    = 1.0    & reg_str  = '1.0'
  dirlist= 'DATA/aia/CR2099_new/???/'
  list   = 'list.???.tom'
; ===========================================================================================

 
  if tomtype eq 'disk'   then INNER_REJECT_RAD = 0.98
  if tomtype eq 'hollow' then INNER_REJECT_RAD = 0.00
  OUTER_REJECT_RAD = 1.02


  drad = (rmax-rmin)/Nr
  dth  = 180./Nth

 
  if instrBUILD eq 'EUVIBUILD' then begin

     if spacecraft eq 'stereo-A' then begin
        A_outfile_171 = 'euviA.171.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
        A_outfile_195 = 'euviA.195.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
        A_outfile_284 = 'euviA.284.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
        X_infile      = 'x_zero_'+nr_str+'_'+nth_str+'_'+nph_str
        X_outfile_171 = 'x_'+A_outfile_171+'_L'+reg_str
        X_outfile_195 = 'x_'+A_outfile_195+'_L'+reg_str
        X_outfile_284 = 'x_'+A_outfile_284+'_L'+reg_str
     endif
     if spacecraft eq 'stereo-B' then begin
        A_outfile_171 = 'euviB.171.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
        A_outfile_195 = 'euviB.195.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
        A_outfile_284 = 'euviB.284.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
        X_infile      = 'x_zero_'+nr_str+'_'+nth_str+'_'+nph_str
        X_outfile_171 = 'x_'+A_outfile_171+'_L'+reg_str
        X_outfile_195 = 'x_'+A_outfile_195+'_L'+reg_str
        X_outfile_284 = 'x_'+A_outfile_284+'_L'+reg_str
     endif
     if spacecraft eq 'stereo-A' then begin
        exe_suffix_171 = 'euviA.171.'+exe_suffix
        exe_suffix_195 = 'euviA.195.'+exe_suffix
        exe_suffix_284 = 'euviA.284.'+exe_suffix
     endif
     if spacecraft eq 'stereo-B' then begin
        exe_suffix_171 = 'euviB.171.'+exe_suffix
        exe_suffix_195 = 'euviB.195.'+exe_suffix
        exe_suffix_284 = 'euviB.284.'+exe_suffix
     endif


     filename = basedir + filename
     openw,1, filename
     printf,1
     printf,1,'e buildA_params.h'
     printf,1,'editar en Sección '+instrBUILD+':'
     printf,1,'-------------------------------------------------------------------------------------'
     printf,1,'Rmin, Rmax, DRAD, NRAD =',rmin,rmax,drad,nr
     printf,1,'INST_RMAX              =',Irmax
     printf,1,'INNER_REJECT_RAD       =',INNER_REJECT_RAD
     printf,1,'OUTER_REJECT_RAD       =',OUTER_REJECT_RAD
     printf,1,'NTHETA, DTHETA         =',Nth,dth 
     printf,1,'BF                     =',BF
     printf,1,'--------------------------------------------------------------------------------------'
     printf,1,'#define DATADIR    TOMROOT "'+dirlist+'"'
     printf,1,'#define CONFSTRING DATADIR "'+list+'"' 
     printf,1,'#define A_OUTFILE "'+A_outfile_171+'"' 
     printf,1,'#define A_OUTFILE "'+A_outfile_195+'"' 
     printf,1,'#define A_OUTFILE "'+A_outfile_284+'"' 
     printf,1
     printf,1,'e solve_cv_params.h'
     printf,1,'editar'
     printf,1,'#define FILESTR1 "r3_'+nr_str+'_'+nth_str+'_'+nph_str

     printf,1
     printf,1,'make clean'
     printf,1,'make builda'
     printf,1,'make callsolve_cg' 
     printf,1,'make auto_cv_brent'
     printf,1,'cp builda ba_'           +exe_suffix_171
     printf,1,'cp callsolve_cg cs_'     +exe_suffix_171
     printf,1,'cp auto_cv_brent autocv_'+exe_suffix_171
     printf,1
     printf,1,'make clean'
     printf,1,'make builda'
     printf,1,'make callsolve_cg' 
     printf,1,'make auto_cv_brent'
     printf,1,'cp builda ba_'           +exe_suffix_195
     printf,1,'cp callsolve_cg cs_'     +exe_suffix_195
     printf,1,'cp auto_cv_brent autocv_'+exe_suffix_195
     printf,1
     printf,1,'make clean'
     printf,1,'make builda'
     printf,1,'make callsolve_cg' 
     printf,1,'make auto_cv_brent'
     printf,1,'cp builda ba_'           +exe_suffix_284
     printf,1,'cp callsolve_cg cs_'     +exe_suffix_284
     printf,1,'cp auto_cv_brent autocv_'+exe_suffix_284
   
          

     printf,1
     printf,1,'nohup ./ba_'+exe_suffix_171+' > '+'termout_bA_'+A_outfile_171+' 2>&1 &' 
     printf,1,'nohup ./ba_'+exe_suffix_195+' > '+'termout_bA_'+A_outfile_195+' 2>&1 &' 
     printf,1,'nohup ./ba_'+exe_suffix_284+' > '+'termout_bA_'+A_outfile_284+' 2>&1 &' 
     
     printf,1
     printf,1,'nohup ./cs_'+exe_suffix_171+' '+X_infile+' '+x_outfile_171+' '+A_outfile_171+' '+reg_str+' > '+'termout_cs_'+A_outfile_171+'_L'+reg_str+' 2>&1 &'
     printf,1,'nohup ./cs_'+exe_suffix_195+' '+X_infile+' '+x_outfile_195+' '+A_outfile_195+' '+reg_str+' > '+'termout_cs_'+A_outfile_195+'_L'+reg_str+' 2>&1 &'
     printf,1,'nohup ./cs_'+exe_suffix_284+' '+X_infile+' '+x_outfile_284+' '+A_outfile_284+' '+reg_str+' > '+'termout_cs_'+A_outfile_284+'_L'+reg_str+' 2>&1 &'
  
     printf,1
     printf,1,'cd /media/Data1/data1/tomography/bindata/'
     printf,1,'cp x_'+A_outfile_171+'_L'+reg_str+' x_'+exe_suffix_171+'_acv'
     printf,1,'cd /data1/tomography/SolarTom_GRUPO_torre1/'
     printf,1
     printf,1,'cd /media/Data1/data1/tomography/bindata/'
     printf,1,'cp x_'+A_outfile_195+'_L'+reg_str+' x_'+exe_suffix_195+'_acv'
     printf,1,'cd /data1/tomography/SolarTom_GRUPO_torre1/'
     printf,1
     printf,1,'cd /media/Data1/data1/tomography/bindata/'
     printf,1,'cp x_'+A_outfile_284+'_L'+reg_str+' x_'+exe_suffix_284+'_acv'
     printf,1,'cd /data1/tomography/SolarTom_GRUPO_torre1/'
 
 

     printf,1
     printf,1,'nohup ./autocv_'+exe_suffix_171+' -r5 -w1 -m '+A_outfile_171+' -i x_'+exe_suffix_171+'_acv'+' -o x_'+exe_suffix_171+'_acv > '+'termout_acv_'+A_outfile_171+' 2>&1 &' 
     printf,1,'nohup ./autocv_'+exe_suffix_195+' -r5 -w1 -m '+A_outfile_195+' -i x_'+exe_suffix_195+'_acv'+' -o x_'+exe_suffix_195+'_acv > '+'termout_acv_'+A_outfile_195+' 2>&1 &' 
     printf,1,'nohup ./autocv_'+exe_suffix_284+' -r5 -w1 -m '+A_outfile_284+' -i x_'+exe_suffix_284+'_acv'+' -o x_'+exe_suffix_284+'_acv > '+'termout_acv_'+A_outfile_284+' 2>&1 &' 
     printf,1
     printf,1,'grep "function" '+'termout_acv_'+A_outfile_171
     printf,1,'grep "function" '+'termout_acv_'+A_outfile_195
     printf,1,'grep "function" '+'termout_acv_'+A_outfile_284

     close,1
  endif


  if instrBUILD eq 'AIABUILD' then begin

     A_outfile_094 = 'aia.094.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
     A_outfile_131 = 'aia.131.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
     A_outfile_171 = 'aia.171.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
     A_outfile_193 = 'aia.193.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
     A_outfile_211 = 'aia.211.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
     A_outfile_335 = 'aia.335.'+file_suffix+'_Rmin'+Rmin_str+'_Rmax'+Rmax_str+'_IRmax'+IRmax_str+'_'+Nr_str+'x'+Nth_str+'x'+Nph_str+'_BF'+BF_str
     X_infile      = 'x_zero_'+nr_str+'_'+nth_str+'_'+nph_str
     X_outfile_094 = 'x_'+A_outfile_094+'_L'+reg_str
     X_outfile_131 = 'x_'+A_outfile_131+'_L'+reg_str
     X_outfile_171 = 'x_'+A_outfile_171+'_L'+reg_str
     X_outfile_193 = 'x_'+A_outfile_193+'_L'+reg_str
     X_outfile_211 = 'x_'+A_outfile_211+'_L'+reg_str
     X_outfile_335 = 'x_'+A_outfile_335+'_L'+reg_str
    
     exe_suffix_094 = 'aia.094.'+exe_suffix
     exe_suffix_131 = 'aia.131.'+exe_suffix
     exe_suffix_171 = 'aia.171.'+exe_suffix
     exe_suffix_193 = 'aia.193.'+exe_suffix
     exe_suffix_211 = 'aia.211.'+exe_suffix
     exe_suffix_335 = 'aia.335.'+exe_suffix

     filename = basedir + filename
     openw,1, filename
     printf,1
     printf,1,'e buildA_params.h'
     printf,1,'editar en Sección '+instrBUILD+':'
     printf,1,'-------------------------------------------------------------------------------------'
     printf,1,'Rmin, Rmax, DRAD, NRAD =',rmin,rmax,drad,nr
     printf,1,'INST_RMAX              =',Irmax
     printf,1,'INNER_REJECT_RAD       =',INNER_REJECT_RAD
     printf,1,'OUTER_REJECT_RAD       =',OUTER_REJECT_RAD
     printf,1,'NTHETA, DTHETA         =',Nth,dth 
     printf,1,'BF                     =',BF
     printf,1,'--------------------------------------------------------------------------------------'
     printf,1,'#define DATADIR    TOMROOT "'+dirlist+'"'
     printf,1,'#define CONFSTRING DATADIR "'+list+'"' 
     printf,1,'#define A_OUTFILE "'+A_outfile_094+'"' 
     printf,1,'#define A_OUTFILE "'+A_outfile_131+'"' 
     printf,1,'#define A_OUTFILE "'+A_outfile_171+'"' 
     printf,1,'#define A_OUTFILE "'+A_outfile_193+'"' 
     printf,1,'#define A_OUTFILE "'+A_outfile_211+'"' 
     printf,1,'#define A_OUTFILE "'+A_outfile_335+'"' 
     printf,1
     printf,1,'e solve_cv_params.h'
     printf,1,'editar'
     printf,1,'#define FILESTR1 "r3_'+nr_str+'_'+nth_str+'_'+nph_str

     printf,1
     printf,1,'make clean'
     printf,1,'make builda'
     printf,1,'make callsolve_cg' 
     printf,1,'make auto_cv_brent'
     printf,1,'cp builda ba_'           +exe_suffix_094
     printf,1,'cp callsolve_cg cs_'     +exe_suffix_094
     printf,1,'cp auto_cv_brent autocv_'+exe_suffix_094
     printf,1
     printf,1,'make clean'
     printf,1,'make builda'
     printf,1,'make callsolve_cg' 
     printf,1,'make auto_cv_brent'
     printf,1,'cp builda ba_'           +exe_suffix_131
     printf,1,'cp callsolve_cg cs_'     +exe_suffix_131
     printf,1,'cp auto_cv_brent autocv_'+exe_suffix_131
     printf,1
     printf,1,'make clean'
     printf,1,'make builda'
     printf,1,'make callsolve_cg' 
     printf,1,'make auto_cv_brent'
     printf,1,'cp builda ba_'           +exe_suffix_171
     printf,1,'cp callsolve_cg cs_'     +exe_suffix_171
     printf,1,'cp auto_cv_brent autocv_'+exe_suffix_171
     printf,1
     printf,1,'make clean'
     printf,1,'make builda'
     printf,1,'make callsolve_cg' 
     printf,1,'make auto_cv_brent'
     printf,1,'cp builda ba_'           +exe_suffix_193
     printf,1,'cp callsolve_cg cs_'     +exe_suffix_193
     printf,1,'cp auto_cv_brent autocv_'+exe_suffix_193
     printf,1
     printf,1,'make clean'
     printf,1,'make builda'
     printf,1,'make callsolve_cg' 
     printf,1,'make auto_cv_brent'
     printf,1,'cp builda ba_'           +exe_suffix_211
     printf,1,'cp callsolve_cg cs_'     +exe_suffix_211
     printf,1,'cp auto_cv_brent autocv_'+exe_suffix_211
     printf,1
     printf,1,'make clean'
     printf,1,'make builda'
     printf,1,'make callsolve_cg' 
     printf,1,'make auto_cv_brent'
     printf,1,'cp builda ba_'           +exe_suffix_335
     printf,1,'cp callsolve_cg cs_'     +exe_suffix_335
     printf,1,'cp auto_cv_brent autocv_'+exe_suffix_335
   
          

     printf,1
     printf,1,'nohup ./ba_'+exe_suffix_094+' > '+'termout_bA_'+A_outfile_094+' 2>&1 &' 
     printf,1,'nohup ./ba_'+exe_suffix_131+' > '+'termout_bA_'+A_outfile_131+' 2>&1 &' 
     printf,1,'nohup ./ba_'+exe_suffix_171+' > '+'termout_bA_'+A_outfile_171+' 2>&1 &' 
     printf,1,'nohup ./ba_'+exe_suffix_193+' > '+'termout_bA_'+A_outfile_193+' 2>&1 &' 
     printf,1,'nohup ./ba_'+exe_suffix_211+' > '+'termout_bA_'+A_outfile_211+' 2>&1 &' 
     printf,1,'nohup ./ba_'+exe_suffix_335+' > '+'termout_bA_'+A_outfile_335+' 2>&1 &' 
     
     printf,1
     printf,1,'nohup ./cs_'+exe_suffix_094+' '+X_infile+' '+x_outfile_094+' '+A_outfile_094+' '+reg_str+' > '+'termout_cs_'+A_outfile_094+'_L'+reg_str+' 2>&1 &'
     printf,1,'nohup ./cs_'+exe_suffix_131+' '+X_infile+' '+x_outfile_131+' '+A_outfile_131+' '+reg_str+' > '+'termout_cs_'+A_outfile_131+'_L'+reg_str+' 2>&1 &'
     printf,1,'nohup ./cs_'+exe_suffix_171+' '+X_infile+' '+x_outfile_171+' '+A_outfile_171+' '+reg_str+' > '+'termout_cs_'+A_outfile_171+'_L'+reg_str+' 2>&1 &'
     printf,1,'nohup ./cs_'+exe_suffix_193+' '+X_infile+' '+x_outfile_193+' '+A_outfile_193+' '+reg_str+' > '+'termout_cs_'+A_outfile_193+'_L'+reg_str+' 2>&1 &'
     printf,1,'nohup ./cs_'+exe_suffix_211+' '+X_infile+' '+x_outfile_211+' '+A_outfile_211+' '+reg_str+' > '+'termout_cs_'+A_outfile_211+'_L'+reg_str+' 2>&1 &'
     printf,1,'nohup ./cs_'+exe_suffix_335+' '+X_infile+' '+x_outfile_335+' '+A_outfile_335+' '+reg_str+' > '+'termout_cs_'+A_outfile_335+'_L'+reg_str+' 2>&1 &'
     
     printf,1
     printf,1,'cd /media/Data1/data1/tomography/bindata/'
     printf,1,'cp x_'+A_outfile_094+'_L'+reg_str+' x_'+exe_suffix_094+'_acv'
     printf,1,'cd /data1/tomography/SolarTom_GRUPO_torre1/'
     printf,1
     printf,1,'cd /media/Data1/data1/tomography/bindata/'
     printf,1,'cp x_'+A_outfile_131+'_L'+reg_str+' x_'+exe_suffix_131+'_acv'
     printf,1,'cd /data1/tomography/SolarTom_GRUPO_torre1/'
     printf,1
     printf,1,'cd /media/Data1/data1/tomography/bindata/'
     printf,1,'cp x_'+A_outfile_171+'_L'+reg_str+' x_'+exe_suffix_171+'_acv'
     printf,1,'cd /data1/tomography/SolarTom_GRUPO_torre1/'
     printf,1
     printf,1,'cd /media/Data1/data1/tomography/bindata/'
     printf,1,'cp x_'+A_outfile_193+'_L'+reg_str+' x_'+exe_suffix_193+'_acv'
     printf,1,'cd /data1/tomography/SolarTom_GRUPO_torre1/'
     printf,1
     printf,1,'cd /media/Data1/data1/tomography/bindata/'
     printf,1,'cp x_'+A_outfile_211+'_L'+reg_str+' x_'+exe_suffix_211+'_acv'
     printf,1,'cd /data1/tomography/SolarTom_GRUPO_torre1/'
     printf,1
     printf,1,'cd /media/Data1/data1/tomography/bindata/'
     printf,1,'cp x_'+A_outfile_335+'_L'+reg_str+' x_'+exe_suffix_335+'_acv'
     printf,1,'cd /data1/tomography/SolarTom_GRUPO_torre1/'
 
 

     printf,1
     printf,1,'nohup ./autocv_'+exe_suffix_094+' -r5 -w1 -m '+A_outfile_094+' -i x_'+exe_suffix_094+'_acv'+' -o x_'+exe_suffix_094+'_acv > '+'termout_acv_'+A_outfile_094+' 2>&1 &' 
     printf,1,'nohup ./autocv_'+exe_suffix_131+' -r5 -w1 -m '+A_outfile_131+' -i x_'+exe_suffix_131+'_acv'+' -o x_'+exe_suffix_131+'_acv > '+'termout_acv_'+A_outfile_131+' 2>&1 &' 
     printf,1,'nohup ./autocv_'+exe_suffix_171+' -r5 -w1 -m '+A_outfile_171+' -i x_'+exe_suffix_171+'_acv'+' -o x_'+exe_suffix_171+'_acv > '+'termout_acv_'+A_outfile_171+' 2>&1 &' 
     printf,1,'nohup ./autocv_'+exe_suffix_193+' -r5 -w1 -m '+A_outfile_193+' -i x_'+exe_suffix_193+'_acv'+' -o x_'+exe_suffix_193+'_acv > '+'termout_acv_'+A_outfile_193+' 2>&1 &' 
     printf,1,'nohup ./autocv_'+exe_suffix_211+' -r5 -w1 -m '+A_outfile_211+' -i x_'+exe_suffix_211+'_acv'+' -o x_'+exe_suffix_211+'_acv > '+'termout_acv_'+A_outfile_211+' 2>&1 &' 
     printf,1,'nohup ./autocv_'+exe_suffix_335+' -r5 -w1 -m '+A_outfile_335+' -i x_'+exe_suffix_335+'_acv'+' -o x_'+exe_suffix_335+'_acv > '+'termout_acv_'+A_outfile_335+' 2>&1 &' 
     printf,1
     printf,1,'grep "function" '+'termout_acv_'+A_outfile_094
     printf,1,'grep "function" '+'termout_acv_'+A_outfile_131
     printf,1,'grep "function" '+'termout_acv_'+A_outfile_171
     printf,1,'grep "function" '+'termout_acv_'+A_outfile_193
     printf,1,'grep "function" '+'termout_acv_'+A_outfile_211
     printf,1,'grep "function" '+'termout_acv_'+A_outfile_335

     close,1
  endif



  return
end

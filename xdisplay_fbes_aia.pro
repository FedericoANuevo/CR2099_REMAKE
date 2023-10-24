; This script allows display lat-lon maps of FBEs from AIA data with
; different regularization parameter values

pro xdisplay_fbes_aia
;++++++++++++++++++++++++++++++
; reg_string = '_L1.0'
  reg_string = '_Lopt' 
;+++++++++++++++++++++++++++++
  
; Path to use x-tools in SolarTom_idl  
  !PATH = Expand_Path('+/data1/tomography/SolarTom_idl') + ':' + !PATH
  
; Graph settings
  clrtbl=34

; Instrumental rmin and rmax
  Irmin =  1.02
  Irmax =  1.25

; Grid settings
  rmin = 1.0
  rmax = 1.3
  nr   = 30
  nt   = 90
  np   = 2*nt
; Radial grid 
  dr = (rmax-rmin)/nr
  r  = rmin + dr*findgen(Nr) +dr/2
  irad = where ( r ge Irmin and r le Irmax)


; Root directory
; root_dir='/media/Data1/data1/'
  root_dir='/data1/'  
; FBE directory:
  FBEdir = root_dir+'tomography/bindata/'
; FBES files:
  if reg_string ne '_Lopt' then begin
     datafiles= ['x_aia.094.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4',$
                 'x_aia.131.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4',$
                 'x_aia.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4',$
                 'x_aia.193.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4',$
                 'x_aia.211.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4',$
                 'x_aia.335.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4']+reg_string
  endif else begin
     datafiles= ['x_aia.094.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.52',$
                 'x_aia.131.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.39',$
                 'x_aia.171.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.63',$
                 'x_aia.193.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.37',$
                 'x_aia.211.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.5' ,$
                 'x_aia.335.CR2099_hollow_NEW_Rmin1.00_Rmax1.30_IRmax1.25_30x90x180_BF4_L0.38']
  endelse
  
  
    
; sample heights to plot
  r0A=[1.105]

; Read the FBE data-cube
  xread,file=datafiles(0),nr=nr,nt=nt,np=np,map=x094 
  xread,file=datafiles(1),nr=nr,nt=nt,np=np,map=x131
  xread,file=datafiles(2),nr=nr,nt=nt,np=np,map=x171
  xread,file=datafiles(3),nr=nr,nt=nt,np=np,map=x193
  xread,file=datafiles(4),nr=nr,nt=nt,np=np,map=x211
  xread,file=datafiles(5),nr=nr,nt=nt,np=np,map=x335
  
  
; Check ZDAs
  tmp = x094(irad,*,*) & p = where (tmp le 0.)
  if p(0) ne -1 then print,'ZDAs in 094 A:',float(n_elements(p))/n_elements(tmp) 
  tmp = x131(irad,*,*) & p = where (tmp le 0.)
  if p(0) ne -1 then print,'ZDAs in 131 A:',float(n_elements(p))/n_elements(tmp) 
  tmp = x171(irad,*,*) & p = where (tmp le 0.)
  if p(0) ne -1 then print,'ZDAs in 171 A:',float(n_elements(p))/n_elements(tmp) 
  tmp = x193(irad,*,*) & p = where (tmp le 0.)
  if p(0) ne -1 then print,'ZDAs in 193 A:',float(n_elements(p))/n_elements(tmp) 
  tmp = x211(irad,*,*) & p = where (tmp le 0.)
  if p(0) ne -1 then print,'ZDAs in 211 A:',float(n_elements(p))/n_elements(tmp) 
  tmp = x335(irad,*,*) & p = where (tmp le 0.)
  if p(0) ne -1 then print,'ZDAs in 335 A:',float(n_elements(p))/n_elements(tmp) 

  xdisplay,map=x094,clrtbl=clrtbl,$
           file='x094_CR2099'+reg_string,nr=nr,nt=nt,rmin=rmin,rmax=rmax,$
           r0A=r0A,win=2,titulo='FBE 094 A'+reg_string,minS=minS,maxS=maxS,/add_bw
  
  xdisplay,map=x131,clrtbl=clrtbl,$
           file='x131_CR2099'+reg_string,nr=nr,nt=nt,rmin=rmin,rmax=rmax,$
           r0A=r0A,win=2,titulo='FBE 131 A'+reg_string,minS=minS,maxS=maxS,/add_bw

  xdisplay,map=x171,clrtbl=clrtbl,$
           file='x171_CR2099'+reg_string,nr=nr,nt=nt,rmin=rmin,rmax=rmax,$
           r0A=r0A,win=2,titulo='FBE 171 A'+reg_string,minS=minS,maxS=maxS,/add_bw

  xdisplay,map=x193,clrtbl=clrtbl,$
           file='x193_CR2099'+reg_string,nr=nr,nt=nt,rmin=rmin,rmax=rmax,$
           r0A=r0A,win=2,titulo='FBE 193 A'+reg_string,minS=minS,maxS=maxS,/add_bw

  xdisplay,map=x211,clrtbl=clrtbl,$
           file='x211_CR2099'+reg_string,nr=nr,nt=nt,rmin=rmin,rmax=rmax,$
           r0A=r0A,win=2,titulo='FBE 211 A'+reg_string,minS=minS,maxS=maxS,/add_bw

  xdisplay,map=x335,clrtbl=clrtbl,$
           file='x335_CR2099'+reg_string,nr=nr,nt=nt,rmin=rmin,rmax=rmax,$
           r0A=r0A,win=2,titulo='FBE 335 A'+reg_string,minS=minS,maxS=maxS,/add_bw

   
  return
end

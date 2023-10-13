pro xdisplay_filter_ratio



; Path to use x-tools in SolarTom_idl  
  !PATH = Expand_Path('+/data1/tomography/SolarTom_idl') + ':' + !PATH
  
; Instrumental rmin and rmax
  Irmin =  1.02
  Irmax =  1.25

; Grid settings
  rmin = 1.0
  rmax = 1.3
  nr   = 30
  nt   = 90
  np   = 2*nt


  dirDEM   = '/data1/DATA/ldem_files/' 
  file_Ne  = 'Ne_ratio_CR2099_AIA171-193A.dat'
  file_Te  = 'Te_ratio_CR2099_AIA171-193A.dat'

  suffix='_CR2099_AIA'

; Read the data-cube
  xread,file=file_Ne,nr=nr,nt=nt,np=np,map=Ne_ratio,dir=dirDEM 
  xread,file=file_Te,nr=nr,nt=nt,np=np,map=Te_ratio,dir=dirDEM

  r0A     = [1.025,1.105,1.245]  
  minA_Ne = (r0A*0.+1.E-6)
  maxA_Ne = [3.5  ,2.5  ,1.5 ]
  minA_Te = r0A*0. + 0.5
  maxA_Te = r0A*0  + 2.5 

  
  xdisplay,map=Ne_ratio,file='Ne_ratio'+suffix,nr=nr,nt=nt,rmin=rmin,rmax=rmax,r0A=r0A,clrtbl= 25,titulo='Ne [10!U8!Ncm!U-3!N]' ,units=1.e8, minA=minA_Ne,$
           maxA=maxA_Ne,/add_bw
  xdisplay,map=Te_ratio,file='Te_ratio'+suffix,nr=nr,nt=nt,rmin=rmin,rmax=rmax,r0A=r0A,clrtbl= 25,titulo='Tm [MK]'              ,units=1.e6, minA=minA_Te,$
           maxA=maxA_Te,/add_bw
  





  return
end

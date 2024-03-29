      program digest
*      
* Read in Guinea-PIG lumi.ee.out "data" files and 
* fill histograms for luminosity spectrum studies
* using reweighting fit
*
      implicit none
      include 'hinit.f'
      integer i,lun
      parameter (lun = 25)
* Use imode to control which configuration we run (see redo.sh script too).
      include 'imode.f'
      logical lsmear
      parameter (lsmear=.true.)
      double precision x1,x2,x,y,z,x1p,y1p,x2p,y2p
      double precision x1o,x2o
      double precision s1,s2
      double precision hsqrtso
      parameter (s2=0.152d-2, s1=0.190d-2)
      double precision rg1,rg2
      double precision Ebeam
      parameter (Ebeam = 125.0d0)
      integer spin(6)
      integer itime,iorder
      
      call hlimit(nwpawc)
      call bookh
      
      open(lun,file='lumi.ee.out',status='old')

* Loop line by line until end of file      
  10  continue
      read(lun,*,end=999)x1,x2,x,y,z,itime,x1p,y1p,x2p,y2p,spin,iorder
      if(iorder.le.10)then
         print *,x1,x2,x,y,z,itime,x1p,y1p,x2p,y2p,spin,iorder
      endif
      
      x1o = x1
      x2o = x2
      hsqrtso = sqrt(x1o*x2o)
      
      if(lsmear)then
          call getgauss(rg1,rg2)
          x1 = x1 + s1*rg1*Ebeam
          x2 = x2 + s2*rg2*Ebeam
      endif 
      
* Compute scaled energies using nominal beam energy
      x1 = x1/Ebeam
      x2 = x2/Ebeam
      if(imode.eq.0)then
         call myfill(x1,x2,z,hsqrtso)
         call hfill(301,real(z),0.0,1.0)
         call hfill(302,real(abs(z)),0.0,1.0)
         call hfill(303,real(abs(z)),0.0,1.0)
         call hfill(304,real(abs(z)),0.0,1.0)                            
      elseif(imode.eq.1.and.z.ge.0.0d0)then
         call myfill(x1,x2,z,hsqrtso)
      elseif(imode.eq.-1.and.z.lt.0.0d0)then
         call myfill(x1,x2,z,hsqrtso)
      elseif(imode.eq.3.and.abs(z).ge.140.6675d0)then
         call myfill(x1,x2,z,hsqrtso)
      elseif(imode.eq.4.and.abs(z).lt.140.6675d0)then
         call myfill(x1,x2,z,hsqrtso)               
      endif    
      goto 10
      
 999  continue     
      close(lun)
      
      call hprint(107)
      call hprint(108)
      
      call hrput(0,'gplumi.hbook','NT')
      
* Move file-handling to shell script
*      if(imode.eq.0)then
*         call hrput(0,'gplumi.hbook','NT')
*      elseif(imode.eq.1)then
*         call hrput(0,'gplumi-pluszv.hbook','NT')
*      elseif(imode.eq.-1)then
*         call hrput(0,'gplumi-minuszv.hbook','NT')
*      elseif(imode.eq.3)then
*         call hrput(0,'gplumi-bigzv.hbook','NT')
*      elseif(imode.eq.4)then
*         call hrput(0,'gplumi-smallzv.hbook','NT')
*      else
*         print *,'SHOULD NOT HAPPEN! '
*      endif
      
      end
      
      subroutine myfill(x1,x2,z,hsqrtso)
* FIXME - make more amenable to alternative numbers of bins
      implicit none
      double precision x1,x2,z
      double precision hsqrtso
      integer ibin1,ibin2,icomb
      integer findbinx1,findbinx2
      double precision Ebeam
      parameter (Ebeam = 125.0d0)      
      
      ibin1 = findbinx1(x1)
      ibin2 = findbinx2(x2)
      icomb = 100*(ibin1-1) + ibin2
      
      call hfill(101,real(x1),0.0,1.0)
      call hfill(102,real(x2),0.0,1.0)
      call hfill(103,real(sqrt(x1*x2)),0.0,1.0)
      call hfill(104,real(abs(x1-x2)),0.0,1.0)
      call hfill(106,real(x1-x2),0.0,1.0)
      call hfill(107,real(ibin1),0.0,1.0)
      call hfill(108,real(ibin2),0.0,1.0)
      call hfill(109,real(ibin1),real(ibin2),1.0)
      call hfill(111,real(icomb),0.0,1.0)
      
      call hfill(29,real(Ebeam*x1),0.0,1.0)
      call hfill(30,real(Ebeam*x2),0.0,1.0)
      call hfill(31,real(Ebeam*x1),real(Ebeam*x2),1.0)
      
      if(hsqrtso/ebeam.lt.0.9999996d0)then
         call hfill(429,real(Ebeam*x1),0.0,1.0)
         call hfill(430,real(Ebeam*x2),0.0,1.0)
         call hfill(401,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)
         call hfill(402,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)         
      else
         call hfill(529,real(Ebeam*x1),0.0,1.0)
         call hfill(530,real(Ebeam*x2),0.0,1.0)
         call hfill(501,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)      
         call hfill(502,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)         
      endif
      
      call hfill(32,real(z),real(Ebeam*x1),1.0)
      call hfill(33,real(z),real(Ebeam*x2),1.0)
      call hfill(1,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)
      call hfill(2,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0) 
      call hfill(3,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)
      call hfill(4,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)
      call hfill(5,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)
      call hfill(6,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)
      call hfill(7,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0) 
      call hfill(8,real(2.0*Ebeam*sqrt(x1*x2)),0.0,1.0)                          
      
      if(z.lt.0.0d0)then
          call hfill(41,real(Ebeam*x1),0.0,1.0)
          call hfill(43,real(Ebeam*x2),0.0,1.0)
      else
          call hfill(42,real(Ebeam*x1),0.0,1.0)
          call hfill(44,real(Ebeam*x2),0.0,1.0)
      endif          
          
      
      end
      include 'bookh.f'      
      include 'findbin.f'
      include 'getgauss.f'

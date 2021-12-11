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
      
      double precision x1,x2,x,y,z,x1p,y1p,x2p,y2p
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
* Compute scaled energies using nominal beam energy
      x1 = x1/Ebeam
      x2 = x2/Ebeam
      if(imode.eq.0)then
         call myfill(x1,x2)
         call hfill(301,real(z),0.0,1.0)
         call hfill(302,real(abs(z)),0.0,1.0)
         call hfill(303,real(abs(z)),0.0,1.0)                  
      elseif(imode.eq.1.and.z.ge.0.0d0)then
         call myfill(x1,x2)
      elseif(imode.eq.-1.and.z.lt.0.0d0)then
         call myfill(x1,x2)
      endif    
      goto 10
      
 999  continue     
      close(lun)
      
      call hprint(107)
      call hprint(108)
      
      if(imode.eq.0)then
         call hrput(0,'gplumi-Run5.hbook','NT')
      elseif(imode.eq.1)then
         call hrput(0,'gplumi-Run5-pluszv.hbook','NT')
      elseif(imode.eq.-1)then
         call hrput(0,'gplumi-Run5-minuszv.hbook','NT')
      else
         print *,'SHOULD NOT HAPPEN! '
      endif
      
      end
      
      subroutine myfill(x1,x2)
* FIXME - make more amenable to alternative numbers of bins
      implicit none
      double precision x1,x2
      integer ibin1,ibin2,icomb
      integer findbinx1,findbinx2
      
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
      
      end
      include 'bookh.f'      
      include 'findbin.f'

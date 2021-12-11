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
      call myfill(x1,x2)
      goto 10
      
 999  continue     
      close(lun)
      
      call hprint(107)
      call hprint(108)
      call hrput(0,'gplumi-Run5.hbook','NT')      
      
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

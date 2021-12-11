      subroutine bookh
      implicit none
*
* Define all the same "data" histograms as in the reweighting tests
* Not all will necessarily be filled.
* The ones based on regions are not really definable for GP files 
* with both BES and beamstrahlung, so are commented out.
*
      
      call hidopt(0,'stat')
      
      call hbook1(101,'x1 ',1101,-0.0005,1.1005,0.0)
      call hbook1(102,'x2 ',1101,-0.0005,1.1005,0.0)
      call hbook1(103,'sqrt(x1*x2)',1101,-0.0005,1.1005,0.0)      
      call hbook1(104,'|x1-x2|',1100,0.000,1.100,0.0)
*      call hbook1(105,'Type ',4,0.5,4.5,0.0)
      call hbook1(106,'x1-x2',2200,-1.100,1.100,0.0)
      call hbook1(107,'x1 bin',100,0.5,100.5,0.0)
      call hbook1(108,'x2 bin',100,0.5,100.5,0.0)
      call hbook2(109,'(x1,x2) bin',20,0.5,100.5,20,0.5,100.5,0.0)
      call hbook1(110,'(x1,x2) bin 1d',400,0.5,400.5,0.0)
      call hbook1(111,'icomb bin',10000,0.5,10000.5,0.0)

*      call hbook1(211,'x1 R1',1101,-0.0005,1.1005,0.0)
*      call hbook1(212,'x2 R1',1101,-0.0005,1.1005,0.0)
*      call hbook1(221,'x1 R2',1101,-0.0005,1.1005,0.0)
*      call hbook1(222,'x2 R2',1101,-0.0005,1.1005,0.0)
*      call hbook1(231,'x1 R3',1101,-0.0005,1.1005,0.0)
*      call hbook1(232,'x2 R3',1101,-0.0005,1.1005,0.0)
*      call hbook1(241,'x1 R4',1101,-0.0005,1.1005,0.0)
*      call hbook1(242,'x2 R4',1101,-0.0005,1.1005,0.0)
              
      end

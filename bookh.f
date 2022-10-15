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

      call hbook1(301,'zPV (microns)',2000,-1000.0,1000.0,0.0)
      call hbook1(302,'|zPV| (microns)',2000,0.0,1000.0,0.0)
      call hbook1(303,'|zPV| (microns)',2000,0.0,200.0,0.0)
* This is for fine-tuning the observed |zPV| median value      
      call hbook1(304,'|zPV| (microns)',100,140.6,140.7,0.0)
      
* Choose same binning as in Analysis.C
      call hbook1(1,'CoM Energy',2048,220.0,271.2,0.0)
      call hbook1(29,'Electron Energy',256,120.0,126.4,0.0)
      call hbook1(30,'Positron Energy',256,120.0,126.4,0.0)
      call hbook2(31,'AfterBS E+ vs E-',300,120.0,126.0,
     +            300,120.0,126.0,0.0);
      call hbook2(32,'E- vs z',320,-800.0,800.0,300,
     +            120.0,126.0,0.0)
      call hbook2(33,'E+ vs z',320,-800.0,800.0,300,
     +            120.0,126.0,0.0)

      call hbook1(41,'E- ',70,122.5,126.0,0.0)
      call hbook1(42,'E- ',70,122.5,126.0,0.0)
      call hbook1(43,'E+ ',70,122.5,126.0,0.0)
      call hbook1(44,'E+ ',70,122.5,126.0,0.0)
               
                        
      end

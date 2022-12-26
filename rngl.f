      subroutine rngl (r)
* RANLUX based implementation      
      implicit none
      integer len 
      parameter (len=1000)
      real rvec(len)
      double precision r
      include 'seeds.f'
      integer ivalue
      data ivalue/-1/
      save ivalue
      save rvec
      
*      print *,'ivalue = ',ivalue
      
* RNG initialization
      if(ivalue.eq.-1)then
         call rluxgo(3,seedl,0,0)
      endif
      
* RNG array filling/replenishment and array index reset      
      if(ivalue.eq.-1.or.ivalue.gt.len)then
         call ranlux(rvec,len)
         ivalue = 1
      endif
      
      r = dble(rvec(ivalue))     
*      print *,'r = ',r
      
* Set to next random number in array
      ivalue = ivalue + 1
      
      end

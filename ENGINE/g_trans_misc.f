      subroutine g_trans_misc(abort,errmsg)
*-------------------------------------------------------------------
* author: John Arrington
* created: 1/16/96
*
* g_trans_misc fills the gen_decoded_misc common block
*
* $Log$
* Revision 1.2.24.1  2007/10/17 15:52:29  cdaq
* *** empty log message ***
*
* Revision 1.2  2002/09/25 14:37:32  jones
* character*1024 errmsg changed to character*(*) errmsgCVS: ----------------------------------------------------------------------
*
* Revision 1.1  1996/01/22 15:14:10  saw
* Initial revision
*
*--------------------------------------------------------

      implicit none

      include 'gen_data_structures.cmn'

      logical abort
      character*(*) errmsg
      character*20 here
      parameter (here = 'g_trans_misc')

      integer*4 ihit

      save

      abort = .false.
      errmsg = ' '

      do ihit = 1 , gmax_misc_hits
        gmisc_dec_data(ihit,1) = 0     ! Clear TDC's
        gmisc_dec_data(ihit,2) = -1     ! Clear ADC's
      enddo
      
c      write(*,*) 'gmisc_tot_hits=',gmisc_tot_hits

      do ihit = 1 , gmisc_tot_hits
c$$$         if((gmisc_raw_addr2(ihit).eq.1.or.gmisc_raw_addr2(ihit).eq.2)
c$$$     $        .and. gmisc_raw_addr1(ihit).eq.2) then
c$$$            if(gmisc_raw_addr2(ihit).eq.1) then ! h+
c$$$               write(*,*) 'h+ hit, raw ADC=',gmisc_raw_data(ihit)
c$$$            endif
c$$$            if(gmisc_raw_addr2(ihit).eq.2) then ! h-
c$$$               write(*,*) 'h- hit, raw ADC=',gmisc_raw_data(ihit)
c$$$            endif
c$$$         endif

        gmisc_dec_data(gmisc_raw_addr2(ihit),gmisc_raw_addr1(ihit)) =
     $       gmisc_raw_data(ihit)
      enddo

      return
      end

      subroutine c_register_variables(ABORT,err)
*----------------------------------------------------------------------
*
*     CTP variable registration routine for coincidences
*
*     Purpose : Register all variables that are to be used by CTP, that are
*     connected with the coincidence calculations.  This includes
*     externally configured parameters/contants, event data that can be a
*     histogram source, and possible test results and scalers.
*
*     Output: ABORT      - success or failure
*           : err        - reason for failure, if any
*
*     Created: 9-Feb-1994  Stephen A. Wood
*     $Log$
*     Revision 1.6  1994/08/18 04:11:57  cdaq
*     (SAW) Call makereg generated routines to register variables
*
* Revision 1.5  1994/06/17  03:19:44  cdaq
* (KBB) Execute all code despite registration errors
*
* Revision 1.4  1994/06/16  03:41:41  cdaq
* (SAW) Register filenames for reports
*
* Revision 1.3  1994/06/14  03:19:03  cdaq
* (DFG) register target and beam variables
*
* Revision 1.2  1994/04/12  17:13:37  cdaq
* (KBB) Add ntuple call
*
* Revision 1.1  1994/02/11  18:32:18  cdaq
* Initial revision
*
*----------------------------------------------------------------------
      implicit none

      save
*
      character*20 here
      parameter (here='c_register_variables')
*
      logical ABORT
      character*(*) err
*
      integer*4 ierr
      logical FAIL
      character*1000 why
*..................................................................
*
      ABORT = .false.
      err= ' '

      call r_coin_filenames

      IF(ABORT) THEN
        call G_prepend(':unable to register',err)
      ENDIF
*
      call c_ntuple_register(FAIL,why)
      IF(err.NE.' ' .and. why.NE.' ') THEN
        call G_append(err,' & '//why)
      ELSEIF(why.NE.' ') THEN
        err= why
      ENDIF
      ABORT= ABORT .or. FAIL
*
      if(ABORT .or. err.NE.' ') call g_add_path(here,err)
*
      return
      end

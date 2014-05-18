program run_test
    use, intrinsic :: iso_fortran_env
    use pggrid_def
    use pggrid_lib
    
    character(len=256) :: inlist_name
    integer :: ierr
    
    if (command_argument_count() < 1) then
        call show_help
    end if
    
    call get_command_argument(1,value=inlist_name,status=ierr)
    if (ierr /= 0 .or. len_trim(inlist_name) == 0) then
        call show_help
    end if
    
    call load_pggrid_controls(inlist_name, ierr)

    if (ierr == 0) then    
        call make_pggrid_plot(ierr)
    end if
    
contains
    subroutine show_help()
        use, intrinsic :: iso_fortran_env, only: error_unit
        character(len=256) :: prog_name
        call get_command_argument(0,prog_name)
        write(error_unit,*) 'usage: '//trim(prog_name)//' <name of inlist file>'
        stop
    end subroutine show_help
end program run_test

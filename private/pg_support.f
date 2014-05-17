module pg_support
    use pggrid_def
    logical :: have_initialized_pg = .FALSE.
    
contains
    
    subroutine pg_clear(p)
        type(pg_data), pointer :: p
        if (have_initialized_pg) return
        p% id_win = 0
    end subroutine pg_clear
    
    subroutine do_open(p, ierr)
        type(pg_data), pointer :: p
        integer, intent(out) :: ierr
        character(len=256) :: name
        
        ierr = 0
        if (p% win_flag) call open_device(p,.FALSE.,'/xwin',p% id_win,ierr)
        if (failed('/xwin')) return
        if (p% file_flag) then
            call create_file_name(p% file_dir, p% file_prefix,  &
            &   p% file_extension, name)
            write (*,*) trim(name)
            name = trim(name) // '/' // trim(p% file_device)
            call open_device(p,.TRUE.,name,p% id_file, ierr)
            if (failed(name)) return
        end if
        
        have_initialized_pg = .TRUE.
    contains
        function failed(str)
            use, intrinsic:: iso_fortran_env, only: error_unit
           character (len=*), intent(in) :: str
           logical :: failed
           
           failed = (ierr /= 0)
           if (failed) then
              write(*, *) trim(str) // ' ierr', ierr
           end if
        end function failed
        
    end subroutine do_open

    subroutine create_file_name(dir, prefix, extension, name)
        use, intrinsic :: iso_fortran_env, only : error_unit
        character(len=*), intent(in) :: dir, prefix, extension
        character(len=*), intent(out) :: name
        
        if (len_trim(dir) > 0) then
            name = trim(dir) // '/' // trim(prefix)
        else
            name = prefix
        end if
        name = trim(name) // '.' // trim(extension)
    end subroutine create_file_name

    subroutine open_device(p, is_file, dev, id, ierr)
        use, intrinsic :: iso_fortran_env, only : error_unit
        type(pg_data), pointer :: p
        logical, intent(in) :: is_file
        character(len=*), intent(in) :: dev
        integer, intent(out) :: id
        integer, intent(out) :: ierr
        real :: width, ratio
        integer :: pgopen

        id = pgopen(trim(dev))
        if (id <= 0) then
            write(error_unit,*) 'PGPLOT failed to open '//trim(dev)
            ierr = -1
            return
        end if

        if (is_file) then
            width = p% file_width; if (width < 0) width = p% win_width
            ratio = p% file_aspect_ratio; if (ratio < 0)  &
            &   ratio = p% win_aspect_ratio
            call pgpap(width, ratio)
        else
            call pgpap(p% win_width, p% win_aspect_ratio)
        end if
    end subroutine open_device

end module pg_support

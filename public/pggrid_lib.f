module pggrid_lib
    use pggrid_def
    
contains
    
    subroutine load_pggrid_controls(filename,ierr)
        use pg_io, only: read_pggrid_controls
        character(len=*), intent(in) :: filename
        integer, intent(out) :: ierr
        type(pg_data), pointer :: p

        call get_pg_pointer(p)
        call read_pggrid_controls(p,filename,ierr)
    end subroutine load_pggrid_controls

    subroutine make_pggrid_plot(ierr)
        use, intrinsic :: iso_fortran_env, only: error_unit
        use pg_support
        integer, intent(out) :: ierr
        type(pg_data), pointer :: p
        real :: xleft, xright, ytop, ybottom
        
        ierr = 0
        call get_pg_pointer(p)
        call pg_clear(p)
        call do_open(p, ierr)
        
        xleft = p% grid_pad_left
        xright = 1.0-p% grid_pad_right
        ytop = 1.0-p% grid_pad_top
        ybottom = p% grid_pad_bottom
        
        if (xright < xleft .or. ytop < ybottom) then
            write (error_unit,*) 'malformed plt: left, right, top, bottom = ', &
            &   xleft, xright, ytop, ybottom
            ierr = -1
            return
        end if
        
        if (1.0-(xright-xleft) > p% max_fraction_padding .or.  &
        &   1.0-(ytop-ybottom) > p% max_fraction_padding) then
            write (error_unit,*) 'warning: padding around grid exceeds ', &
            &   p% max_fraction_padding
            write (error_unit,*) '    left, right, top, bottom = ', &
            &   xleft, xright, ytop, ybottom
            ! keep as a warning
            ierr = 0
        end if
        
        call do_grid(p,xleft,xright,ytop,ybottom)
        
        call pgclos
    end subroutine make_pggrid_plot
end module pggrid_lib

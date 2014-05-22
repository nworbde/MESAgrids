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

    subroutine make_pggrid_plot(which_plot,ierr)
        use, intrinsic :: iso_fortran_env, only: error_unit
        use pg_support
        use pg_plots
        character(len=*), intent(in) :: which_plot
        integer, intent(out) :: ierr
        type(pg_data), pointer :: p
        
        ierr = 0
        call get_pg_pointer(p)
        call pg_clear(p)
        
        call do_open(p, ierr)
        if (ierr /= 0) return
                
!         if (xright < xleft .or. ytop < ybottom) then
!             write (error_unit,*) 'malformed plt: left, right, top, bottom = ', &
!             &   xleft, xright, ytop, ybottom
!             ierr = -1
!             return
!         end if
        
!         if (1.0-(xright-xleft) > p% max_fraction_padding .or.  &
!         &   1.0-(ytop-ybottom) > p% max_fraction_padding) then
!             write (error_unit,*) 'warning: padding around grid exceeds ', &
!             &   p% max_fraction_padding
!             write (error_unit,*) '    left, right, top, bottom = ', &
!             &   xleft, xright, ytop, ybottom
!             ! keep as a warning
!             ierr = 0
!         end if

        select case(which_plot)
        case('Grid_plot')
            call do_grid(p,0.0,1.0,1.0,0.0,1.0)
        case('Legend_Plot')
            call do_lgdplt(p,0.0,1.0,1.0,0.0,1.0)
        case('Simple_Plot')
            call do_simplt(p,0.0,1.0,1.0,0.0,1.0)
        case('Box')
            call do_box(p,0.0,1.0,1.0,0.0,1.0)
        case('Box_with_Legend')
            call do_box_with_legend(p,0.0,1.0,1.0,0.0,1.0)
        case default
            write(error_unit,*) 'make_pggrid_plot: did not recognize plot_name'
        end select
        
        call pgclos
    end subroutine make_pggrid_plot
end module pggrid_lib

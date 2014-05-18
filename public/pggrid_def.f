module pggrid_def
    integer, parameter :: grid_max_num_cols = 12
    integer, parameter :: grid_max_num_rows = 12
    integer, parameter :: grid_max_plots = 9
    
    type pg_data
        include 'pggrid_controls.f'
    end type pg_data
    
    type(pg_data), target, save :: pg_info

    contains
        subroutine get_pg_pointer(p)
            type(pg_data), pointer, intent(out) ::  p
            p => pg_info
        end subroutine get_pg_pointer
end module pggrid_def

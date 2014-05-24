module pggrid_lib
    use pggrid_def
    
contains
    
    subroutine load_pggrid_controls(filename,ierr)
        use pg_io, only: read_pggrid_controls
        character(len=*), intent(in) :: filename
        integer, intent(out) :: ierr

        call read_pggrid_controls(filename,ierr)
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
        
        call print_pggrid_controls(p)
        
        select case(which_plot)
        case('Grid_Plot')
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

        call pgslct(p% device_id)
        call pgclos()
        
    end subroutine make_pggrid_plot
    
    subroutine print_pggrid_controls(p)
        type(pg_data), pointer :: p

        print *,'file_flag = ', p% file_flag
        print *,'file_dir = ', trim(p% file_dir)
        print *,'file_prefix = ', trim(p% file_prefix)
        print *,'file_device = ', trim(p% file_device)
        print *,'file_extension = ', trim(p% file_extension)
        print *,'file_width = ', p% file_width
        print *,'win_width = ', p% win_width
        print *,'file_aspect_ratio = ', p% file_aspect_ratio
        print *,'win_aspect_ratio = ', p% win_aspect_ratio
        print *,'max_fraction_padding = ', p% max_fraction_padding
        print *,'grid_num_cols = ', p% grid_num_cols
        print *,'grid_num_rows = ', p% grid_num_rows
        print *,'grid_num_plots = ', p% grid_num_plots
        print *,'grid_plot_names = ', p% grid_plot_names
        print *,'grid_plot_col = ', p% grid_plot_col
        print *,'grid_plot_colspan = ', p% grid_plot_colspan
        print *,'grid_plot_row = ', p% grid_plot_row
        print *,'grid_plot_rowspan = ', p% grid_plot_rowspan
        print *,'grid_col_offset_in_px = ', p% grid_col_offset_in_px
        print *,'grid_row_offset_in_px = ', p% grid_row_offset_in_px
        print *,'grid_left_margin = ', p% grid_left_margin
        print *,'grid_right_margin = ', p% grid_right_margin
        print *,'grid_top_margin = ', p% grid_top_margin
        print *,'grid_bottom_margin = ', p% grid_bottom_margin
        print *,'grid_subplot_text_scale = ', p% grid_subplot_text_scale
        print *,'simplt_left_margin = ', p% simplt_left_margin
        print *,'simplt_right_margin = ', p% simplt_right_margin
        print *,'simplt_top_margin = ', p% simplt_top_margin
        print *,'simplt_bottom_margin = ', p% simplt_bottom_margin
        print *,'simplt_pad_left_in_em = ', p% simplt_pad_left_in_em
        print *,'simplt_pad_right_in_em = ', p% simplt_pad_right_in_em
        print *,'simplt_pad_top_in_em = ', p% simplt_pad_top_in_em
        print *,'simplt_pad_bottom_in_em = ', p% simplt_pad_bottom_in_em
        print *,'simplt_char_size_in_px = ', p% simplt_char_size_in_px
        print *,'simplt_show_margin_box = ', p% simplt_show_margin_box
        print *,'lgdplt_left_margin = ', p% lgdplt_left_margin
        print *,'lgdplt_right_margin = ', p% lgdplt_right_margin
        print *,'lgdplt_top_margin = ', p% lgdplt_top_margin
        print *,'lgdplt_bottom_margin = ', p% lgdplt_bottom_margin
        print *,'lgdplt_pad_left_in_em = ', p% lgdplt_pad_left_in_em
        print *,'lgdplt_pad_right_in_em = ', p% lgdplt_pad_right_in_em
        print *,'lgdplt_pad_top_in_em = ', p% lgdplt_pad_top_in_em
        print *,'lgdplt_pad_bottom_in_em = ', p% lgdplt_pad_bottom_in_em
        print *,'lgdplt_char_size_in_px = ', p% lgdplt_char_size_in_px
        print *,'lgdplt_plot_right_edge = ', p% lgdplt_plot_right_edge
        print *,'lgdplt_legend_left_edge = ', p% lgdplt_legend_left_edge
        print *,'lgdplt_legend_txt_scale = ', p% lgdplt_legend_txt_scale
        print *,'lgdplt_legend_top_edge = ', p% lgdplt_legend_top_edge
        print *,'lgdplt_legend_left_margin_in_em = ', p% lgdplt_legend_left_margin_in_em
        print *,'lgdplt_legend_top_margin_in_em = ', p% lgdplt_legend_top_margin_in_em
        print *,'lgdplt_legend_lineskip_in_em = ', p% lgdplt_legend_lineskip_in_em
        print *,'lgdplt_legend_line_length_in_em = ', p% lgdplt_legend_line_length_in_em
        print *,'lgdplt_show_margin_box = ', p% lgdplt_show_margin_box
        print *,'device_id = ', p% device_id
        print *,'is_file = ', p% is_file        
    end subroutine print_pggrid_controls
    
end module pggrid_lib

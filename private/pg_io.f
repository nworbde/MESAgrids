module pg_io
    use pggrid_def

    include 'pggrid_controls.f'
        
    namelist /pggrid/ &
        file_flag, &
        file_dir, &
        file_prefix, &
        file_device, &
        file_extension, &
        file_width, &
        win_width, &
        file_aspect_ratio, &
        win_aspect_ratio, &
        max_fraction_padding, &
        grid_num_cols, &
        grid_num_rows, &
        grid_num_plots, &
        grid_plot_names, &
        grid_plot_col, &
        grid_plot_colspan, &
        grid_plot_row, &
        grid_plot_rowspan, &
        grid_col_offset_in_px, &
        grid_row_offset_in_px, &
        grid_left_margin, &
        grid_right_margin, &
        grid_top_margin, &
        grid_bottom_margin, &
        grid_subplot_text_scale, &
        simplt_left_margin, &
        simplt_right_margin, &
        simplt_top_margin, &
        simplt_bottom_margin, &
        simplt_pad_left_in_em, &
        simplt_pad_right_in_em, &
        simplt_pad_top_in_em, &
        simplt_pad_bottom_in_em, &
        simplt_char_size_in_px, &
        simplt_show_margin_box, &
        lgdplt_left_margin, &
        lgdplt_right_margin, &
        lgdplt_top_margin, &
        lgdplt_bottom_margin, &
        lgdplt_pad_left_in_em, &
        lgdplt_pad_right_in_em, &
        lgdplt_pad_top_in_em, &
        lgdplt_pad_bottom_in_em, &
        lgdplt_char_size_in_px, &
        lgdplt_plot_right_edge, &
        lgdplt_legend_left_edge, &
        lgdplt_legend_txt_scale, &
        lgdplt_legend_top_edge, &
        lgdplt_legend_left_margin_in_em, &
        lgdplt_legend_top_margin_in_em, &
        lgdplt_legend_lineskip_in_em, &
        lgdplt_legend_line_length_in_em, &
        lgdplt_show_margin_box
    
    contains
        
        subroutine read_pggrid_controls(p,filename,ierr)
            use utils_lib
            type(pg_data), pointer :: p
            character(len=*), intent(in) :: filename
            integer, intent(out) :: ierr
            integer :: iounit
            
            ierr = 0
            call set_default_pggrid_controls
            iounit = alloc_iounit(ierr); if (ierr /= 0) return
            open(unit=iounit,file=trim(filename), action='read',  &
            &   delim='quote',status='old',iostat=ierr)
            if (failure('opening '//trim(filename))) then
                call free_iounit(iounit)
                return
            end if
            read(iounit,nml=pggrid,iostat=ierr)
            if (failure('reading from '//trim(filename))) then
                open(unit=iounit,file=trim(filename), action='read',  &
                &   delim='quote',status='old',iostat=ierr)
                read(iounit,nml=pggrid)
                close(iounit)
                call free_iounit(iounit)
                return
            end if
            close(iounit)
            call free_iounit(iounit)
            call store_pggrid_controls(p)
            
        contains
            function failure(doing_what)
                use, intrinsic :: iso_fortran_env, only: error_unit
                character(len=*), intent(in) :: doing_what
                logical :: failure
                
                failure = (ierr /= 0)
                if (failure) then
                    write(error_unit,'(a,i0)') 'ERROR while '//doing_what// &
                    &   ': ierr = ',ierr
                end if
            end function failure
        end subroutine read_pggrid_controls
        
        subroutine store_pggrid_controls(p)
            type(pg_data), pointer :: p
            
                p% file_flag = file_flag
                p% file_dir = file_dir
                p% file_prefix = file_prefix
                p% file_device = file_device
                p% file_extension = file_extension
                p% file_width = file_width
                p% win_width = win_width
                p% file_aspect_ratio = file_aspect_ratio
                p% win_aspect_ratio = win_aspect_ratio
                p% max_fraction_padding = max_fraction_padding
                p% grid_num_cols = grid_num_cols
                p% grid_num_rows = grid_num_rows
                p% grid_num_plots = grid_num_plots
                p% grid_plot_names = grid_plot_names
                p% grid_plot_col = grid_plot_col
                p% grid_plot_colspan = grid_plot_colspan
                p% grid_plot_row = grid_plot_row
                p% grid_plot_rowspan = grid_plot_rowspan
                p% grid_col_offset_in_px = grid_col_offset_in_px
                p% grid_row_offset_in_px = grid_row_offset_in_px
                p% grid_left_margin = grid_left_margin
                p% grid_right_margin = grid_right_margin
                p% grid_top_margin = grid_top_margin
                p% grid_bottom_margin = grid_bottom_margin
                p% grid_subplot_text_scale = grid_subplot_text_scale
                p% simplt_left_margin = simplt_left_margin
                p% simplt_right_margin = simplt_right_margin
                p% simplt_top_margin = simplt_top_margin
                p% simplt_bottom_margin = simplt_bottom_margin
                p% simplt_pad_left_in_em = simplt_pad_left_in_em
                p% simplt_pad_right_in_em = simplt_pad_right_in_em
                p% simplt_pad_top_in_em = simplt_pad_top_in_em
                p% simplt_pad_bottom_in_em = simplt_pad_bottom_in_em
                p% simplt_char_size_in_px = simplt_char_size_in_px
                p% simplt_show_margin_box = simplt_show_margin_box
                p% lgdplt_left_margin = lgdplt_left_margin
                p% lgdplt_right_margin = lgdplt_right_margin
                p% lgdplt_top_margin = lgdplt_top_margin
                p% lgdplt_bottom_margin = lgdplt_bottom_margin
                p% lgdplt_pad_left_in_em = lgdplt_pad_left_in_em
                p% lgdplt_pad_right_in_em = lgdplt_pad_right_in_em
                p% lgdplt_pad_top_in_em = lgdplt_pad_top_in_em
                p% lgdplt_pad_bottom_in_em = lgdplt_pad_bottom_in_em
                p% lgdplt_char_size_in_px = lgdplt_char_size_in_px
                p% lgdplt_plot_right_edge = lgdplt_plot_right_edge
                p% lgdplt_legend_left_edge = lgdplt_legend_left_edge
                p% lgdplt_legend_txt_scale = lgdplt_legend_txt_scale
                p% lgdplt_legend_top_edge = lgdplt_legend_top_edge
                p% lgdplt_legend_left_margin_in_em = &
                &  lgdplt_legend_left_margin_in_em
                p% lgdplt_legend_top_margin_in_em = &
                &  lgdplt_legend_top_margin_in_em
                p% lgdplt_legend_lineskip_in_em = lgdplt_legend_lineskip_in_em
                p% lgdplt_legend_line_length_in_em =  &
                &  lgdplt_legend_line_length_in_em
                p% lgdplt_show_margin_box = lgdplt_show_margin_box
            
        end subroutine store_pggrid_controls
        
        subroutine set_default_pggrid_controls
           include 'pggrid.defaults'
        end subroutine set_default_pggrid_controls
        

end module pg_io

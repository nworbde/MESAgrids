module pggrid_def

    integer, parameter :: grid_max_num_cols = 12
    integer, parameter :: grid_max_num_rows = 12
    type pg_data
        ! set by user
        real :: min_fraction_plt
        
        integer :: grid_num_cols
        integer :: grid_num_rows
        real :: grid_col_offset_in_px
        real :: grid_row_offset_in_px
        real :: grid_pad_left
        real :: grid_pad_right
        real :: grid_pad_top
        real :: grid_pad_bottom
        
        real :: simplt_pad_left_in_em
        real :: simplt_pad_right_in_em
        real :: simplt_pad_top_in_em
        real :: simplt_pad_bottom_in_em
        real :: simplt_char_size_in_px

        real :: lgdplt_pad_left_in_em
        real :: lgdplt_pad_right_in_em
        real :: lgdplt_pad_top_in_em
        real :: lgdplt_pad_bottom_in_em
        real :: lgdplt_char_size_in_px
        real :: lgdplt_legend_txt_scale
        real :: lgdplt_legend_width
        real :: lgdplt_legend_left_margin_in_em
        real :: lgdplt_legend_top_margin_in_em
        real :: lgdplt_legend_lineskip_in_em
        real :: lgdplt_legend_line_length_in_em
        
        ! internal, private
        real, dimension(grid_max_num_cols) :: grid_col_left, grid_col_right
        real, dimension(grid_max_num_rows) :: grid_row_top, grid_tow_bottom
    end type pg_data
    

end module pggrid_def

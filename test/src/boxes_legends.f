program boxes
    use, intrinsic :: iso_fortran_env
    use pggrid_def
    use pggrid_lib
    type(pg_data), pointer :: p
    integer :: ierr
    
    call get_pg_pointer(p)
    p% file_flag = .FALSE.
    p% win_width = 6.0
    p% win_aspect_ratio = 0.618
    
    p% lgdplt_char_size_in_px = 14.0
    
    ! make a box around the margin
    p% lgdplt_left_margin = 0.05
    p% lgdplt_right_margin = 0.05
    p% lgdplt_top_margin = 0.05
    p% lgdplt_bottom_margin = 0.05
    p% lgdplt_pad_left_in_em = 0
    p% lgdplt_pad_right_in_em = 0
    p% lgdplt_pad_top_in_em = 0
    p% lgdplt_pad_bottom_in_em = 0
    p% lgdplt_legend_txt_scale = 0.7
    p% lgdplt_plot_right_edge = 0.85
    p% lgdplt_legend_left_edge = 0.85
    p% lgdplt_legend_top = 1.0
    p% lgdplt_legend_left_margin_in_em = 1.0
    p% lgdplt_legend_top_margin_in_em = 0.5
    p% lgdplt_legend_lineskip_in_em = 1.2
    p% lgdplt_legend_line_length_in_em = 2.0
    
    call make_pggrid_plot('Box_with_Legend',ierr)
    
    ! now make the simple plot, same margins, but with 4 em padding
    p% lgdplt_pad_left_in_em = 4
    p% lgdplt_pad_right_in_em = 0
    p% lgdplt_pad_top_in_em = 4
    p% lgdplt_pad_bottom_in_em = 4
    
    call make_pggrid_plot('Legend_Plot',ierr)
    
end program boxes

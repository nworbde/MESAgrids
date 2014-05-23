program boxes
    use, intrinsic :: iso_fortran_env
    use pggrid_def
    use pggrid_lib
    type(pg_data), pointer :: p
    integer :: ierr
    
    call get_pg_pointer(p)
    p% file_flag = .TRUE.
    p% file_dir = '.'
    p% file_prefix = 'box'
    p% file_device = 'png'
    p% file_extension = 'png'
    p% win_width = 6.0
    p% win_aspect_ratio = 0.618
    p% file_width = 6.0
    p% file_aspect_ratio = 0.618
    p% simplt_char_size_in_px = 14.0
    
    ! make a box around the margin
    p% simplt_left_margin = 0.05
    p% simplt_right_margin = 0.05
    p% simplt_top_margin = 0.05
    p% simplt_bottom_margin = 0.05
    p% simplt_pad_left_in_em = 0
    p% simplt_pad_right_in_em = 0
    p% simplt_pad_top_in_em = 0
    p% simplt_pad_bottom_in_em = 0
    
    call make_pggrid_plot('Box',ierr)
    
    ! now make the simple plot, same margins, but with 4 em padding
    p% file_prefix = 'box_with_simple_plot'
    p% simplt_pad_left_in_em = 4
    p% simplt_pad_right_in_em = 0
    p% simplt_pad_top_in_em = 4
    p% simplt_pad_bottom_in_em = 4
    p% simplt_show_margin_box = .TRUE.
    
    call make_pggrid_plot('Simple_Plot',ierr)
    
end program boxes

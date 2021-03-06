    logical :: file_flag
    character(len=256) :: file_dir
    character(len=256) :: file_prefix
    character(len=256) :: file_device
    character(len=256) :: file_extension
    real :: file_width
    real :: win_width
    real :: file_aspect_ratio
    real :: win_aspect_ratio
    real :: max_fraction_padding

    integer :: grid_num_cols
    integer :: grid_num_rows
    integer :: grid_num_plots
    character(len=64), dimension(grid_max_plots) :: grid_plot_names
    integer, dimension(grid_max_plots) :: grid_plot_col
    integer, dimension(grid_max_plots) :: grid_plot_colspan
    integer, dimension(grid_max_plots) :: grid_plot_row
    integer, dimension(grid_max_plots) :: grid_plot_rowspan

    real :: grid_col_offset_in_px
    real :: grid_row_offset_in_px
    real :: grid_left_margin
    real :: grid_right_margin
    real :: grid_top_margin
    real :: grid_bottom_margin
    real :: grid_subplot_text_scale
    
    real :: simplt_left_margin
    real :: simplt_right_margin
    real :: simplt_top_margin
    real :: simplt_bottom_margin
    real :: simplt_pad_left_in_em
    real :: simplt_pad_right_in_em
    real :: simplt_pad_top_in_em
    real :: simplt_pad_bottom_in_em
    real :: simplt_char_size_in_px
    logical :: simplt_show_margin_box

    real :: lgdplt_left_margin
    real :: lgdplt_right_margin
    real :: lgdplt_top_margin
    real :: lgdplt_bottom_margin
    real :: lgdplt_pad_left_in_em
    real :: lgdplt_pad_right_in_em
    real :: lgdplt_pad_top_in_em
    real :: lgdplt_pad_bottom_in_em
    real :: lgdplt_char_size_in_px
    real :: lgdplt_plot_right_edge
    real :: lgdplt_legend_left_edge
    real :: lgdplt_legend_txt_scale
    real :: lgdplt_legend_top_edge
    real :: lgdplt_legend_left_margin_in_em
    real :: lgdplt_legend_top_margin_in_em
    real :: lgdplt_legend_lineskip_in_em
    real :: lgdplt_legend_line_length_in_em
    logical :: lgdplt_show_margin_box

    ! internal, private
    integer :: device_id
    logical :: is_file

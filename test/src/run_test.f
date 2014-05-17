program run_test
    use, intrinsic :: iso_fortran_env
    use :: pg_plots
    integer :: id
    integer :: pgopen
    real :: wxl, wxr, wyt, wyb, padding(4), gutters(4)
    real :: legend_width, legend_left_margin, legend_top_margin
    real :: legend_lineskip, legend_line_length
    real, parameter :: target_ch_px_h = 14.0, target_padding_px = 15.0
    real :: xch, ych
    real :: x1, x2, y1, y2
    
     id = pgopen('/xwin')
!     id = pgopen('sandbox_plt.png/png')
    if (id <= 0) then
        write(error_unit,*) 'please check that X Window System is running'
        write(error_unit,*) 'and that you have set the environment variables'
        write(error_unit,*) 'DISPLAY :0'
        write(error_unit,*) 'PGPLOT_DEV /xwin'
        write(error_unit,*) 'and also that you have set PGPLOT_DIR and PGPLOT_FONT'
    end if
    call pgpap(12.0,2./3.)
    
    ! left, right, top, bottom of patch
    wxl = 1.0/3.0
    wxr = 1.0
    wyt = 1.0
    wyb = 0.5
    
    ! padding in fractions of patch screen height, width
    ! try padding in pixel units
    call pgqvsz(3,x1,x2,y1,y2)
    print *, 'width in pixels = ', x2
    print *, 'height in pixels = ',y2
    padding(1:2) = target_padding_px/x2
    padding(3:4) = target_padding_px/y2
    
    ! size of gutters (left, right, top, bottom) in units of a character height 
    ! in normalized units
    gutters(:) = [4.0,0.0,4.0,4.0]

    legend_width = 0.25
    legend_left_margin = 1.0
    legend_top_margin = 0.5
    legend_lineskip = 1.2
    legend_line_length = 2.0
    
    ! attempt to scale text to a target pixel height
    call pgqcs(3,xch,ych)
    call pgsch(target_ch_px_h/ych)
    
    ! upper right
    call do_plot_with_legend(wxl,wxr,wyt,wyb,padding,gutters, &
        &   legend_width,legend_left_margin, legend_top_margin, &
        &   legend_lineskip, legend_line_length)
    
    wxl = 0.0
    wxr = 2./3.
    wyt = 0.5
    wyb = 0.0

    ! lower left
    call do_plot_with_legend(wxl,wxr,wyt,wyb,padding,gutters, &
        &   legend_width,legend_left_margin, legend_top_margin, &
        &   legend_lineskip, legend_line_length)

    ! upper left
    wxl = 0.0
    wxr = 1./3.
    wyt = 1.0
    wyb = 0.5

    call do_plot(wxl,wxr,wyt,wyb,padding,gutters)

    ! lower right
    wxl = 2./3.
    wxr = 1.0
    wyt = 0.5
    wyb = 0.0

    call do_plot(wxl,wxr,wyt,wyb,padding,gutters)
    
    call pgclos
    
end program run_test

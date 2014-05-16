program run_test
    use, intrinsic:: iso_fortran_env
    integer :: id
    integer :: pgopen
    real :: wxl, wxr, wyt, wyb, padding(4), gutters(4)
    
    id = pgopen('/xwin')
    if (id <= 0) then
        write(error_unit,*) 'please check that X Window System is running'
        write(error_unit,*) 'and that you have set the environment variables'
        write(error_unit,*) 'DISPLAY :0'
        write(error_unit,*) 'PGPLOT_DEV /xwin'
        write(error_unit,*) 'and also that you have set PGPLOT_DIR and PGPLOT_FONT'
    end if
    
    ! left, right, top, bottom of patch
    wxl = 1.0/3.0
    wxr = 1.0
    wyt = 1.0
    wyb = 0.5
    
    ! padding in fractions of full screen height, width
    padding(:) = 0.03
    
    ! size of gutters (left, right, top, bottom) in units of a character height 
    ! in normalized units
    gutters(:) = [4.0,0.0,4.0,4.0]

    call pgpap(9.0,1.0)
    
    call do_plot(wxl,wxr,wyt,wyb,padding,gutters)
    
    wxl = 0.0
    wxr = 2./3.
    wyt = 0.5
    wyb = 0.0

    call pgsch(0.6)
    call do_plot(wxl,wxr,wyt,wyb,padding,gutters)

    wxl = 0.0
    wxr = 1./3.
    wyt = 1.0
    wyb = 0.5

    call do_plot(wxl,wxr,wyt,wyb,padding,gutters)
    
    call pgclos
    
contains
    subroutine do_plot(wxl,wxr,wyt,wyb,padding,gutters)
        real, intent(in) :: wxl,wxr,wyt,wyb,padding(4),gutters(4)
        integer, parameter :: np=100
        integer :: i
        real, dimension(np) :: xr, yr
        real :: patch_width, patch_height
        real :: padl, padr, padt, padb, gl, gr, gt, gb
        real :: xch, ych
        real :: vl, vr, vt, vb
        
        xr = [(0.1*i,i=1,np)]
        yr = sin(xr)

        ! set up plot
        patch_width = wxr-wxl
        patch_height = wyt-wyb
        
        padl = padding(1)
        padr = padding(2)
        padt = padding(3)
        padb = padding(4)
        
        ! get character height in normalized units
        call pgqcs(0,xch,ych)
        gl = xch*gutters(1)
        gr = xch*gutters(2)
        gt = ych*gutters(3)
        gb = ych*gutters(4)
        
        ! locate the viewport
        vl = wxl + padl + gl
        vr = wxr - padr - gr
        vt = wyt - padt - gt
        vb = wyb + padb + gb
        
        call pgsvp(vl,vr,vb,vt)
        call pgswin(minval(xr),maxval(xr),minval(yr),maxval(yr))
        call pgbox('BCNST',0.0,0,'BCNSTV',0.0,0)
        call pglab('x','y','hello world')
        call pgline(100,xr,yr)
        
    end subroutine do_plot
    
end program run_test

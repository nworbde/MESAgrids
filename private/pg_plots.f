module pg_plots

contains
    subroutine do_plot(wl,wr,wt,wb,padding,gutters)
        ! left, right coordinates of patch
        real, intent(in) :: wl,wr
        ! top, bottom coordinates of patch
        real, intent(in) :: wt, wb
        ! padding (l, r, t, b) expresses as a fraction of the patch width and 
        ! height
        real, dimension(4), intent(in) :: padding
        ! gutters, in units of the character height, around the plot (l, r, t, 
        ! b)
        real, dimension(4), intent(in) :: gutters
        integer, parameter :: np=100
        integer :: i
        real, dimension(np) :: xr, yr
        real :: patch_width, patch_height
        real :: padl, padr, padt, padb, gl, gr, gt, gb
        real :: xch, ych
        real :: vl, vr, vt, vb
        real, parameter :: margin = 0.05
        
        ! initialize the data
        xr = [(0.1*i,i=1,np)]
        yr = sin(xr)

        ! set up plot
        patch_width = wr-wl
        patch_height = wt-wb
        
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
        vl = wl + padl + gl
        print *, vl, padl, gl
        vr = wr - padr - gr
        vt = wt - padt - gt
        vb = wb + padb + gb
        
        call pgsvp(vl,vr,vb,vt)
        call set_boundaries(xr,yr,margin)
        call pgbox('BCNST',0.0,0,'BCNSTV',0.0,0)
        call pglab('x','y','hello world')
        call pgline(100,xr,yr)
        
    end subroutine do_plot    

    subroutine do_plot_with_legend(wl,wr,wt,wb,padding,gutters, &
        &   legend_width,legend_left_margin, legend_top_margin, &
        &   legend_lineskip, legend_line_length)
        ! left, right coordinates of patch
        real, intent(in) :: wl,wr
        ! top, bottom coordinates of patch
        real, intent(in) :: wt, wb
        ! padding (l, r, t, b) expresses as a fraction of the patch width and 
        ! height
        real, dimension(4), intent(in) :: padding
        ! gutters, in units of the character height, around the plot (l, r, t, 
        ! b)
        real, dimension(4), intent(in) :: gutters
        ! width of legend, in units of the total plot area (ie, after trimming 
        ! away padding and gutters)
        real, intent(in) :: legend_width
        ! margin, in units of character height, between plot and legend
        real, intent(in) :: legend_left_margin
        ! distance from top to first line of text is legend_top_margin+<char. 
        ! height>
        real, intent(in) :: legend_top_margin
        ! distance between baselines of text, in units of character height
        real, intent(in) :: legend_lineskip
        ! length of line, in units of character height
        real, intent(in) :: legend_line_length
        !
        real :: patch_width, patch_height
        real :: padl, padr, padt, padb, gl, gr, gt, gb
        real :: xch, ych
        real :: vl, vr, vt, vb, viewport_width, viewport_height
        real :: ll, lr, lt, lb
        real :: pl, pr, pt, pb
        integer, parameter :: np = 100, nl = 4
        integer :: i, j
        real, dimension(np) :: xr
        real, dimension(np,nl) :: yr
        real, parameter :: pi = 3.141592653590
        real, parameter :: margin = 0.05
        real, dimension(2) :: xl, yl
        real :: xtxt, ytxt
        integer :: ci, save_ci
        character(len=16), dimension(nl) :: lgn_txt
        
        ! initialize the data
        xr = [(pi*real(i-1)/real(np-1),i=1,np)]
        forall(i=1:np,j=1:nl) yr(i,j) = sin(xr(i)*real(j))
        do i = 1, nl
            write(lgn_txt(i),'(a,i0)') 'freq. = ',i
        end do

        ! set up plot
        patch_width = wr-wl
        patch_height = wt-wb
        
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
        
        ! locate the viewport area
        vl = wl + padl + gl
        vr = wr - padr - gr
        vt = wt - padt - gt
        vb = wb + padb + gb
        
        viewport_width = vr-vl
        viewport_height = vt-vb
        
        ! set up legend, plot boundaries
        lr = vr
        ll = vr - legend_width*viewport_width
        lt = vt
        lb = vb
        
        pr = ll - legend_left_margin*xch
        pl = vl
        pt = vt
        pb = vb
        
        call pgsvp(pl,pr,pb,pt)
        call set_boundaries(xr,yr(:,nl),margin)
        call pgbox('BCNST',0.0,0,'BCNSTV',0.0,0)
        call pglab('x','y','hello world')
        
        call pgqci(ci)
        save_ci = ci
        do i = 1, nl
            call pgsci(ci)
            call pgline(100,xr,yr(:,i))
            ci = ci + 1
        end do
        
        ! make legend
        call pgsvp(ll,lr,lb,lt)
        call pgswin(ll,lr,lb,lt)

        xl = [ ll, ll+legend_line_length*xch ]
        yl = lt - (legend_top_margin+0.5)*ych
        ci = save_ci
        do i = 1, nl
            call pgsci(ci)
            call pgline(2,xl,yl)
            xtxt = xl(2)+xch
            ytxt = yl(2)-0.5*ych
            call pgsci(save_ci)
            call pgtext(xtxt,ytxt,trim(lgn_txt(i)))
            ci = ci + 1
            yl = yl - legend_lineskip*ych
        end do
        
        call pgsci(save_ci)

    end subroutine do_plot_with_legend
    
    subroutine set_boundaries(xs,ys,margin)
        real, intent(in) :: xs(:),ys(:),margin
        real :: xmin, xmax, ymin, ymax, width, height
        
        xmin = minval(xs)
        xmax = maxval(xs)
        ymin = minval(ys)
        ymax = maxval(ys)
        width = xmax - xmin
        height = ymax - ymin
        call pgswin(xmin-margin*width,xmax+margin*width, &
        &   ymin-margin*height,ymax+margin*height)
    end subroutine set_boundaries
end module pg_plots

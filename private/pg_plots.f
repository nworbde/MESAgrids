module pg_plots
    use pggrid_def
    
contains
    subroutine do_grid(p,xleft,xright,ytop,ybottom)
        use, intrinsic :: iso_fortran_env, only: error_unit
        type(pg_data), pointer :: p
        real, intent(in) :: xleft, xright, ytop, ybottom
        real :: xzero, width_px, yzero, height_px
        real :: col_offset, row_offset
        real :: col_width, row_height
        real :: plot_xleft, plot_xright, plot_ytop, plot_ybottom
        integer :: i
        
        call pgqvsz(3,xzero,width_px,yzero,height_px)
        col_offset = p% grid_col_offset_in_px/width_px
        row_offset = p% grid_row_offset_in_px/height_px
        
        ! adjust padding if necessary
        col_width = 0.0
        row_height = 0.0        
        call adjust_padding_and_set_size( xleft, xright,  &
        &   p% grid_num_cols, col_offset, p% max_fraction_padding, col_width)
        call adjust_padding_and_set_size( ybottom, ytop,  &
        &   p% grid_num_rows, row_offset, p% max_fraction_padding, row_height)

        ! layout grid and make subplots
        do i= 1, p% grid_num_plots
            plot_xleft =  &
            &   xleft + (col_width+col_offset)*(p% grid_plot_col(i)-1)
            plot_xright = plot_xleft + col_width +  &
            &   (col_width+col_offset)*(p% grid_plot_colspan(i)-1)
            plot_ytop =  &
            &   ytop - (row_height+row_offset)*(p% grid_plot_row(i)-1)
            plot_ybottom = plot_ytop - row_height - &
            &   (row_height+row_offset)*(p% grid_plot_rowspan(i)-1)
                        
            select case(p% grid_plot_names(i))
            case ('Legend_Plot')
                call do_lgdplt(p, plot_xleft, plot_xright, &
                &   plot_ytop, plot_ybottom)
            case ('Simple_Plot')
                call do_simplt(p, plot_xleft, plot_xright, &
                &   plot_ytop, plot_ybottom)
            case ('Box')
                call do_box(p,plot_xleft,plot_xright,plot_ytop,plot_ybottom)
            case ('Box_with_Legend')
                call do_box_with_legend(p, &
                &   plot_xleft,plot_xright,plot_ytop,plot_ybottom)
            case default
                write(error_unit,*) 'did not recognize plot name'
            end select
        end do
        
    contains
        subroutine adjust_padding_and_set_size(z1, z2,  &
        &   ndiv, offset, max_frac, div_size)
            real, intent(in) :: z1, z2
            integer, intent(in) :: ndiv
            real, intent(inout) :: offset
            real, intent(in) :: max_frac
            real, intent(out) :: div_size
            real :: padding_ratio
            
            if (ndiv < 2) return
            padding_ratio = (ndiv-1)*offset/(z2-z1)/max_frac
            if (padding_ratio > 1.0) offset = offset / padding_ratio
            div_size = (z2 - z1 - (ndiv-1)*offset)/real(ndiv)
        end subroutine adjust_padding_and_set_size

    end subroutine do_grid
    
    subroutine do_simplt(p,xleft,xright,ytop,ybottom)
        type(pg_data), pointer :: p
        real, intent(in) :: xleft, xright, ytop, ybottom
        integer, parameter :: np=100
        integer :: i
        real, dimension(np) :: xs, ys
        real :: padl, padr, padt, padb
        real :: xch, ych, em_x, em_y
        real :: vl, vr, vt, vb
        real, parameter :: margin = 0.05
        
        ! initialize the data
        xs = [(0.1*i,i=1,np)]
        ys = sin(xs)
        
        call set_text_size(p% simplt_char_size_in_px)
        
        ! get size in normalized units and set padding
        call pgqcs(0,em_x,em_y)
        padl = p% simplt_pad_left_in_em*em_x
        padr = p% simplt_pad_right_in_em*em_x
        padt = p% simplt_pad_top_in_em*em_y
        padb = p% simplt_pad_bottom_in_em*em_y
        
        ! locate the viewport
        vl = xleft + padl
        vr = xright - padr
        vt = ytop - padt
        vb = ybottom + padb
        call pgsvp(vl,vr,vb,vt)
        
        ! make the plot
        call set_boundaries(xs,ys,margin)
        call pgbox('BCNST',0.0,0,'BCNSTV',0.0,0)
        call pglab('x','y','simple plot')
        call pgline(100,xs,ys)
        
    end subroutine do_simplt

    subroutine do_box(p,xleft,xright,ytop,ybottom)
        type(pg_data), pointer :: p
        real, intent(in) :: xleft, xright, ytop, ybottom
        integer :: i
        real :: padl, padr, padt, padb
        real :: xch, ych, em_x, em_y
        real :: vl, vr, vt, vb
        
        call set_text_size(p% simplt_char_size_in_px)
        
        ! get size in normalized units and set padding
        call pgqcs(0,em_x,em_y)
        padl = p% simplt_pad_left_in_em*em_x
        padr = p% simplt_pad_right_in_em*em_x
        padt = p% simplt_pad_top_in_em*em_y
        padb = p% simplt_pad_bottom_in_em*em_y
        
        ! locate the viewport
        vl = xleft + padl
        vr = xright - padr
        vt = ytop - padt
        vb = ybottom + padb
        call pgsvp(vl,vr,vb,vt)
        
        ! make the plot
        call pgswin(0.0,1.0,0.0,1.0)
        call pgbox('BC',0.0,0,'BC',0.0,0)
        
    end subroutine do_box

    subroutine do_lgdplt(p,xleft,xright,ytop,ybottom)
        type(pg_data), pointer :: p
        real, intent(in) :: xleft, xright, ytop, ybottom
        real :: padl, padr, padt, padb
        real :: xch, ych, em_x, em_y, text_scale
        real :: vl, vr, vt, vb, viewport_width, viewport_height
        real :: ll, lr, lt, lb
        real :: pl, pr, pt, pb
        integer, parameter :: np = 100, nl = 4
        integer :: i, j
        real, dimension(np) :: xs
        real, dimension(np,nl) :: ys
        real, parameter :: pi = 3.141592653590
        real, parameter :: margin = 0.05
        real, dimension(2) :: xl, yl
        real :: xtxt, ytxt
        integer :: ci, save_ci
        character(len=16), dimension(nl) :: lgd_txt
        
        ! initialize the data
        xs = [(pi*real(i-1)/real(np-1),i=1,np)]
        forall(i=1:np,j=1:nl) ys(i,j) = sin(xs(i)*real(j))
        do i = 1, nl
            write(lgd_txt(i),'(a,i0)') 'freq. = ',i
        end do

        call set_text_size(p% lgdplt_char_size_in_px)
        
        ! get size in normalized units and set padding
        call pgqcs(0,em_x,em_y)
        padl = p% lgdplt_pad_left_in_em*em_x
        padr = p% lgdplt_pad_right_in_em*em_x
        padt = p% lgdplt_pad_top_in_em*em_y
        padb = p% lgdplt_pad_bottom_in_em*em_y
        
        ! locate the plot area
        vl = xleft + padl
        vr = xright - padr
        vt = ytop - padt
        vb = ybottom + padb
        
        viewport_width = vr-vl
        viewport_height = vt-vb
        
        ! set up legend, plot boundaries
        lr = vr
        ll = vr - p% lgdplt_legend_width*viewport_width
        lt = vt
        lb = vb
        
        pr = ll - p% lgdplt_legend_left_margin_in_em*em_x
        pl = vl
        pt = vt
        pb = vb
        
        ! set plot viewport and make plot
        call pgsvp(pl,pr,pb,pt)
        call set_boundaries(xs,ys(:,nl),margin)
        call pgbox('BCNST',0.0,0,'BCNSTV',0.0,0)
        call pglab('x','y','plot with legend')
        
        call pgqci(ci)
        save_ci = ci
        do i = 1, nl
            call pgsci(ci)
            call pgline(100,xs,ys(:,i))
            ci = ci + 1
        end do
        
        ! make legend
        call pgsvp(ll,lr,lb,lt)
        ! match world coordinates to normalized locations of patch
        call pgswin(ll,lr,lb,lt)
        ! apply legend text scaling
        call pgqch(text_scale)
        call pgsch(p% lgdplt_legend_txt_scale*text_scale)
        call pgqcs(0,em_x,em_y)

        xl = [ ll, ll+p% lgdplt_legend_line_length_in_em*em_x ]
        yl = lt - (p% lgdplt_legend_top_margin_in_em+0.5)*em_y
        ci = save_ci
        do i = 1, nl
            call pgsci(ci)
            call pgline(2,xl,yl)
            xtxt = xl(2)+em_x
            ytxt = yl(2)-0.5*em_y
            call pgsci(save_ci)
            call pgtext(xtxt,ytxt,trim(lgd_txt(i)))
            ci = ci + 1
            yl = yl - p% lgdplt_legend_lineskip_in_em*em_y
        end do
        
        call pgsci(save_ci)
    end subroutine do_lgdplt
    
    subroutine do_box_with_legend(p,xleft,xright,ytop,ybottom)
        type(pg_data), pointer :: p
        real, intent(in) :: xleft, xright, ytop, ybottom
        real :: padl, padr, padt, padb
        real :: xch, ych, em_x, em_y, text_scale
        real :: vl, vr, vt, vb, viewport_width, viewport_height
        real :: ll, lr, lt, lb
        real :: pl, pr, pt, pb
        integer :: ci, save_ci

        call set_text_size(p% lgdplt_char_size_in_px)
        
        ! get size in normalized units and set padding
        call pgqcs(0,em_x,em_y)
        padl = p% lgdplt_pad_left_in_em*em_x
        padr = p% lgdplt_pad_right_in_em*em_x
        padt = p% lgdplt_pad_top_in_em*em_y
        padb = p% lgdplt_pad_bottom_in_em*em_y
        
        ! locate the plot area
        vl = xleft + padl
        vr = xright - padr
        vt = ytop - padt
        vb = ybottom + padb
        
        viewport_width = vr-vl
        viewport_height = vt-vb
        
        ! set up legend, plot boundaries
        lr = vr
        ll = vr - p% lgdplt_legend_width*viewport_width
        lt = vt
        lb = vb
        
        pr = ll - p% lgdplt_legend_left_margin_in_em*em_x
        pl = vl
        pt = vt
        pb = vb
        
        ! set plot viewport and make plot
        call pgsvp(pl,pr,pb,pt)
        call pgswin(0.0,1.0,0.0,1.0)
        call pgbox('BC',0.0,0,'BC',0.0,0)
        
        ! make legend
        call pgsvp(ll,lr,lb,lt)
        ! match world coordinates to normalized locations of patch
        call pgswin(ll,lr,lb,lt)
        
        call pgqci(ci)
        save_ci = ci
        ci = ci+1
        call pgsci(ci)
        call pgbox('BC',0.0,0,'BC',0.0,0)
        call pgsci(save_ci)
        
    end subroutine do_box_with_legend
   
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
    
    subroutine set_text_size(size_px)
        real, intent(in) :: size_px
        real :: xch,ych
        integer, parameter :: return_size_in_px = 3
        ! set characters to default scale, query size in px, and then set scale
        call pgsch(1.0)
        call pgqcs(return_size_in_px,xch,ych)
        call pgsch(p% lgdplt_char_size_in_px/xch)
    end subroutine set_text_size
    
end module pg_plots

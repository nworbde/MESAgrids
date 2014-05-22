program ck_pgplot

    integer :: id
    real :: x(2), y(2)
    
    x = [0.0,1.0]
    y = x
    
    id = pgopen('./test_pgplot.png/png')
    call pgpap(9.0,0.618)
    
    call pgsvp(0.05,0.95,0.05, 0.95)
    call pgswin(0.0,1.0,0.0,1.0)
    
    call pgbox('BCNST',0.0,0,'BCNSTV',0.0,0)
    call pglab('x','y','chk pgplot')
    call pgline(2,x,y)
    call pgclos
end program ck_pgplot

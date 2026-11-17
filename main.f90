program main

    use parametres
    use cas_test
    use VF
    use sortie
    implicit none

    integer :: Nx, Ny, dim
    real(pr) :: xmin, xmax, ymin, ymax, Tmax, CFL, cas, hL, hR, xb

    integer :: i
    real(pr) :: dx, dy
    real(pr), dimension(:), allocatable :: x, h, hu, z

    open(unit=2,file="donnees.dat")
    read(2,*) dim
    read(2,*) Nx
    read(2,*) Ny
    read(2,*) xmin
    read(2,*) xmax
    read(2,*) ymin
    read(2,*) ymax
    read(2,*) xb
    read(2,*) Tmax
    read(2,*) CFL
    read(2,*) cas
    read(2,*) hL
    read(2,*) hR

    !print *, dim, Nx, Ny, xmin, xmax, ymin, ymax, xb, Tmax, CFL, cas, hL, hR

    dx = (xmax-xmin)/Nx


    allocate(x(0:Nx+1))
    allocate(h(0:Nx+1))
    allocate(hu(0:Nx+1))
    allocate(z(0:Nx+1))

    do i = 0, Nx+1
        x(i) = xmin + (i-0.5_pr)*dx
    end do

    print *, x






    close(2)















end program main
program main

    use parametres
    use cas_test
    use VF
    use sortie
    implicit none

    integer :: Nx, Ny, dim, cas
    real(pr) :: xmin, xmax, ymin, ymax, Tmax, CFL, hG, hD, xb

    integer :: i
    real(pr) :: dx, dy
    real(pr), dimension(:), allocatable :: x, z
    real(pr), dimension(:,:), allocatable :: w

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
    read(2,*) hG
    read(2,*) hD
    close(2)

    dx = (xmax-xmin)/Nx

    allocate(x(0:Nx+1), z(0:Nx+1), w(dim + 1, 0:Nx+1))

    do i = 0, Nx+1
        x(i) = xmin + (i-0.5_pr)*dx
    end do


    select case (cas)
    case (1)
        call init_rupture_barrage(Nx, x, xb, hG, hD, w, z)
        print *, w(1, Nx/2), w(1, Nx/2+1)



    case (2)
        ! plus tard : lac au repos




    case default
        print *, "Cas-test inconnu :", cas
        stop
    end select
    
    





    deallocate(x, z, w)

end program main
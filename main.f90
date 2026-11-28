program main

    use parametres
    use cas_test
    use VF
    use sortie
    use solution_exacte
    implicit none

    integer :: Nx, Ny, dim, cas
    real(pr) :: xmin, xmax, ymin, ymax, Tmax, CFL, hG, hD, xb, z0

    integer :: i
    real(pr) :: dx
    real(pr), dimension(:), allocatable :: x, z
    real(pr), dimension(:,:), allocatable :: w, w_ex

    call read_param("donnees.dat" ,dim, Nx, Ny, xmin, xmax, ymin, ymax, xb, Tmax, CFL, cas, hG, hD, z0)

    dx = (xmax-xmin)/Nx
    allocate(x(0:Nx+1), z(0:Nx+1), w(dim + 1, 0:Nx+1), w_ex(dim + 1,0:Nx+1))

    do i = 0, Nx+1
        x(i) = xmin + (i-0.5_pr)*dx
    end do



    select case (cas)
    case (1)
        call init_rupture_barrage(Nx, x, xb, hG, hD, w, z, z0)
        call resolution_1D(Nx, w, dx, CFL, Tmax)
        call ecrire_resultats(Nx, x, w, z, "final.dat")

        call init_rupture_barrage(Nx, x, xb, hG, hD, w_ex, z, z0)
        call solution_exacte_barrage(Nx, x, Tmax, xb, hG, hD, w_ex)
        call ecrire_resultats(Nx, x, w_ex, z, "exacte.dat")
        
        print *, "Erreur L1 :", erreur_L1(Nx, w, w_ex, dx)




    case (2)
        !lac au repos




    case default
        print *, "Cas-test inconnu :", cas
        stop
    end select
    
    





    deallocate(x, z, w, w_ex)

end program main
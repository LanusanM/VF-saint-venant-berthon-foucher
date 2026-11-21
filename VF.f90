module VF

    use parametres
    implicit none

    contains

    function flux_function(w) result(f)
        real(pr), dimension(2), intent(in) :: w
        real(pr), dimension(2) :: f
        real(pr) :: h, u

        h = w(1)
        if (h > eps) then
            u = w(2) / h
        else
            u = 0.0_pr                                   ! maille sèche
        end if

        f(1) = h * u                                    ! flux de masse : hu
        f(2) = h * u*u + 0.5_pr * g * h*h
    end function flux_function





      !> Flux numérique HLL entre un état gauche wG et un état droit wD
    function flux_HLL(wG, wD) result(F)
        real(pr), dimension(2), intent(in) :: wG, wD   ! (h, hu) à gauche et à droite de l'interface
        real(pr), dimension(2)             :: F
        real(pr) :: hG, uG, cG, hD, uD, cD, lm, lp

        
        hG = wG(1)
        hD = wD(1)
        uG = 0.0_pr
        uD = 0.0_pr
        if (hG > eps) uG = wG(2) / hG
        if (hD > eps) uD = wD(2) / hD
        cG = sqrt(g * max(hG, 0.0_pr))
        cD = sqrt(g * max(hD, 0.0_pr))

        
        lm = min(uG - cG, uD - cD)
        lp = max(uG + cG, uD + cD)

        if (lp - lm < eps) then
        F = 0.0_pr                                  ! deux états secs : aucun flux
        else if (lm >= 0.0_pr) then
        F = flux_function(wG)                       ! toutes les ondes vont à droite
        else if (lp <= 0.0_pr) then
        F = flux_function(wD)                       ! toutes les ondes vont à gauche
        else
        F = ( lp*flux_function(wG) - lm*flux_function(wD) &
                + lp*lm*(wD - wG) ) / (lp - lm)       ! état intermédiaire HLL
        end if
    end function flux_HLL




    subroutine conditions_limites(Nx,w)
        integer, intent(in) :: Nx
        real(pr), dimension(:,0:), intent(out) :: w

        w(:,0) = w(:,1)
        w(:,Nx+1) = w(:,Nx)


    end subroutine conditions_limites



    function pas_de_temps(Nx, w, dx, CFL) result(dt)
        integer, intent(in) :: Nx
        real(pr), dimension(:,0:), intent(in) :: w
        real(pr), intent(in) :: dx, CFL
        real(pr) :: dt, vmax, h, u
        integer :: i

        vmax = 0._pr

        do i = 1, Nx
            h = w(1,i)
            if (h<eps) then
                u = 0._pr
            else
                u = w(2,i)/h
            end if
            if (abs(u) + sqrt(g*h) > vmax) then
                vmax = abs(u) + sqrt(g*h)
            end if
        end do

        dt = CFL * dx/vmax  
    end function pas_de_temps

    
end module VF


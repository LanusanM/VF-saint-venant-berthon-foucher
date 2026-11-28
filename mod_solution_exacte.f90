module solution_exacte

  use parametres
  implicit none

contains

    function phi(h, hG, hD) result(val)
        real(pr), intent(in) :: h, hG, hD
        real(pr) :: val

        val = 2.0_pr * (sqrt(g*hG) - sqrt(g*h)) - (h - hD) * sqrt( g * (h + hD) / (2.0_pr * h * hD) )      
    end function phi


    function hauteur_plateau(hG, hD) result(hs)
        real(pr), intent(in) :: hG, hD
        real(pr) :: hs
        real(pr) :: a, b
        integer  :: k

        a = hD
        b = hG
        do k = 1, 100
        hs = 0.5_pr * (a + b)                
        if (phi(hs, hG, hD) > 0.0_pr) then
            a = hs                             
        else
            b = hs                             
        end if
        end do
        hs = 0.5_pr * (a + b)
    end function hauteur_plateau


    subroutine solution_exacte_barrage(Nx, x, t, xb, hG, hD, w_ex)
        integer, intent(in) :: Nx
        real(pr), intent(in) :: t, xb, hG, hD
        real(pr), dimension(0:), intent(in) :: x
        real(pr), dimension(:,0:), intent(out) :: w_ex
        real(pr) :: hs, cG, cs, us, s, k, h, u
        integer  :: i
        hs = hauteur_plateau(hG, hD)
        cG = sqrt(g*hG)
        cs = sqrt(g*hs)
        us = 2*(cG-cs)
        s = hs*us / (hs - hD)

        do i = 1, Nx
            k = (x(i) - xb)/t
            if (k < -cG) then                          ! amont au repos
                w_ex(1,i) = hG
                w_ex(2,i) = 0._pr
            else if (k <= us - cs) then                ! détente
                h = (2*cG - k)**2 / (9*g)
                u = 2.0_pr*(cG + k)/3.0_pr
                w_ex(1,i) = h
                w_ex(2,i) = h*u                        ! débit hu
            else if (k < s) then                       ! plateau
                w_ex(1,i) = hs
                w_ex(2,i) = hs*us
            else                                       ! aval au repos
                w_ex(1,i) = hD
                w_ex(2,i) = 0._pr
            end if
        end do

    end subroutine solution_exacte_barrage


    function erreur_L1(Nx, w, w_ex, dx) result(err)
        integer,                   intent(in) :: Nx
        real(pr), dimension(:,0:), intent(in) :: w      ! solution numérique
        real(pr), dimension(:,0:), intent(in) :: w_ex   ! solution exacte
        real(pr),                  intent(in) :: dx
        real(pr) :: err
        integer  :: i

        err = 0.0_pr
        do i = 1, Nx                                    
        err = err + abs(w(1,i) - w_ex(1,i)) * dx
        end do

    end function erreur_L1

    


  






  ! hauteur_plateau, solution_exacte_barrage, erreur_L1



end module solution_exacte
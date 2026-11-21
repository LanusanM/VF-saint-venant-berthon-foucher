module solution_exacte

  use parametres
  implicit none

contains



    function phi(h, hG, hD) result(val)
        real(pr), intent(in) :: h, hG, hD
        real(pr) :: val

        val = 2.0_pr * (sqrt(g*hG) - sqrt(g*h))                    &   ! 
            - (h - hD) * sqrt( g * (h + hD) / (2.0_pr * h * hD) )      
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


    subroutine solution_exacte_barrage(Nx, x, t, xb, hG, hD, h_ex, u_ex)
        integer, intent(in) :: Nx
        real(pr), intent(in) :: t, xb, hG, hD
        real(pr), dimension(0:), intent(in) :: x
        real(pr), dimension(0:), intent(out) :: h_ex, u_ex
        real(pr) :: hs, cG, cs, us, s, k
        integer  :: i
        hs = hauteur_plateau(hG, hD)
        cG = sqrt(g*hG)
        cs = sqrt(g*hs)
        us = 2*(cG-cs)
        s = hs*us / (hs - hD)

        do i = 1,Nx 
            k = (x(i)-xb)/t
            if (k < -cG) then
                h_ex(i) = hG
                u_ex(i) = 0._pr
            else if (k <= us - cs) then
                h_ex(i) = (2*cG - k)*(2*cG - k)/(9*g)
                u_ex(i) = 2.0_pr*(cG + k)/3.0_pr
            else if (k < s) then
                h_ex(i) = hs
                u_ex(i) = us
            else 
                h_ex(i) = hD
                u_ex(i) = 0._pr
            end if
        end do 

    end subroutine solution_exacte_barrage
    






  ! hauteur_plateau, solution_exacte_barrage, erreur_L1



end module solution_exacte
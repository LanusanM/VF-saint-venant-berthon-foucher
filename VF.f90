module VF

    use parametres
    implicit none

    contains

    function flux_function(w) result(f)
        real(pr), dimension(2), intent(in) :: w
        real(pr), dimension(2) :: f

        f(1) = w(2)

        if (w(1)>eps) then
            f(2) = (w(2)*w(2))/w(1) + g/2 * (w(1)*w(1))
        else
            f(2) = 0._pr

        end if
    end function flux_function

    






        
            





end module VF


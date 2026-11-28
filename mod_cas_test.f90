module cas_test

    use parametres
    implicit none

    contains


    subroutine init_rupture_barrage(Nx, x, xb, hL, hR, w, z, z0)
        integer, intent(in) :: Nx
        real(pr), dimension(0:), intent(in) :: x
        real(pr), intent(in) :: xb, hL, hR, z0
        real(pr), dimension(:,0:), intent(out) :: w
        real(pr), dimension(0:), intent(out) :: z
        integer :: i

        do i= 0, Nx+1
            if (x(i)<xb) then
                w(1,i) = hL
            else 
                w(1,i) = hR
            end if
            w(2,i) = 0._pr
            z(i)= z0
        end do

    end subroutine init_rupture_barrage







end module cas_test
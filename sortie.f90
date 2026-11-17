module sortie 

    use parametres
    implicit none

    contains

    subroutine ecrire_resultats(Nx, x, w, z, nom_fichier)
        integer, intent(in) :: Nx
        real(pr), dimension(0:),   intent(in) :: x, z
        real(pr), dimension(:,0:), intent(in) :: w           ! w(1,i)=h, w(2,i)=hu
        character(len=*), intent(in) :: nom_fichier
        real(pr), parameter :: eps = 1.e-12_pr               
        real(pr) :: h, u
        integer  :: i

    open(unit=20, file=nom_fichier, status="replace")
    write(20,'(a)') "#  x   h   u   h+z   z"              

    do i = 1, Nx
       h = w(1,i)
       if (h > eps) then
          u = w(2,i) / h
       else
          u = 0.0_pr                                     
       end if
       write(20,'(5ES16.8)') x(i), h, u, h + z(i), z(i)
    end do

    close(20)
  end subroutine ecrire_resultats



end module sortie 
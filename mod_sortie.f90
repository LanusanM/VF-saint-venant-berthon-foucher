module sortie 

    use parametres
    implicit none

    contains


   subroutine read_param(fichier ,dim, Nx, Ny, xmin, xmax, ymin, ymax, xb, Tmax, CFL, cas, hG, hD, z0)
      integer, intent(out) :: dim, Nx, Ny,cas
      character(len=*), intent(in) :: fichier
      real(pr), intent(out) :: xmin, xmax, ymin, ymax, xb, Tmax, CFL, hG, hD, z0


      open(unit=2,file = fichier)
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
      read(2,*) z0

      close(2)

   end subroutine read_param




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
!==========================================================
! Módulo: inicializar
! Função:
!   - Monta a grade inicial do modelo BML.
!   - Distribui carros aleatoriamente nas direções Leste (1)
!     e Sul (2), com densidade total rho.
!
! Observação:
!   - Executado apenas uma vez → custo baixo → não paralelizar.
!==========================================================
module inicializar
  implicit none
contains

  subroutine InicializarRede(L, rho, rede)
    implicit none

    ! Entrada
    integer, intent(in) :: L
    real(kind=8), intent(in) :: rho

    ! Saída
    integer, intent(out), allocatable :: rede(:,:)

    ! Variáveis internas
    integer :: i, j
    real(kind=8) :: aleatorio

    ! Aloca a grade (LxL)
    if (allocated(rede)) deallocate(rede)
    allocate(rede(L,L))

    ! Distribuição aleatória de veículos
    do j = 1, L
      do i = 1, L
        call random_number(aleatorio)
        if (aleatorio < rho) then
          ! Metade vai para Leste e metade para Sul
          if (aleatorio < rho/2.0d0) then
            rede(i,j) = 1
          else
            rede(i,j) = 2
          end if
        else
          rede(i,j) = 0   ! vazio
        end if
      end do
    end do

  end subroutine InicializarRede
end module inicializar


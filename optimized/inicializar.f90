!==========================================================
! Módulo: inicializar
! Versão final com otimização
! Inicializa a grade do modelo BML
!==========================================================
module inicializar
  implicit none
contains

  subroutine InicializarRede(L, rho, rede)
    implicit none
    !-------------------------------------------------------
    ! Parâmetros de entrada:
    !  L   - tamanho lateral da rede (LxL)
    !  rho - densidade total de veículos (entre 0 e 1)
    ! Saída:
    !  rede - matriz com estados:
    !         0 = célula vazia
    !         1 = veículo indo para Leste
    !         2 = veículo indo para Sul
    !-------------------------------------------------------

    integer, intent(in) :: L
    real(kind=8), intent(in) :: rho
    integer, intent(out), allocatable :: rede(:,:)

    integer :: i, j
    real(kind=8) :: aleatorio

    !-------------------------------------------------------
    ! Aloca a matriz principal
    !-------------------------------------------------------
    if (allocated(rede)) deallocate(rede)
    allocate(rede(L,L))

    !-------------------------------------------------------
    ! Inicializa o gerador de números aleatórios
    !-------------------------------------------------------
    call random_seed()

    !-------------------------------------------------------
    ! Preenche a rede célula a célula
    ! Gera um número aleatório por posição
    !-------------------------------------------------------
    do i = 1, L
      do j = 1, L

        ! Gera um número aleatório entre 0 e 1
        call random_number(aleatorio)

        ! Decide o conteúdo da célula
        if (aleatorio < rho/2.0d0) then
          rede(i,j) = 1      ! veículo indo para Leste
        else if (aleatorio < rho) then
          rede(i,j) = 2      ! veículo indo para Sul
        else
          rede(i,j) = 0      ! célula vazia
        end if

      end do
    end do

  end subroutine InicializarRede

end module inicializar

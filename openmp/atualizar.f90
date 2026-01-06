!==========================================================
! Módulo: atualizar
!
! Ideia HPC:
!   - Movimento de carros deve ser SEQUENCIAL
!     por causa da dependência de dados (modelo BML).
!   - Limpeza de marcadores é independente
!     → paralelizável com OpenMP (speedup real).
!
! Estados:
!   0 = vazio
!   1 = veículo Leste
!   2 = veículo Sul
!==========================================================
module atualizar
  implicit none
contains

  !--------------------------------------------------------
  ! Etapa 1: Movimento Leste → SERIAL
  !--------------------------------------------------------
  subroutine AtualizarLeste(L, rede, movidos)
    integer, intent(in) :: L
    integer, intent(inout) :: rede(L,L)
    integer, intent(out) :: movidos

    integer :: i, j, jp
    movidos = 0

    ! Movimento simultâneo (marcação)
    do j = 1, L
      do i = 1, L
        jp = mod(j, L) + 1
        if (rede(i,j) == 1 .and. rede(i,jp) == 0) then
          rede(i,j)  = 3
          rede(i,jp) = 4
          movidos = movidos + 1
        end if
      end do
    end do

    !----------------------------------------------------
    ! Etapa 2: Limpeza → PARALELA
    !----------------------------------------------------
!$omp parallel do private(i,j) schedule(static)
    do j = 1, L
      do i = 1, L
        if (rede(i,j) == 3) rede(i,j) = 0
        if (rede(i,j) == 4) rede(i,j) = 1
      end do
    end do
!$omp end parallel do

  end subroutine AtualizarLeste


  !--------------------------------------------------------
  ! Movimento Sul (mesma lógica de Leste)
  !--------------------------------------------------------
  subroutine AtualizarSul(L, rede, movidos)
    integer, intent(in) :: L
    integer, intent(inout) :: rede(L,L)
    integer, intent(out) :: movidos

    integer :: i, j, ip
    movidos = 0

    do j = 1, L
      do i = 1, L
        ip = mod(i, L) + 1
        if (rede(i,j) == 2 .and. rede(ip,j) == 0) then
          rede(i,j)  = 3
          rede(ip,j) = 4
          movidos = movidos + 1
        end if
      end do
    end do

!$omp parallel do private(i,j) schedule(static)
    do j = 1, L
      do i = 1, L
        if (rede(i,j) == 3) rede(i,j) = 0
        if (rede(i,j) == 4) rede(i,j) = 2
      end do
    end do
!$omp end parallel do

  end subroutine AtualizarSul

end module atualizar


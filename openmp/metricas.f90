!=========================================================
! Módulo: metricas
! Avaliação 3 - HPC I
! Versão otimizada e paralela (OpenMP)
!=========================================================
module metricas
  implicit none
contains

  !-------------------------------------------------------
  ! Métrica rápida O(1) — NÃO paralelizar
  !-------------------------------------------------------
  subroutine CalcularMetricasRapida(movidos, total_carros_const, vmi)
    integer, intent(in) :: movidos, total_carros_const
    real(kind=8), intent(out) :: vmi

    if (total_carros_const > 0) then
      vmi = real(movidos,8) / real(total_carros_const,8)
    else
      vmi = 0.0_8
    end if
  end subroutine CalcularMetricasRapida


  !-------------------------------------------------------
  ! Cálculo dos Headways — VERSÃO OTIMIZADA
  !-------------------------------------------------------
  subroutine CalcularHeadways(L, rede, shmedio, counts, psh)
    integer, intent(in) :: L
    integer, intent(in) :: rede(L,L)
    real(kind=8), intent(out) :: shmedio
    integer, intent(out) :: counts(L)
    real(kind=8), intent(out) :: psh(L)

    integer :: i, j, dist
    integer :: first_pos, prev_pos, curr_pos
    integer :: total

    counts  = 0
    psh     = 0.0_8
    shmedio = 0.0_8

!-------------------------------------------------------
! Paralelização correta:
! - Cada thread trata linhas independentes
! - Não há allocate/deallocate
! - Um único scan por linha
!-------------------------------------------------------
!$omp parallel do private(i,j,first_pos,prev_pos,curr_pos,dist) reduction(+:counts) schedule(dynamic,4)
    do i = 1, L

      first_pos = -1
      prev_pos  = -1

      do j = 1, L
        if (rede(i,j) == 1) then
          curr_pos = j

          if (first_pos < 0) then
            first_pos = curr_pos
          else
            dist = curr_pos - prev_pos
            if (dist >= 1 .and. dist <= L) counts(dist) = counts(dist) + 1
          end if

          prev_pos = curr_pos
        end if
      end do

      ! Fecha contorno periódico
      if (first_pos >= 0 .and. prev_pos /= first_pos) then
        dist = (first_pos + L) - prev_pos
        if (dist >= 1 .and. dist <= L) counts(dist) = counts(dist) + 1
      end if

    end do
!$omp end parallel do

    !---------------------------------------------------
    ! Normalização e <s>
    !---------------------------------------------------
    total = sum(counts)

    if (total > 0) then
      psh = real(counts,8) / real(total,8)
      shmedio = sum([(real(i,8) * psh(i), i=1,L)])
    else
      psh = 0.0_8
      shmedio = 0.0_8
    end if

  end subroutine CalcularHeadways

end module metricas
!=========================================================


!==========================================================
! Módulo: metricas
! Versão Final Otimizada
! - Evita varredura completa da rede (usa CalcularMetricasRapida)
! - Reduz acessos à memória
! - Vetorização em CalcularHeadways
!==========================================================
module metricas
  implicit none
contains

  !----------------------------------------------------------
  ! Subrotina: CalcularMetricasRapida
  ! Usada durante a simulação para economizar processamento
  !----------------------------------------------------------
  subroutine CalcularMetricasRapida(movidos, total_carros_const, vmi)
    integer, intent(in) :: movidos, total_carros_const
    real(kind=8), intent(out) :: vmi
    if (total_carros_const > 0) then
      vmi = real(movidos,8) / real(total_carros_const,8)
    else
      vmi = 0.0_8
    end if
  end subroutine CalcularMetricasRapida


  !----------------------------------------------------------
  ! Subrotina: CalcularHeadways (otimizada)
  !----------------------------------------------------------
  subroutine CalcularHeadways(L, rede, shmedio, counts, psh)
    integer, intent(in) :: L
    integer, intent(in) :: rede(L,L)
    real(kind=8), intent(out) :: shmedio
    integer, intent(inout) :: counts(L)
    real(kind=8), intent(inout) :: psh(L)

    integer :: i, j, n_veic, dist, total, k
    integer, allocatable :: veiculos(:)

    counts = 0; psh = 0.0_8; total = 0

    do i = 1, L
      n_veic = count(rede(i,:) == 1)
      if (n_veic <= 1) cycle
      allocate(veiculos(n_veic))
      k = 0
      do j = 1, L
        if (rede(i,j) == 1) then
          k = k + 1
          veiculos(k) = j
        end if
      end do
      do j = 1, n_veic
        if (j < n_veic) then
          dist = veiculos(j+1) - veiculos(j)
        else
          dist = (veiculos(1) + L) - veiculos(j)
        end if
        if (dist <= L) then
          counts(dist) = counts(dist) + 1
          total = total + 1
        end if
      end do
      deallocate(veiculos)
    end do

    if (total > 0) then
      psh = real(counts,8) / real(total,8)
      shmedio = sum([(real(i,8)*psh(i), i=1,L)])
    else
      psh = 0.0_8
      shmedio = 0.0_8
    end if
  end subroutine CalcularHeadways

end module metricas


!=========================================================
! Módulo: simular_mod
!
! Dois modos de execução:
!  - write_output = .false. → BENCHMARK HPC
!  - write_output = .true.  → VALIDAÇÃO FÍSICA (VMI e PSh)
!=========================================================
module simular_mod
  use atualizar
  use metricas
  implicit none
contains

  subroutine Simular(L, rede, max_steps, M, eps, write_output)

    implicit none

    !----------------------------
    ! Parâmetros
    !----------------------------
    integer, intent(in) :: L, max_steps, M
    real(kind=8), intent(in) :: eps
    logical, intent(in) :: write_output
    integer, intent(inout) :: rede(L,L)

    !----------------------------
    ! Variáveis internas
    !----------------------------
    integer :: t, movidos, estavel
    integer :: total_carros_const
    integer :: start, finish, rate
    real(kind=8) :: vmi, vmi_ant, elapsed

    ! Métricas físicas (somente se write_output = .true.)
    integer, allocatable :: counts(:)
    real(kind=8), allocatable :: psh(:)
    real(kind=8) :: shmedio

#ifdef _OPENMP
    print *, ">>> OpenMP habilitado."
#else
    print *, ">>> Execucao serial."
#endif

    !----------------------------
    ! Inicializações
    !----------------------------
    vmi_ant = -1.0_8
    estavel = 0
    total_carros_const = count(rede /= 0)

    ! Aloca métricas APENAS se for validação
    if (write_output) then
      allocate(counts(L))
      allocate(psh(L))
      counts = 0
      psh    = 0.0_8
    end if

    !----------------------------
    ! Início da contagem de tempo
    !----------------------------
    call system_clock(start, rate)

    !----------------------------
    ! Loop temporal principal
    !----------------------------
    do t = 1, max_steps

      ! Atualização síncrona do BML
      if (mod(t,2) == 0) then
        call AtualizarLeste(L, rede, movidos)
      else
        call AtualizarSul(L, rede, movidos)
      end if

      ! Velocidade Média Instantânea
      call CalcularMetricasRapida(movidos, total_carros_const, vmi)

      ! Impressão da VMI (SOMENTE para validação)
      if (write_output) then
        write(*,'(I6,1X,F12.8)') t, vmi
      end if

      ! Critério de parada
      if (vmi_ant >= 0.0_8) then
        if (abs(vmi - vmi_ant) < eps) then
          estavel = estavel + 1
          if (estavel >= M) exit
        else
          estavel = 0
        end if
      end if

      vmi_ant = vmi

    end do

    !----------------------------
    ! Tempo total
    !----------------------------
    call system_clock(finish, rate)
    elapsed = real(finish - start, 8) / real(rate, 8)

    write(*,'(A,F12.6)') "Tempo total de execucao (s): ", elapsed

    !----------------------------
    ! Headways (SOMENTE validação)
    !----------------------------
    if (write_output) then
      call CalcularHeadways(L, rede, shmedio, counts, psh)

      write(*,'(A,F12.8)') "Headway medio: ", shmedio

      deallocate(counts, psh)
    end if

  end subroutine Simular

end module simular_mod
!=========================================================

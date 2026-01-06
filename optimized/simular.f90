!==========================================================
! Módulo: simular
! Versão final otimizada
! - Reutiliza total_carros (constante)
! - Calcula métricas rápidas
!==========================================================
module simular_mod
  use atualizar
  use metricas
  implicit none
contains

  subroutine Simular(L, rede, max_steps, M, eps, write_output)
    implicit none
    integer, intent(in) :: L, max_steps, M
    real(kind=8), intent(in) :: eps
    logical, intent(in) :: write_output
    integer, intent(inout) :: rede(L,L)

    integer :: t, movidos, estavel
    integer :: total_carros_const, ios
    integer :: start, finish, rate
    real(kind=8) :: vmi, vmi_ant, elapsed, shmedio
    integer, allocatable :: counts(:)
    real(kind=8), allocatable :: psh(:)
    character(len=256) :: outdir, outfile
    integer :: passo_tipo

    allocate(counts(L)); allocate(psh(L))
    counts = 0; psh = 0.0_8

    vmi_ant = -1.0_8; estavel = 0
    call system_clock(start, rate)

    ! --- total de veículos fixo ---
    total_carros_const = count(rede /= 0)

    do t = 1, max_steps
      passo_tipo = mod(t, 2)
      if (passo_tipo == 0) then
        call AtualizarLeste(L, rede, movidos)
      else
        call AtualizarSul(L, rede, movidos)
      end if

      ! --- cálculo rápido de vmi (sem varrer a rede) ---
      call CalcularMetricasRapida(movidos, total_carros_const, vmi)

      if (vmi_ant >= 0.0_8) then
        if (abs(vmi - vmi_ant) < eps) then
          estavel = estavel + 1
          if (estavel >= M .or. vmi == 0.0_8) exit
        else
          estavel = 0
        end if
      end if
      vmi_ant = vmi
    end do

    call system_clock(finish, rate)
    elapsed = real(finish - start, 8) / real(rate, 8)

    write(outdir, '(A,I0)') "../../Resultados/02_com_opt_manuais/versao_final/L", L
    call execute_command_line("mkdir -p "//trim(outdir))

    write(outfile,'(A,"/tempos.dat")') trim(outdir)
    open(unit=20, file=trim(outfile), status="unknown", position="append", action="write", iostat=ios)
    if (ios == 0) then
      write(20,'(I10,2X,F12.6)') L, elapsed
      close(20)
    end if

    call CalcularHeadways(L, rede, shmedio, counts, psh)
    open(unit=30, file=trim(outdir)//"/sh.dat", status="replace", action="write")
    write(30,'(I6,1X,F10.6)') L, shmedio
    close(30)

    open(unit=40, file=trim(outdir)//"/Psh.dat", status="replace", action="write")
    do t = 1, L
      write(40,'(I6,1X,F10.6)') t, psh(t)
    end do
    close(40)

    if (write_output) then
      write(*,'(A,F10.6)') "Tempo total de execução (s): ", elapsed
    end if

    deallocate(counts); deallocate(psh)
  end subroutine Simular
end module simular_mod


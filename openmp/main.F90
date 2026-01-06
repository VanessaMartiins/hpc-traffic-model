!=========================================================
! Avaliação 3 - HPC I - Código PARALELO (OpenMP)
! Autora: Vanessa Gomes Martins da Silva (UFF)
!----------------------------------------------------------
! Programa principal: trafego_paralelo
!
!   - Lê parâmetros de entrada (params.in)
!   - Inicializa a rede
!   - Executa a simulação paralela (Simular)
!
! Observação:
!   → Este código é SEMPRE paralelo.
!   → Deve ser compilado com:   -fopenmp
!   → O número de threads é controlado via OMP_NUM_THREADS
!=========================================================

program trafego_paralelo

#ifdef _OPENMP
    use omp_lib
#endif

    use inicializar
    use simular_mod
    implicit none

    ! Parâmetros do modelo
    integer :: L, max_steps, M
    real(kind=8) :: rho, eps
    logical :: write_output

    ! Rede do modelo
    integer, allocatable :: rede(:,:)

    ! Leitura de variáveis de ambiente
    character(len=32) :: omp_env

    ! Namelist
    namelist /parametros/ L, rho, max_steps, M, eps, write_output


    !--------------------------------------------------------
    ! Confirmação explícita da execução paralela
    !--------------------------------------------------------
    call get_environment_variable("OMP_NUM_THREADS", omp_env)

#ifdef _OPENMP
    print *, ">>> Executando em modo paralelo."
    print *, ">>> Threads =", omp_get_max_threads()
#else
    print *, ">>> Compilado SEM OpenMP (modo serial)."
#endif


    !--------------------------------------------------------
    ! Leitura dos parâmetros de simulação
    !--------------------------------------------------------
    open(unit=10, file="params.in", status="old", action="read")
    read(10, nml=parametros)
    close(10)

    print *, "Parâmetros carregados:"
    print *, "  L           =", L
    print *, "  rho         =", rho
    print *, "  max_steps   =", max_steps
    print *, "  M (estável) =", M
    print *, "  eps         =", eps
    print *, "  write_output =", write_output


    !--------------------------------------------------------
    ! Inicialização da rede
    !--------------------------------------------------------
    allocate(rede(L,L))
    call InicializarRede(L, rho, rede)


    !--------------------------------------------------------
    ! Execução da simulação paralela
    !--------------------------------------------------------
    call Simular(L, rede, max_steps, M, eps, write_output)


    !--------------------------------------------------------
    ! Liberação e fim
    !--------------------------------------------------------
    deallocate(rede)
    print *, ">>> Simulação paralela concluída com sucesso."

end program trafego_paralelo
!=========================================================

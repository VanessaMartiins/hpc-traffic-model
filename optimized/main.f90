!==========================================================
! Avaliação 2 - HPC I - Código Serial com Otimização
! Autora: Vanessa Gomes Martins da Silva (UFF)
!==========================================================
! Programa principal: trafego 
!==========================================================
program trafego
  use inicializar
  use simular_mod
  implicit none

  integer :: L, max_steps, M
  real(kind=8) :: rho, eps
  logical :: write_output
  integer, allocatable :: rede(:,:)
  namelist /parametros/ L, rho, max_steps, M, eps, write_output

  ! Lê parâmetros do arquivo params.in
  open(unit=10, file="params.in", status="old", action="read")
  read(10, nml=parametros)
  close(10)

  ! Aloca a rede dinamicamente
  allocate(rede(L,L))

  ! Inicializa e simula
  call InicializarRede(L, rho, rede)
  call Simular(L, rede, max_steps, M, eps, write_output)

  deallocate(rede)
end program trafego
!==========================================================

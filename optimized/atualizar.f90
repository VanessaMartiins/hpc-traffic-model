!==========================================================
! Módulo: atualizar
! Versão final - Otimizações completas
! - Reordenação de loops (cache-friendly)
! - Loop unrolling fator 2
! - Remoção de mod()
!==========================================================
module atualizar
  implicit none
contains

  subroutine AtualizarLeste(L, rede, movidos)
    integer, intent(in) :: L
    integer, intent(inout) :: rede(L,L)
    integer, intent(out) :: movidos
    integer :: i, j, jp
    integer :: a1, a2, b1, b2
    integer :: limite

    movidos = 0
    limite = L - mod(L,2)

    do j = 1, L
      jp = j + 1; if (jp > L) jp = 1
      do i = 1, limite, 2
        a1 = rede(i,  j); b1 = rede(i,  jp)
        a2 = rede(i+1,j); b2 = rede(i+1,jp)
        if (a1 == 1 .and. b1 == 0) then
          rede(i,  j)  = -1; rede(i,  jp) = 3; movidos = movidos + 1
        end if
        if (a2 == 1 .and. b2 == 0) then
          rede(i+1,j)  = -1; rede(i+1,jp) = 3; movidos = movidos + 1
        end if
      end do
      if (mod(L,2) /= 0) then
        i = L
        a1 = rede(i,j); b1 = rede(i,jp)
        if (a1 == 1 .and. b1 == 0) then
          rede(i,j) = -1; rede(i,jp) = 3; movidos = movidos + 1
        end if
      end if
    end do

    do j = 1, L
      do i = 1, L
        select case (rede(i,j))
        case (-1); rede(i,j) = 0
        case (3);  rede(i,j) = 1
        end select
      end do
    end do
  end subroutine AtualizarLeste


  subroutine AtualizarSul(L, rede, movidos)
    integer, intent(in) :: L
    integer, intent(inout) :: rede(L,L)
    integer, intent(out) :: movidos
    integer :: i, j, ip1, ip2
    integer :: a1, a2, b1, b2
    integer :: limite

    movidos = 0
    limite = L - mod(L,2)

    ! --- ordem de acesso otimizada (j externo, i interno) ---
    do j = 1, L
      do i = 1, limite, 2
        ip1 = i + 1; if (ip1 > L) ip1 = 1
        ip2 = i + 2; if (ip2 > L) ip2 = ip2 - L

        a1 = rede(i,  j); b1 = rede(ip1,j)
        a2 = rede(i+1,j); b2 = rede(ip2,j)

        if (a1 == 2 .and. b1 == 0) then
          rede(i,  j) = -2; rede(ip1,j) = 4; movidos = movidos + 1
        end if
        if (a2 == 2 .and. b2 == 0) then
          rede(i+1,j) = -2; rede(ip2,j) = 4; movidos = movidos + 1
        end if
      end do

      if (mod(L,2) /= 0) then
        i = L; ip1 = 1
        if (rede(i,j) == 2 .and. rede(ip1,j) == 0) then
          rede(i,j) = -2; rede(ip1,j) = 4; movidos = movidos + 1
        end if
      end if
    end do

    do j = 1, L
      do i = 1, L
        select case (rede(i,j))
        case (-2); rede(i,j) = 0
        case (4);  rede(i,j) = 2
        end select
      end do
    end do
  end subroutine AtualizarSul
end module atualizar


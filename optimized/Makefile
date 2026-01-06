# ============================================================
# Makefile - Avaliação 2 - HPC I
# Versão: Código Serial FINAL (todas otimizações manuais)
# Autora: Vanessa Gomes Martins da Silva (UFF)
# ============================================================

# Compilador Fortran
FC = gfortran

# ------------------------------------------------------------
# Flags de compilação
# ------------------------------------------------------------
# Para executar com:
#   make O0  -> compila SEM otimização do compilador
#   make O2  -> compila COM otimização do compilador (-O2)
# ------------------------------------------------------------

FFLAGS_O0 = -O0 -Wall -fcheck=all -fbacktrace
FFLAGS_O2 = -O2 -march=native -funroll-loops -Wall -fbacktrace

# Nome do executável (definido de acordo com o modo)
EXEC_O0 = trafego_versao_final_O0
EXEC_O2 = trafego_versao_final_O2

# Objetos necessários (cada módulo e o programa principal)
OBJ = inicializar.o atualizar.o metricas.o simular.o main.o

# ============================================================
# Alvo padrão: ajuda
# ============================================================
all:
	@echo "=============================================="
	@echo "Uso:"
	@echo "  make O0    -> Compila sem otimização do compilador"
	@echo "  make O2    -> Compila com otimização (-O2)"
	@echo "  make clean -> Remove arquivos temporários"
	@echo "=============================================="

# ============================================================
# Compilação SEM otimização (-O0)
# ============================================================
O0: $(OBJ)
	$(FC) $(FFLAGS_O0) -o $(EXEC_O0) $(OBJ)
	@echo "✅ Compilação final (O0) concluída!"

# ============================================================
# Compilação COM otimização (-O2)
# ============================================================
O2: $(OBJ)
	$(FC) $(FFLAGS_O2) -o $(EXEC_O2) $(OBJ)
	@echo "✅ Compilação final (O2) concluída!"

# ============================================================
# Compilação dos módulos (ordem de dependência)
# ============================================================
inicializar.o: inicializar.f90
	$(FC) $(FFLAGS_O0) -c inicializar.f90

atualizar.o: atualizar.f90 inicializar.o
	$(FC) $(FFLAGS_O0) -c atualizar.f90

metricas.o: metricas.f90 atualizar.o
	$(FC) $(FFLAGS_O0) -c metricas.f90

simular.o: simular.f90 metricas.o
	$(FC) $(FFLAGS_O0) -c simular.f90

main.o: main.f90 simular.o
	$(FC) $(FFLAGS_O0) -c main.f90

# ============================================================
# Limpeza dos arquivos gerados
# ============================================================
clean:
	rm -f *.o *.mod $(EXEC_O0) $(EXEC_O2) tempos.dat Psh.dat sh.dat gmon.out
	@echo "🧹 Limpeza concluída!"
# ============================================================

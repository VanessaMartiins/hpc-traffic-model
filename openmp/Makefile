# ============================================================
# Makefile - Avaliação 3 - HPC I (UFF)
# Vanessa Gomes Martins da Silva
# Código Serial e Paralelo SEM otimização automática (-O0)
# ============================================================

FC = gfortran

# ------------------------------------------------------------
# Flags de compilação
# ------------------------------------------------------------
FFLAGS_BASE   = -cpp -Wall -fbacktrace -O0 -fno-unroll-loops
FFLAGS_SERIAL = $(FFLAGS_BASE)
FFLAGS_OMP    = $(FFLAGS_BASE) -fopenmp

# ------------------------------------------------------------
# Objetos (serial e paralelo separados)
# ------------------------------------------------------------
OBJS_SERIAL = inicializar_serial.o atualizar_serial.o metricas_serial.o simular_serial.o
OBJS_OMP    = inicializar_omp.o    atualizar_omp.o    metricas_omp.o    simular_omp.o

EXEC_SERIAL = trafego_serial
EXEC_OMP    = trafego_paralelo

# ------------------------------------------------------------
# Alvos principais
# ------------------------------------------------------------
all: serial paralelo

serial: $(EXEC_SERIAL)
paralelo: $(EXEC_OMP)

# ------------------------------------------------------------
# Linking
# ------------------------------------------------------------
$(EXEC_SERIAL): $(OBJS_SERIAL) main_serial.o
	$(FC) $(FFLAGS_SERIAL) -o $@ $(OBJS_SERIAL) main_serial.o

$(EXEC_OMP): $(OBJS_OMP) main_omp.o
	$(FC) $(FFLAGS_OMP) -o $@ $(OBJS_OMP) main_omp.o

# ------------------------------------------------------------
# Compilação dos módulos - VERSÃO SERIAL
# ------------------------------------------------------------
inicializar_serial.o: inicializar.f90
	$(FC) $(FFLAGS_SERIAL) -c $< -o $@

atualizar_serial.o: atualizar.f90 inicializar.f90
	$(FC) $(FFLAGS_SERIAL) -c $< -o $@

metricas_serial.o: metricas.f90 atualizar.f90
	$(FC) $(FFLAGS_SERIAL) -c $< -o $@

simular_serial.o: simular.f90 metricas.f90
	$(FC) $(FFLAGS_SERIAL) -c $< -o $@

main_serial.o: main.F90
	$(FC) $(FFLAGS_SERIAL) -c $< -o $@

# ------------------------------------------------------------
# Compilação dos módulos - VERSÃO PARALELA (OpenMP)
# ------------------------------------------------------------
inicializar_omp.o: inicializar.f90
	$(FC) $(FFLAGS_OMP) -c $< -o $@

atualizar_omp.o: atualizar.f90 inicializar.f90
	$(FC) $(FFLAGS_OMP) -c $< -o $@

metricas_omp.o: metricas.f90 atualizar.f90
	$(FC) $(FFLAGS_OMP) -c $< -o $@

simular_omp.o: simular.f90 metricas.f90
	$(FC) $(FFLAGS_OMP) -c $< -o $@

main_omp.o: main.F90
	$(FC) $(FFLAGS_OMP) -c $< -o $@

# ------------------------------------------------------------
# Limpeza
# ------------------------------------------------------------
clean:
	rm -f *.o *.mod $(EXEC_SERIAL) $(EXEC_OMP)
	@echo "🧹 Limpeza concluída!"

# ------------------------------------------------------------
# Uso:
#   make          -> compila serial e paralelo
#   make serial   -> apenas serial
#   make paralelo -> apenas paralelo
# ------------------------------------------------------------


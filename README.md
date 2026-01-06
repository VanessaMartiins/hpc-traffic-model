# 🚦 Simulação HPC – Modelo de Tráfego (Regra A)

Projeto desenvolvido no contexto da disciplina de **Computação de Alto Desempenho** da  
**Universidade Federal Fluminense (UFF)**, com foco na implementação, otimização e
paralelização de um modelo clássico de tráfego urbano.

---

## 🧠 Descrição do Projeto

Este projeto implementa o **Modelo de Tráfego BML (Regra A)**, que descreve o movimento
coletivo de veículos em uma grade bidimensional \(L \times L\) com condições de contorno
periódicas (topologia de toro).

O objetivo principal foi analisar o comportamento do sistema em função da densidade
de veículos e estudar o desempenho computacional do código por meio de:
- otimização manual,
- análise de complexidade,
- paralelização com **OpenMP**,
- execução em um **cluster HPC real** utilizando **SLURM**.

---

## ⚙️ Tecnologias Utilizadas

- **Fortran 90**
- **OpenMP**
- **SLURM**
- **Bash**
- Ambiente HPC (Cluster Moore – UFF)

---

## 🏗️ Estrutura do Projeto

```text
hpc-traffic-model/
├── src/
│   ├── trafego.f90
│   ├── inicializar.f90
│   ├── simular.f90
│   ├── atualizar.f90
│   └── Makefile
├── scripts/
│   ├── run_serial.sbatch
│   ├── run_omp_4.sbatch
│   ├── run_omp_8.sbatch
│   └── run_omp_16.sbatch
├── params/
│   └── params.in
├── results/
│   └── README.md
├── docs/
│   └── (gráficos de desempenho e speedup)
└── README.md

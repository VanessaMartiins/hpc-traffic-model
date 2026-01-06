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

🚀 Funcionalidades Implementadas

✔️ Versão serial do modelo

✔️ Versão com otimizações manuais (redução de acessos à memória, melhoria de localidade)

✔️ Versão paralela com OpenMP

✔️ Execução automatizada via scripts SLURM

✔️ Benchmarking de tempo de execução

✔️ Análise de speedup e eficiência paralela

📊 Resultados e Análise de Desempenho

Os testes foram realizados para diferentes tamanhos de grade e números de threads.
Os resultados incluem:

-tempo de execução vs. tamanho do problema,
-speedup em função do número de threads,
-análise de eficiência e limitações impostas pela largura de banda de memória.

Os gráficos e dados de saída encontram-se no diretório docs/ e results/.

▶️ Como Compilar e Executar

**Compilação**
cd src
make

**Execução Serial**
sbatch scripts/run_serial.sbatch

**Execução Paralela (exemplo com 16 threads)**
sbatch scripts/run_omp_16.sbatch


**Os parâmetros do modelo (tamanho da grade, densidade, número de passos, etc.)**
podem ser ajustados no arquivo params/params.in.

🎯 Objetivo Acadêmico e Profissional

Este projeto teve como objetivo:

-aplicar conceitos de HPC na prática,
-compreender gargalos reais de desempenho (cache vs. memória),
-desenvolver código científico escalável,
-ganhar experiência com ambiente de cluster, OpenMP e SLURM.

👩‍💻 Autora

Vanessa Gomes Martins da Silva
Graduanda em Física Computacional – UFF

🔗 GitHub: https://github.com/VanessaMartiins

📌 Observações

Este projeto possui caráter acadêmico e foi desenvolvido com fins educacionais,
servindo também como parte do portfólio técnico da autora.

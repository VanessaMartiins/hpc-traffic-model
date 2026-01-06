## 📊 Resultados

### 📈 Speedup Paralelo

![Speedup paralelo](speedup.png)

**Figura 1 –** Figura 1 – Distribuição acumulada dos espaçamentos entre veículos, 𝑃𝑠ℎ(𝑥), no estado estacionário para densidade 
𝜌 = 0,3, comparando a versão sem otimizações (O0) e a versão otimizada (O2). Observa-se que ambas apresentam o mesmo comportamento qualitativo, com pequenas diferenças no regime de espaçamentos curtos, indicando variações sutis na dinâmica de relaxação do sistema decorrentes das otimizações aplicadas.

---

### 🚗 Espaçamento médio ⟨sh⟩ vs densidade ρ

![Espaçamento médio](espacamento_vs_densidade.png)

**Figura 2 –** Espaçamento médio entre veículos, ⟨sh⟩, em função da densidade
\( \rho \) para diferentes tamanhos de grade \( L \). Observa-se a redução do
espaçamento médio com o aumento da densidade, refletindo a transição do regime
de fluxo livre para o regime congestionado.

---

### 🚦 Velocidade média ⟨v⟩ vs densidade ρ

![Velocidade média](velocidade_vs_densidade.png)

**Figura 3 –** Velocidade média dos veículos, ⟨v⟩, em função da densidade
\( \rho \), apresentando comportamento sigmoidal e evidenciando o limiar de
congestionamento do sistema para diferentes tamanhos de grade \( L \).

Os resultados obtidos reproduzem o comportamento esperado do modelo BML,
evidenciando a transição entre os regimes de fluxo livre e congestionado, bem
como os ganhos de desempenho obtidos com a paralelização.


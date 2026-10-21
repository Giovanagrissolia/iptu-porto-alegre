# Medidas e Colunas DAX
## Medidas
### Valor venal total
Soma do valor venal de todos os imóveis, ou seja, o valor que a prefeitura atribui aos imóveis para calcular o IPTU.
```DAX
Valor Venal Total = SUM(iptu[vlr_venal_imovel])
```
### IPTU Total
Soma do valor do IPTU de todos os imóveis.
```DAX
SUM(iptu[vlr_imposto])
```
### Qtd Imóveis
Quantidade total de registros de imóveis na base.
```DAX
Qtd Imóveis = COUNTROWS(iptu)
```

### Alíquota Efetiva
IPTU total dividido pelo valor venal total, considerando todos os imóveis.

```DAX
Alíquota Efetiva =
DIVIDE ( [IPTU Total], [Valor Venal Total] )
```
### Alíquota Efetiva (pagantes)
IPTU total dividido pelo valor venal total, considerando apenas os imóveis com imposto superior a zero.

```DAX
Alíquota Efetiva (pagantes) = 
CALCULATE(
    [Alíquota Efetiva],
    iptu[vlr_imposto]> 0
)
```
### %Imposto zero
Percentual de imóveis com IPTU igual a zero.

```DAX
% Imposto Zero = DIVIDE(CALCULATE([Qtd Imóveis], iptu[vlr_imposto] = 0), [Qtd Imóveis])
```

### Valor m^2 terreno
Valor venal total dos terrenos dividido pela área real total dos imóveis.
```DAX
Valor m² Terreno = 
DIVIDE(
    SUM(iptu[vlr_venal_terreno]),
    SUM(iptu[mtr_area_real])


)
```
### IPTU MEDIANO
Valor mediano do IPTU entre os imóveis da base. 50% dos imóveis possuem IPTU abaixo ou igual à mediana e 50% possuem IPTU acima ou igual a ela.
```DAX
IPTU Mediano = MEDIAN(iptu[vlr_imposto])
```
### IPTU MEDIANO PAGANTES
Valor mediano do IPTU considerando apenas os imóveis com imposto superior a zero.
```DAX
IPTU Mediano (pagantes) = 
CALCULATE(
    MEDIAN(iptu[vlr_imposto]),
    iptu[vlr_imposto] > 0
)
```

### ÍNDICE VALOR VENAL
Compara o valor venal total de cada ano com o de 2022
```DAX
índice Valor Venal = 
VAR AnoBase = 2022
VAR ValorBase =
    CALCULATE(
        [Valor Venal Total],
        ALL( d_calendario[ano_exercicio]),
        d_calendario[ano_exercicio]= AnoBase
    )
RETURN
    DIVIDE( [Valor Venal Total], ValorBase ) * 100
```
### ÍNDICE VALOR m^2 
Compara o valor m^2 terreno total de cada ano com o de 2022
```DAX
VAR AnoBase = 2022
VAR ValorBase =
    CALCULATE(
        [Valor m² Terreno],
        ALL( d_calendario[ano_exercicio]),
        d_calendario[ano_exercicio]= AnoBase
    )
RETURN
    DIVIDE( [Valor m² Terreno], ValorBase ) * 100
```
### ÍNDICE QTDE IMOVEIS
Compara a quantidade total de imóveis de cada ano com o de 2022
```DAX
índice Qtde Imoveis = 
VAR AnoBase = 2022
VAR ValorBase =
    CALCULATE(
        [Qtd Imóveis],
        ALL( d_calendario[ano_exercicio]),
        d_calendario[ano_exercicio]= AnoBase
    )
RETURN
    DIVIDE( [Qtd Imóveis], ValorBase ) * 100
```
### ÍNDICE IPTU TOTAL
Compara o valor do IPTU total de cada ano com o de 2022
```DAX
Índice IPTU Total = 
VAR AnoBase = 2022
VAR ValorBase =
    CALCULATE(
        [IPTU Total],
        ALL( d_calendario[ano_exercicio]),
        d_calendario[ano_exercicio]= AnoBase
    )
RETURN
    DIVIDE( [IPTU Total], ValorBase ) * 100
```
### Variação Acumulada Valor Venal
Mostra quanto o valor venal total de cada ano cresceu, em porcentagem, em relação a 2022
```DAX
Var. Acumulada Valor Venal = [Índice Valor Venal] / 100 - 1
```
### Variação Acumulada Valor m^2 
Mostra quanto o valor do m^2 terreno de cada ano cresceu, em porcentagem, em relação a 2022
```DAX
Var. Acumulada Valor m² = [Índice Valor m² Terreno] / 100 - 1
```
### Variação Acumulada Quantidade de Imóveis
Mostra quanto a quantidade de imóveis de cada ano cresceu, em porcentagem, em relação a 2022
```DAX
Var. Acumulada Qtd Imóveis = [índice Qtde Imoveis] / 100 - 1
```
### Variação Acumulada IPTU TOTAL
Mostra quanto o valor de IPTU de cada ano cresceu, em porcentagem, em relação a 2022
```DAX
Var. Acumulada IPTU Total = [Índice IPTU Total] / 100 - 1
```
### Variação Venal vs Ano Ant
Mostra quanto o valor venal total do ano selecionado cresceu (ou caiu), em porcentagem, em relação ao ano anterior.
```DAX
Var Venal vs Ano Ant = 
VAR AnoAtual = SELECTEDVALUE (d_calendario[ano_exercicio])
VAR ValAtual = [Valor Venal Total]
VAR ValAnt =
    CALCULATE ( [Valor Venal Total], d_calendario[ano_exercicio] = AnoAtual - 1 )
RETURN
    DIVIDE ( ValAtual - ValAnt, ValAnt )
```
### Variação IPTU Mediano vs Ano Ant
Mostra quanto o Iptu mediano do ano selecionado cresceu (ou caiu), em porcentagem, em relação ao ano anterior.
```DAX
Var Iptu mediano vs Ano Ant = 
VAR AnoAtual = SELECTEDVALUE (d_calendario[ano_exercicio])
VAR ValAtual = [IPTU Mediano]
VAR ValAnt =
    CALCULATE ( [IPTU Mediano], d_calendario[ano_exercicio] = AnoAtual - 1 )
RETURN
    DIVIDE ( ValAtual - ValAnt, ValAnt )
```
### Variação IPTU Mediano Pagantes vs Ano Ant
Mostra quanto o Iptu mediano Pagantes (exclui imposto 0) do ano selecionado cresceu (ou caiu), em porcentagem, em relação ao ano anterior.
```DAX
Var IPTU MEDIANO PAGANTES vs Ano Ant = 
VAR AnoAtual = SELECTEDVALUE (d_calendario[ano_exercicio])
VAR ValAtual = [IPTU Mediano (pagantes)]
VAR ValAnt =
    CALCULATE ( [IPTU Mediano (pagantes)], d_calendario[ano_exercicio] = AnoAtual - 1 )
RETURN
    DIVIDE ( ValAtual - ValAnt, ValAnt )
```
### Variação Imposto Zero vs Ano Ant
Mostra quantos pontos percentuais o % de imóveis com imposto zero subiu ou caiu em relação ao ano anterior.
```DAX
Var Imposto Zero p.p. = 
VAR AnoAtual = SELECTEDVALUE ( d_calendario[ano_exercicio])
VAR ValAtual = [% Imposto Zero]
VAR ValAnt =
    CALCULATE ( [% Imposto Zero], d_calendario[ano_exercicio]= AnoAtual - 1 )
RETURN
    ( ValAtual - ValAnt ) * 100
```
### Variação Alíquota vs Ano Ant
Mostra quantos pontos percentuais a alíquota efetiva subiu ou caiu em relação ao ano anterior.
```DAX
Var Alíquota p.p. = 
VAR AnoAtual = SELECTEDVALUE ( d_calendario[ano_exercicio])
VAR ValAtual = [Alíquota Efetiva]
VAR ValAnt =
    CALCULATE ( [Alíquota Efetiva], d_calendario[ano_exercicio] = AnoAtual - 1 )
RETURN
    ( ValAtual - ValAnt ) * 100
```
### Variação Quantidade de Imóveis vs Ano Ant
Mostra quanto a quantidade de imóveis do ano selecionado cresceu (ou caiu), em porcentagem, em relação ao ano anterior.
```DAX
Var Imóveis vs Ano Ant = 
VAR AnoAtual = SELECTEDVALUE (d_calendario[ano_exercicio])
VAR ValAtual = [Qtd Imóveis]
VAR ValAnt =
    CALCULATE ( [Qtd Imóveis], d_calendario[ano_exercicio] = AnoAtual - 1 )
RETURN
    DIVIDE ( ValAtual - ValAnt, ValAnt )
```
### Variação IPTU Total vs Ano Ant
Mostra quanto o valor do IPTU do ano selecionado cresceu (ou caiu), em porcentagem, em relação ao ano anterior.
```DAX
Var Imóveis IPTU vs Ano Ant = 
VAR AnoAtual = SELECTEDVALUE (d_calendario[ano_exercicio])
VAR ValAtual = [IPTU Total]
VAR ValAnt =
    CALCULATE ( [IPTU Total], d_calendario[ano_exercicio] = AnoAtual - 1 )
RETURN
    DIVIDE ( ValAtual - ValAnt, ValAnt )
```
## Colunas calculadas

### Faixa IPTU
Coluna calculada que classifica cada imóvel conforme o valor do IPTU cobrado: isento (R$ 0), até R$ 200, R$ 200 a 500, R$ 500 a 1.000, R$ 1.000 a 5.000 e acima de R$ 5.000.
```DAX
Faixa IPTU = 
SWITCH(
    TRUE(),
    COALESCE(iptu[vlr_imposto],0) = 0, "Isento (R$0)",
    COALESCE(iptu[vlr_imposto],0) <= 200, "Até R$200",
    COALESCE(iptu[vlr_imposto],0) <= 500, "R$200 a 500",
    COALESCE(iptu[vlr_imposto],0) <=1000, "R$500 a 1.000",
   COALESCE(iptu[vlr_imposto],0) <= 5000, "R$1.000 a 5.000",
    "Acima de R$5.000"
)

```
### Ordem Faixa IPTU
Coluna auxiliar que atribui um número de 1 a 6 a cada faixa de IPTU, para o Power BI exibir as faixas na ordem correta nos gráficos.
Ordem Faixa IPTU = 
SWITCH(
    TRUE(),
    iptu[vlr_imposto] = 0, 1,
    iptu[vlr_imposto]<= 200, 2,
    iptu[vlr_imposto]<= 500, 3,
    iptu[vlr_imposto] <= 1000, 4,
    iptu[vlr_imposto] <= 5000, 5,
    6
)

### % dos Imóveis (faixa IPTU) 
Mostra qual percentual do total de imóveis está em cada faixa de IPTU.
% dos Imóveis (faixa IPTU) = 
DIVIDE(
    [Qtd Imóveis],
    CALCULATE(
        [Qtd Imóveis],
        REMOVEFILTERS( iptu[Faixa IPTU]),
        REMOVEFILTERS( iptu[Ordem Faixa IPTU] )
    )
)
### % do IPTU Total (faixa IPTU) 
Mostra qual percentual da arrecadação total de IPTU vem de cada faixa de IPTU.
% do IPTU Total (faixa IPTU) = 
DIVIDE(
    [IPTU Total],
    CALCULATE(
        [IPTU Total],
        REMOVEFILTERS( iptu[Faixa IPTU] ),
        REMOVEFILTERS( iptu[Ordem Faixa IPTU])
    )
)




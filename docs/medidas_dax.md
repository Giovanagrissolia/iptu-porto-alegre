# Medidas DAX

## Valor venal total
Soma do valor venal de todos os imóveis, ou seja, o valor que a prefeitura atribui aos imóveis para calcular o IPTU.
```DAX
Valor Venal Total = SUM(iptu[vlr_venal_imovel])
```
## IPTU Total
Soma do valor do IPTU de todos os imóveis.
```DAX
SUM(iptu[vlr_imposto])
```
## Qtd Imóveis
Quantidade total de registros de imóveis na base.
```DAX
Qtd Imóveis = COUNTROWS(iptu)
```

## Alíquota Efetiva
IPTU total dividido pelo valor venal total, considerando todos os imóveis.

```DAX
Alíquota Efetiva =
DIVIDE ( [IPTU Total], [Valor Venal Total] )
```
## Alíquota Efetiva (pagantes)
IPTU total dividido pelo valor venal total, considerando apenas os imóveis com imposto superior a zero.

```DAX
Alíquota Efetiva (pagantes) = 
CALCULATE(
    [Alíquota Efetiva],
    iptu[vlr_imposto]> 0
)
```
## %Imposto zero
Percentual de imóveis com IPTU igual a zero.

```DAX
% Imposto Zero = DIVIDE(CALCULATE([Qtd Imóveis], iptu[vlr_imposto] = 0), [Qtd Imóveis])
```

## Valor m^2 terreno
Valor venal total dos terrenos dividido pela área real total dos imóveis.
```DAX
Valor m² Terreno = 
DIVIDE(
    SUM(iptu[vlr_venal_terreno]),
    SUM(iptu[mtr_area_real])


)
```
## IPTU MEDIANO
Valor mediano do IPTU entre os imóveis da base. 50% dos imóveis possuem IPTU abaixo ou igual à mediana e 50% possuem IPTU acima ou igual a ela.
```DAX
IPTU Mediano = MEDIAN(iptu[vlr_imposto])
```
## IPTU MEDIANO PAGANTES
Valor mediano do IPTU considerando apenas os imóveis com imposto superior a zero.
```DAX
IPTU Mediano (pagantes) = 
CALCULATE(
    MEDIAN(iptu[vlr_imposto]),
    iptu[vlr_imposto] > 0
)
```

## ÍNDICE VALOR VENAL
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
## ÍNDICE VALOR M^2
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
## ÍNDICE QTDE IMOVEIS
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
## ÍNDICE IPTU TOTAL
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

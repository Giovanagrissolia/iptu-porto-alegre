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


CREATE TABLE iptu_staging (
    ano_exercicio              nvarchar(255),
    num_divisao_fiscal         nvarchar(255),
    nme_endloc_bairro_cdl      nvarchar(255),
    nme_endloc_logradouro      nvarchar(255),
    nme_endloc_cep             nvarchar(255),
    des_uso                    nvarchar(255),
    des_finalidade             nvarchar(255),
    mtr_area_real              nvarchar(255),
    mtr_area_construida_total  nvarchar(255),
    mtr_area_corrigida         nvarchar(255),
    vlr_venal_terreno          nvarchar(255),
    vlr_venal_construcoes      nvarchar(255),
    vlr_venal_imovel           nvarchar(255),
    vlr_aliquota               nvarchar(255),
    vlr_imposto                nvarchar(255),
    vlr_imposto_ufm            nvarchar(255),
    vlr_tcl                    nvarchar(255),
    vlr_tcl_ufm                nvarchar(255)
);

BULK INSERT iptu_staging
FROM 'C:\Porto Alegre\iptu_2026_2.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    CODEPAGE = '65001',
    TABLOCK
);

SELECT
    TRY_CAST(ano_exercicio AS smallint)       AS ano_exercicio,
    TRY_CAST(num_divisao_fiscal AS smallint)  AS num_divisao_fiscal,
    nme_endloc_bairro_cdl,
    nme_endloc_logradouro,
    nme_endloc_cep,
    REPLACE(des_uso, N'NÃ£o', N'Não')         AS des_uso,
    des_finalidade,
    TRY_CAST(REPLACE(mtr_area_real, ',', '.') AS decimal(18,2))             AS mtr_area_real,
    TRY_CAST(REPLACE(mtr_area_construida_total, ',', '.') AS decimal(18,2)) AS mtr_area_construida_total,
    TRY_CAST(REPLACE(mtr_area_corrigida, ',', '.') AS decimal(18,2))        AS mtr_area_corrigida,
    TRY_CAST(REPLACE(vlr_venal_terreno, ',', '.') AS decimal(18,2))         AS vlr_venal_terreno,
    TRY_CAST(REPLACE(vlr_venal_construcoes, ',', '.') AS decimal(18,2))     AS vlr_venal_construcoes,
    TRY_CAST(REPLACE(vlr_venal_imovel, ',', '.') AS decimal(18,2))          AS vlr_venal_imovel,
    TRY_CAST(REPLACE(vlr_aliquota, ',', '.') AS decimal(18,2))              AS vlr_aliquota,
    TRY_CAST(REPLACE(vlr_imposto, ',', '.') AS decimal(18,2))               AS vlr_imposto,
    TRY_CAST(REPLACE(vlr_imposto_ufm, ',', '.') AS decimal(18,4))           AS vlr_imposto_ufm,
    TRY_CAST(REPLACE(vlr_tcl, ',', '.') AS decimal(18,2))                   AS vlr_tcl,
    TRY_CAST(REPLACE(REPLACE(vlr_tcl_ufm, CHAR(13), ''), ',', '.') AS decimal(18,4)) AS vlr_tcl_ufm
INTO iptu
FROM iptu_staging;

--ADCIONAR TABELA 2025 
-- 1. limpa a staging
TRUNCATE TABLE iptu_staging;

-- 2. carrega o CSV do ano 
BULK INSERT iptu_staging
FROM 'C:\Porto Alegre\iptu_2025.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    CODEPAGE = '65001',
    TABLOCK
);

-- 3. converte e empilha na tabela final
INSERT INTO iptu
SELECT
    TRY_CAST(ano_exercicio AS smallint),
    TRY_CAST(num_divisao_fiscal AS smallint),
    nme_endloc_bairro_cdl,
    nme_endloc_logradouro,
    nme_endloc_cep,
    REPLACE(des_uso, N'NÃ£o', N'Não'),
    des_finalidade,
    TRY_CAST(REPLACE(mtr_area_real, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(mtr_area_construida_total, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(mtr_area_corrigida, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_terreno, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_construcoes, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_imovel, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_aliquota, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_imposto, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_imposto_ufm, ',', '.') AS decimal(18,4)),
    TRY_CAST(REPLACE(vlr_tcl, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(REPLACE(vlr_tcl_ufm, CHAR(13), ''), ',', '.') AS decimal(18,4))
FROM iptu_staging;

--ADICIONAR TABELA 2024
-- 1. limpa a staging
TRUNCATE TABLE iptu_staging;

-- 2. carrega o CSV de 2024
BULK INSERT iptu_staging
FROM 'C:\Porto Alegre\iptu_2024.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    CODEPAGE = '65001',
    TABLOCK
);

-- 3. converte e empilha na tabela final
INSERT INTO iptu
SELECT
    TRY_CAST(ano_exercicio AS smallint),
    TRY_CAST(num_divisao_fiscal AS smallint),
    nme_endloc_bairro_cdl,
    nme_endloc_logradouro,
    nme_endloc_cep,
    REPLACE(des_uso, N'NÃ£o', N'Não'),
    des_finalidade,
    TRY_CAST(REPLACE(mtr_area_real, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(mtr_area_construida_total, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(mtr_area_corrigida, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_terreno, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_construcoes, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_imovel, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_aliquota, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_imposto, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_imposto_ufm, ',', '.') AS decimal(18,4)),
    TRY_CAST(REPLACE(vlr_tcl, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(REPLACE(vlr_tcl_ufm, CHAR(13), ''), ',', '.') AS decimal(18,4))
FROM iptu_staging;

--ADICIONAR TABELA 2023
-- 1. limpa a staging
TRUNCATE TABLE iptu_staging;

-- 2. carrega o CSV de 2023
BULK INSERT iptu_staging
FROM 'C:\Porto Alegre\iptu_2023.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    CODEPAGE = '65001',
    TABLOCK
);

-- 3. converte e empilha na tabela final
INSERT INTO iptu
SELECT
    TRY_CAST(ano_exercicio AS smallint),
    TRY_CAST(num_divisao_fiscal AS smallint),
    nme_endloc_bairro_cdl,
    nme_endloc_logradouro,
    nme_endloc_cep,
    REPLACE(des_uso, N'NÃ£o', N'Não'),
    des_finalidade,
    TRY_CAST(REPLACE(mtr_area_real, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(mtr_area_construida_total, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(mtr_area_corrigida, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_terreno, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_construcoes, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_imovel, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_aliquota, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_imposto, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_imposto_ufm, ',', '.') AS decimal(18,4)),
    TRY_CAST(REPLACE(vlr_tcl, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(REPLACE(vlr_tcl_ufm, CHAR(13), ''), ',', '.') AS decimal(18,4))
FROM iptu_staging;

--ADICIONAR TABELA 2022
-- 1. limpa a staging
TRUNCATE TABLE iptu_staging;

-- 2. carrega o CSV de 2022
BULK INSERT iptu_staging
FROM 'C:\Porto Alegre\iptu_2022.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ';',
    CODEPAGE = '65001',
    TABLOCK
);

-- 3. converte e empilha na tabela final
INSERT INTO iptu
SELECT
    TRY_CAST(ano_exercicio AS smallint),
    TRY_CAST(num_divisao_fiscal AS smallint),
    nme_endloc_bairro_cdl,
    nme_endloc_logradouro,
    nme_endloc_cep,
    REPLACE(des_uso, N'NÃ£o', N'Não'),
    des_finalidade,
    TRY_CAST(REPLACE(mtr_area_real, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(mtr_area_construida_total, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(mtr_area_corrigida, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_terreno, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_construcoes, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_venal_imovel, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_aliquota, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_imposto, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(vlr_imposto_ufm, ',', '.') AS decimal(18,4)),
    TRY_CAST(REPLACE(vlr_tcl, ',', '.') AS decimal(18,2)),
    TRY_CAST(REPLACE(REPLACE(vlr_tcl_ufm, CHAR(13), ''), ',', '.') AS decimal(18,4))
FROM iptu_staging;

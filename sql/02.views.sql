CREATE VIEW dim_bairro AS
SELECT 
    ISNULL(NULLIF(LTRIM(RTRIM(nme_endloc_bairro_cdl)), N''), N'Não identificado') AS nme_endloc_bairro_cdl
FROM iptu
GROUP BY ISNULL(NULLIF(LTRIM(RTRIM(nme_endloc_bairro_cdl)), N''), N'Não identificado');

CREATE VIEW dim_uso AS
SELECT 
    ISNULL(NULLIF(LTRIM(RTRIM(des_uso)), N''), N'Não identificado') AS des_uso
FROM iptu
GROUP BY ISNULL(NULLIF(LTRIM(RTRIM(des_uso)), N''), N'Não identificado');

CREATE VIEW d_finalidade AS
SELECT 
    ISNULL(NULLIF(LTRIM(RTRIM(des_finalidade)), N''), N'Não identificado') AS des_finalidade
FROM iptu
GROUP BY ISNULL(NULLIF(LTRIM(RTRIM(des_finalidade)), N''), N'Não identificado');

CREATE VIEW d_divisao_fiscal AS
SELECT num_divisao_fiscal
FROM iptu
GROUP BY num_divisao_fiscal;

CREATE VIEW d_bairro_quartil AS
WITH b AS (
    SELECT nme_endloc_bairro_cdl AS bairro,
           SUM(vlr_venal_terreno) / NULLIF(SUM(mtr_area_real), 0) AS valor_m2
    FROM iptu
    WHERE ano_exercicio = 2026 AND des_uso IS NOT NULL
      AND mtr_area_construida_total > 0 AND nme_endloc_bairro_cdl IS NOT NULL
    GROUP BY nme_endloc_bairro_cdl
    HAVING COUNT(*) >= 200
)
SELECT bairro AS nme_endloc_bairro_cdl,
       valor_m2,
       NTILE(4) OVER (ORDER BY valor_m2) AS quartil
FROM b;

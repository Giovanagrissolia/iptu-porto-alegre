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

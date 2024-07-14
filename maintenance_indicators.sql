
-- 1. Tempo Médio de Operação (MTTO)
SELECT 
    Equipamento,
    AVG(TIMESTAMPDIFF(MINUTE, InicioEvento, FimEvento)) AS MTTO
FROM 
    `Base_de_Dados`
WHERE 
    CodEvento = 264
GROUP BY 
    Equipamento;


-- 2. Tempo Médio de Manutenção Preventiva (MTTMP)
SELECT 
    Equipamento,
    AVG(TIMESTAMPDIFF(MINUTE, InicioEvento, FimEvento)) AS MTTMP
FROM 
    `Base_de_Dados`
WHERE 
    CodEvento = 241 
GROUP BY 
    Equipamento;


-- 3. Tempo Médio de Quebra de Equipamento (MTTQE)
SELECT 
    Equipamento,
    AVG(TIMESTAMPDIFF(MINUTE, InicioEvento, FimEvento)) AS MTTQE
FROM 
    `Base_de_Dados`
WHERE 
    CodEvento = 414 
GROUP BY 
    Equipamento;


-- 4. Disponibilidade de Operação
SELECT 
    Equipamento,
    (SUM(CASE WHEN CodEvento = 264 THEN TIMESTAMPDIFF(MINUTE, InicioEvento, FimEvento) ELSE 0 END) / 
    SUM(TIMESTAMPDIFF(MINUTE, InicioEvento, FimEvento))) * 100 AS Disponibilidade
FROM 
    `Base_de_Dados`
GROUP BY 
    Equipamento;


-- 5. Número de Quebras
SELECT 
    Equipamento,
    COUNT(*) AS NumeroDeQuebras
FROM 
    `Base_de_Dados`
WHERE 
    CodEvento = 414
GROUP BY 
    Equipamento;


-- 6. Número de Manutenções Preventivas
SELECT 
    Equipamento,
    COUNT(*) AS NumeroDeManutencoesPreventivas
FROM 
    `Base_de_Dados`
WHERE 
    CodEvento = 241
GROUP BY 
    Equipamento;


--7. Total de equipamentos
SELECT 
    COUNT(Equipamentos) AS Total_Equipamentos 
FROM 
    `Base_de_Dados`
GROUP BY 
    Equipamento;
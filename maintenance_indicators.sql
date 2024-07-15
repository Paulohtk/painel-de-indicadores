
-- 1. Tempo Médio de Operação (MTTO)
SELECT Equipamento, AVG(DATEDIFF(HOUR, InicioEvento, FimEvento)) AS MTTO FROM eventos  WHERE CodEvento = '264' GROUP BY Equipamento ORDER BY Equipamento;


-- 2. Tempo Médio de Manutenção Preventiva (MTTMP)
SELECT Equipamento, AVG(DATEDIFF(HOUR, InicioEvento, FimEvento)) AS MTTMP FROM eventos WHERE CodEvento = '241' GROUP BY Equipamento;


-- 3. Tempo Médio de Quebra de Equipamento (MTTQE)
SELECT Equipamento, AVG(DATEDIFF(HOUR, InicioEvento, FimEvento)) AS MediaTempoEntreEventos FROM eventos WHERE CodEvento = '414'  GROUP BY Equipamento;

-- 4. Disponibilidade de Operação
SELECT Equipamento, (SUM(CASE WHEN CodEvento = '264' THEN DATEDIFF(HOUR, InicioEvento, FimEvento) ELSE 0 END) /  SUM(DATEDIFF(HOUR, InicioEvento, FimEvento))) * 100 AS Disponibilidade FROM  eventos GROUP BY  Equipamento;


-- 5. Número de Quebras
SELECT Equipamento, COUNT(*) AS NumeroDeQuebras FROM eventos WHERE CodEvento = '414' GROUP BY Equipamento;


-- 6. Número de Manutenções Preventivas
SELECT SUM(NumeroDeManutencoesPreventivas) AS TotalManutencoesPreventivas FROM ( SELECT COUNT(*) AS NumeroDeManutencoesPreventivas FROM eventos WHERE CodEvento = '241'  GROUP BY Equipamento) AS Subquery;


--7. Total de equipamentos
SELECT COUNT(DISTINCT Equipamento) AS TotalEquipamentos FROM eventos;


--8. Calcular taxas de falhas por dia
 SELECT 
    Equipamento,
    COUNT(*) AS QuantidadeFalhas,
    DATEDIFF(day, MIN(CONVERT(DATE, SUBSTRING(InicioEvento, 7, 4) + '-' + SUBSTRING(InicioEvento, 4, 2) + '-' + SUBSTRING(InicioEvento, 1, 2))), MAX(CONVERT(DATE, SUBSTRING(FimEvento, 7, 4) + '-' + SUBSTRING(FimEvento, 4, 2) + '-' + SUBSTRING(FimEvento, 1, 2)))) AS DiasMonitoramento,
        ROUND(COUNT(*) * 100.0 / NULLIF(DATEDIFF(day, MIN(CONVERT(DATE, SUBSTRING(InicioEvento, 7, 4) + '-' + SUBSTRING(InicioEvento, 4, 2) + '-' + SUBSTRING(InicioEvento, 1, 2))), MAX(CONVERT(DATE, SUBSTRING(FimEvento, 7, 4) + '-' + SUBSTRING(FimEvento, 4, 2) + '-' + SUBSTRING(FimEvento, 1, 2)))), 0)) AS TaxaFalhaPorDia
FROM eventos
WHERE CodEvento = '414' AND FimEvento IS NOT NULL
GROUP BY Equipamento
ORDER BY Equipamento


--9. Calcular Tempo de equipamentos com falhas ativos:
Select Equipamento,   ROUND(DATEDIFF(day, DATE(CONVERT(datetime, SUBSTRING(InicioEvento, 7, 4) + '-' + SUBSTRING(InicioEvento, 4, 2) + '-' + SUBSTRING(InicioEvento, 1, 2) + ' ' + SUBSTRING(InicioEvento, 12, 8))), DATE(now()))) as DATA, InicioEvento,
    from eventos
    where FimEvento is null and CodEvento = '414'
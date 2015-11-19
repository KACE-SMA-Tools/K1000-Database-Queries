SELECT COUNT(SMD.ID) as "Launches", SUM(SECONDS_USED)/3600 as "Time Used (hours)", 
MAX(END) as "Last Used",
SVTS.NAME,
VERSION,
MACHINE.NAME as "Computer",
GROUP_CONCAT(DISTINCT(USER_DATA)) AS "Users"

FROM ORG1.SAM_METER_DATA SMD
JOIN MACHINE on SMD.MACHINE_ID = MACHINE.ID
JOIN SAM_VIEW_TITLED_SOFTWARE SVTS on SMD.TITLED_APPLICATION_ID = SVTS.ID
WHERE SVTS.NAME like "%Acrobat%Professional%"
AND END > DATE_SUB(now(), INTERVAL 1 MONTH)
GROUP BY TITLED_APPLICATION_ID, MACHINE_ID

ORDER BY Launches DESC
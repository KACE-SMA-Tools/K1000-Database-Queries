--Pulls data from Dell asset tables
--Uses maximum warranty end date as some machines have multiple warranties
--Restricted to a specific label group 
SELECT LABEL.NAME as "Lab", COUNT(MACHINE.NAME) as Count,
MAX(DW.END_DATE) AS "Warranty End Date"
FROM MACHINE
LEFT JOIN DELL_ASSET DA on MACHINE.BIOS_SERIAL_NUMBER = DA.SERVICE_TAG
LEFT JOIN DELL_WARRANTY DW on MACHINE.BIOS_SERIAL_NUMBER = DW.SERVICE_TAG
JOIN MACHINE_LABEL_JT on MACHINE_LABEL_JT.MACHINE_ID = MACHINE.ID
JOIN LABEL on LABEL.ID = MACHINE_LABEL_JT.LABEL_ID
JOIN LABEL_LABEL_JT on LABEL.ID = LABEL_LABEL_JT.CHILD_LABEL_ID
JOIN LABEL PARENT on PARENT.ID = LABEL_LABEL_JT.LABEL_ID
WHERE MACHINE.CS_MANUFACTURER like 'Dell%'
and PARENT.NAME = "Kaufman Labs"
GROUP BY LABEL.NAME
ORDER BY LABEL.NAME

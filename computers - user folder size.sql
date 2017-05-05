SELECT MACHINE.NAME, 
ROUND(DISK_SIZE, 0) as "Total Disk Available",
ROUND(DISK_USED, 0) as "Total Disk Used",
CASE 
    WHEN MACHINE.OS_NAME like 'Mac%' and MACUS.STR_FIELD_VALUE like "%G%" THEN substring_index(MACUS.STR_FIELD_VALUE, "G", 1)
	WHEN MACHINE.OS_NAME like 'Mac%' and MACUS.STR_FIELD_VALUE like "%M%" THEN round(substring_index(MACUS.STR_FIELD_VALUE, "M", 1)/1000,2)
    WHEN MACHINE.OS_NAME like 'Mic%' THEN round(substring_index(substring(WINUS.STR_FIELD_VALUE, LOCATE("Sum      : ", WINUS.STR_FIELD_VALUE)+ 11), "<br/>", 1)/1000000000, 0)
END as `User Folder Size (G)`

 
FROM MACHINE
LEFT JOIN MACHINE_DISKS D on MACHINE.ID = D.ID and (D.NAME like "Drive / %" or D.NAME like "Drive C:%")
LEFT JOIN MACHINE_CUSTOM_INVENTORY WINUS on MACHINE.ID = WINUS.ID and WINUS.SOFTWARE_ID = 85480
LEFT JOIN MACHINE_CUSTOM_INVENTORY MACUS on MACHINE.ID = MACUS.ID AND MACUS.SOFTWARE_ID = 85481
GROUP BY MACHINE.NAME
HAVING `User Folder Size (G)` > 0

ORDER BY MACHINE.NAME
-- Custom inventory rules contain the admin user groups on computer
-- Report shows the computers that begin with bos (Indicating Bosler Hall)
-- That do not have a specific group listed
SELECT DISTINCT(MACHINE.NAME), MACHINE.OS_NAME, MACHINE.CS_MODEL, MACHINE.CS_MANUFACTURER, SMMP_CONNECTION.CLIENT_CONNECTED,
CASE
    WHEN MACHINE.OS_NAME like 'Mac%' THEN MACADMINS.STR_FIELD_VALUE
    WHEN MACHINE.OS_NAME like '%Win%' THEN REPLACE(SUBSTRING_INDEX(SUBSTRING_INDEX(WINADMINS.STR_FIELD_VALUE, "-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -<br/>", -1), "<br/>The command completed successfully.", 1), "<br/>", ",")
END AS ADMINS
FROM MACHINE
LEFT JOIN MACHINE_CUSTOM_INVENTORY MACADMINS on MACHINE.ID = MACADMINS.ID and MACADMINS.SOFTWARE_ID = 59661
LEFT JOIN MACHINE_CUSTOM_INVENTORY WINADMINS on MACHINE.ID = WINADMINS.ID and WINADMINS.SOFTWARE_ID = 22066
LEFT JOIN KBSYS.SMMP_CONNECTION ON SMMP_CONNECTION.KUID = MACHINE.KUID

WHERE MACHINE.NAME like "bos%" and CLIENT_CONNECTED = 1
HAVING ADMINS not like "%Media%"
ORDER BY MACHINE.NAME

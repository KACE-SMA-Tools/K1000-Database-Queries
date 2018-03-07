--Tracking down an issue where the appliance reported patching ran but the log file was not updated
--Custom inventory rule contained date when the log file was updated
SELECT M.NAME AS Machine, DESCRIPTION AS Schedule, P.LAST_RUN AS 'Schedule Last Run',
MCI.DATE_FIELD_VALUE AS "Patch Log Date"
, K.PHASE AS Phase
, PSMS.PATCHED, PSMS.NOTPATCHED
FROM PATCHLINK_SCHEDULE P
LEFT JOIN KBSYS.KONDUCTOR_TASK K ON P.KONDUCTOR_TASK_TYPE = K.TYPE
LEFT JOIN MACHINE M ON K.KUID = M.KUID
LEFT JOIN PATCHLINK_SCHEDULE_MACHINE_STATUS PSMS ON PSMS.MACHINE_ID = M.ID
JOIN MACHINE_CUSTOM_INVENTORY MCI on MCI.ID = M.ID and MCI.SOFTWARE_ID = 47125
WHERE P.LAST_RUN <> 0
AND DESCRIPTION like '%Patching' or DESCRIPTION = "Patch Production"
AND MCI.DATE_FIELD_VALUE is not null
GROUP BY M.NAME
ORDER BY M.NAME

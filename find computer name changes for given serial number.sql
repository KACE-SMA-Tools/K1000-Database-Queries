-- I must have needed to know how many times this computer has changed its name.
SELECT ASSET.ID, ASSET.NAME, TIME, CHANGE_TYPE, FIELD_NAME, VALUE1, VALUE2
FROM ORG1.ASSET
JOIN ASSET_HISTORY on ASSET_HISTORY.ASSET_ID = ASSET.ID
WHERE ASSET.NAME = "GSV7FZ1"
AND FIELD_NAME = "MACHINE"

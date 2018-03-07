--Finds macOS versions installed in the past day 
--Report scheduled to run daily to inform tech that a new version is available
SELECT SOFTWARE.CREATED, SOFTWARE.DISPLAY_NAME, SOFTWARE.DISPLAY_VERSION, COUNT(MACHINE.ID) AS INSTALLS,
concat("https://kace.dickinson.edu/adminui/software.php?ID=",SOFTWARE.ID) AS LINK
FROM ORG1.SOFTWARE
JOIN MACHINE_SOFTWARE_JT on SOFTWARE.ID = MACHINE_SOFTWARE_JT.SOFTWARE_ID
JOIN MACHINE on MACHINE_SOFTWARE_JT.MACHINE_ID = MACHINE.ID
WHERE DISPLAY_NAME like "Mac OS X%"
AND SOFTWARE.CREATED > DATE_SUB(NOW(), INTERVAL 7 DAY)
GROUP BY SOFTWARE.ID

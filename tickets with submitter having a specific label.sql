select HD_TICKET.ID, 
HD_TICKET.ID as TICKNUM, 
HD_TICKET.TITLE, 
OWNER.USER_NAME as OWNER_NAME, 
DATE_FORMAT(HD_TICKET.CREATED,'%b %d %Y %I:%i:%s %p') as CREATED, 
DATE_FORMAT(HD_TICKET.MODIFIED,'%b %d %Y %I:%i:%s %p') as MODIFIED, 
HD_STATUS.NAME AS STATUS_NAME, 
HD_STATUS.ORDINAL as STATUS_ORDINAL, 
STATE, 
OWNER.FULL_NAME as OWNER_FULLNAME, 
OWNER.EMAIL as OWNER_EMAIL, 
SUBMITTER.USER_NAME as SUBMITTER_NAME, 
SUBMITTER.FULL_NAME as SUBMITTER_FULLNAME, 
SUBMITTER.EMAIL as SUBMITTER_EMAIL,
HD_CATEGORY.CC_LIST AS NEWTICKETEMAIL,
HD_CATEGORY.NAME AS CATEGORY_NAME,
HD_PRIORITY.NAME AS TICKET_PRIORITY,
HD_QUEUE.NAME AS QUEUE_NAME
from ( HD_TICKET, 
HD_PRIORITY, 
HD_STATUS, 
HD_IMPACT, 
HD_CATEGORY)
JOIN USER OWNER on OWNER.ID = HD_TICKET.OWNER_ID
JOIN USER SUBMITTER on SUBMITTER.ID = HD_TICKET.SUBMITTER_ID
LEFT JOIN USER_LABEL_JT on USER_LABEL_JT.USER_ID = SUBMITTER.ID
JOIN LABEL SUBMITTER_LABEL on SUBMITTER_LABEL.ID = USER_LABEL_JT.LABEL_ID
left join HD_QUEUE on HD_QUEUE.ID = HD_TICKET.HD_QUEUE_ID
where HD_PRIORITY.ID = HD_PRIORITY_ID  and 
HD_STATUS.ID = HD_STATUS_ID  and 
HD_IMPACT.ID = HD_IMPACT_ID  and 
HD_CATEGORY.ID = HD_CATEGORY_ID  and
HD_TICKET.TIME_CLOSED = "0000-00-00 00:00:00" and
SUBMITTER_LABEL.NAME = "User Services"


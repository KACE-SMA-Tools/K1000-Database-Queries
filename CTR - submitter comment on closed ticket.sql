-- Ticket Rule SQL Query
-- Triggered on ticket save when commenter is the submitter and ticket is in a closed state
-- submitted as answer for https://www.itninja.com/question/kace-ticket-rule-closed-status-new-comment-reply-to-submitter-ticket-is-closed

select HD_TICKET.ID, 
HD_TICKET.ID as TICKNUM, 
HD_TICKET.TITLE, 
U1.USER_NAME as OWNER_NAME, 
U3.USER_NAME as LASTINPUTNAME,  
DATE_FORMAT(HD_TICKET.CREATED,'%b %d %Y %I:%i:%s %p') as CREATED, 
DATE_FORMAT(HD_TICKET.MODIFIED,'%b %d %Y %I:%i:%s %p') as MODIFIED, 
HD_STATUS.NAME AS STATUS_NAME, 
HD_STATUS.ORDINAL as STATUS_ORDINAL, 
STATE, 
U1.FULL_NAME as OWNER_FULLNAME, 
U1.EMAIL as OWNER_EMAIL, 
U2.USER_NAME as SUBMITTER_NAME, 
U2.FULL_NAME as SUBMITTER_FULLNAME, 
U2.EMAIL as SUBMITTER_EMAIL, 
U3.EMAIL as UPDATEREMAIL, 
U3.FULL_NAME as UPDATERNAME,
U4.FULL_NAME as INITIALNAME,
UNIX_TIMESTAMP(THISCHANGE.TIMESTAMP),
CHANGE.COMMENT,
CHANGE.DESCRIPTION as CHANGE_DESCRIPTION,
INITIAL_CHANGE.COMMENT as INITIAL_COMMENT,
HD_CATEGORY.CC_LIST AS NEWTICKETEMAIL,
HD_CATEGORY.NAME AS CATEGORY_NAME,
U2.WORK_PHONE AS SUBMITTER_WORK_PHONE,
HD_PRIORITY.NAME AS TICKET_PRIORITY,
HD_QUEUE.NAME AS QUEUE_NAME
from ( HD_TICKET, 
HD_PRIORITY, 
HD_STATUS, 
HD_IMPACT, 
HD_CATEGORY)
JOIN HD_TICKET_CHANGE CHANGE ON CHANGE.HD_TICKET_ID = HD_TICKET.ID 
 and CHANGE.ID=<CHANGE_ID>
left join USER U1 on U1.ID = HD_TICKET.OWNER_ID
left join USER U2 on U2.ID = HD_TICKET.SUBMITTER_ID 
left join USER U3 on U3.ID = THISCHANGE.USER_ID 
left join USER U4 on U4.ID = INITIAL_CHANGE.USER_ID
left join HD_QUEUE on HD_QUEUE.ID = HD_TICKET.HD_QUEUE_ID
left JOIN ASSET SUBMITTER_LOCATION on SUBMITTER_LOCATION.ID = U2.LOCATION_ID
where HD_PRIORITY.ID = HD_PRIORITY_ID  and 
HD_STATUS.ID = HD_STATUS_ID  and 
HD_IMPACT.ID = HD_IMPACT_ID  and 
HD_CATEGORY.ID = HD_CATEGORY_ID  and
HD_TICKET.SUBMITTER_ID = CHANGE.USER_ID and
HD_STATUS.STATE = 'closed'
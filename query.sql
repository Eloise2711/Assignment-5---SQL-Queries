SELECT SUM(quantityOnHand) AS totalContainers
FROM item 
WHERE itemDescription LIKE '%antibiotics%';

SELECT volunteerName
FROM volunteer
WHERE (volunteerTelephone NOT LIKE '2%' OR volunteerTelephone IS NULL) 
AND volunteerName NOT LIKE '% Jones';


SELECT DISTINCT volunteer.volunteerName
FROM volunteer
JOIN assignment ON assignment.volunteerId = volunteer.volunteerId
JOIN task ON assignment.taskCode = task.taskCode
JOIN task_type ON task.taskTypeId = task_type.taskTypeId
WHERE task_type.taskTypeName = 'transporting';


SELECT task.taskDescription
FROM task
LEFT JOIN assignment ON assignment.taskCode = task.taskCode
WHERE assignment.volunteerId IS NULL;

SELECT DISTINCT package_type.packageTypeName
FROM package_type
JOIN package ON package.packageTypeId = package_type.packageTypeId
JOIN package_contents ON package_contents.packageId = package.packageId
JOIN item ON package_contents.itemId = item.itemId
WHERE item.itemDescription LIKE '%bottle%';


SELECT item.itemDescription
FROM item
LEFT JOIN package_contents ON package_contents.itemId = item.itemId
WHERE  package_contents.itemId IS NULL;


SELECT DISTINCT task.taskDescription
FROM task
JOIN assignment ON assignment.taskCode = task.taskCode
JOIN volunteer ON assignment.volunteerId = volunteer.volunteerId
WHERE volunteer.volunteerAddress LIKE '%NJ%';


SELECT DISTINCT volunteer.volunteerName
FROM volunteer
JOIN assignment ON assignment.volunteerId = volunteer.volunteerId
WHERE assignment.startDateTime >= '2021-01-01' AND assignment.startDateTime < '2021-07-01';


SELECT DISTINCT volunteer.volunteerName 
FROM volunteer
JOIN assignment ON assignment.volunteerId = volunteer.volunteerId
JOIN package ON assignment.taskCode = package.taskCode
JOIN package_contents ON package_contents.packageId = package.packageId
JOIN item ON package_contents.itemId = item.itemId
WHERE item.itemDescription LIKE '%spam%';


SELECT DISTINCT item.itemDescription
FROM item
JOIN package_contents ON package_contents.itemId = item.itemId
WHERE item.itemValue * package_contents.itemQuantity = 100;


SELECT task_status.taskStatusName AS status,
COUNT(assignment.volunteerId) AS numVolunteers
FROM task_status 
JOIN task ON task.taskStatusId = task_status.taskStatusId
JOIN assignment ON assignment.taskCode = task.taskCode
GROUP BY task_status.taskStatusName
ORDER BY numVolunteers DESC;


SELECT taskCode, SUM(packageWeight) AS totalWeight
FROM package
GROUP BY taskCode
ORDER BY packageWeight DESC
LIMIT 1;


SELECT COUNT(*) AS nonPackingTasks
FROM task 
JOIN task_type ON task.taskTypeId = task_type.taskTypeId
WHERE task_type.taskTypeName NOT LIKE 'packing';

SELECT item.itemDescription
FROM item
JOIN package_contents ON package_contents.itemId = item.itemId
JOIN package ON package_contents.packageId = package.packageId
LEFT JOIN assignment ON package.taskCode = assignment.taskCode
GROUP BY item.itemId, itemDescription
HAVING COUNT(DISTINCT assignment.volunteerId) < 3;

SELECT package_contents.packageId,
SUM(item.itemValue * package_contents.itemQuantity) AS totalValue
FROM package_contents
JOIN item ON package_contents.itemId = item.itemId
GROUP BY package_contents.packageId
HAVING totalValue > 100 
ORDER BY totalValue ASC;




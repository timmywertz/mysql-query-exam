/*
1) Select a distinct list of ordered airports codes.
*/

SELECT departAirport AS Airports
FROM flight
GROUP BY departAirport
ORDER BY departAirport ASC;

/*
2) Provide a list of flights with a delayed status that depart from San Francisco (SFO).
*/

SELECT a.name, f.flightNumber, f.scheduledDepartDateTime, f.arriveAirport, f.status
FROM flight f
JOIN airline a ON f.airlineID = a.ID
WHERE f.status = 'delayed' AND a.name = 'Delta';


/*
3) Provide a distinct list of cities that American Airlines departs from.
*/

SELECT f.departAirport as Cities
FROM flight f
WHERE airlineID = 1
GROUP BY f.departAirport;

/*
4) Provide a distinct list of airlines that conducts flights departing from ATL.
*/

SELECT a.name as Airline
FROM flight f
JOIN airline a ON f.airlineID = a.ID
WHERE departAirport = 'ATL'
GROUP BY Airline;

/*
5) Provide a list of airlines, flight numbers, departing airports, and arrival airports where flights departed on time.
*/

SELECT a.name, f.flightNumber, f.departAirport, f.arriveAirport
FROM flight f
JOIN airline a ON f.airlineID = a.ID
WHERE scheduledDepartDateTime = actualDepartDateTime;

/*
6)Provide a list of airlines, flight numbers, gates, status, and arrival times arriving into Charlotte (CLT) on 10-30-2017. Order your results by the arrival time.
*/

SELECT a.name as Airline, f.flightNumber as Flight, f.gate as Gate, f.scheduledArriveDateTime as Arrival, f.status as Status
FROM flight f
JOIN airline a ON f.airlineID = a.ID
WHERE f.arriveAirport = 'CLT' AND DATE(f.scheduledArriveDateTime) = '2017-10-30'
ORDER BY Arrival;

/*
7) List the number of reservations by flight number. Order by reservations in descending order.
*/

SELECT f.flightNumber, COUNT(r.flightID) as reservations
FROM flight f
JOIN reservation r ON f.ID = r.flightID
GROUP BY f.flightNumber
ORDER BY reservations DESC;

/*
8) List the average ticket cost for coach by airline and route. Order by AverageCost in descending order.
*/

SELECT a.name as Airline, f.departAirport, f.arriveAirport, AVG(r.cost) AS AverageCost
FROM flight f
JOIN airline a ON f.airlineID = a.ID
JOIN reservation r ON f.ID = r.flightID
WHERE r.class = 'coach'
GROUP BY f.arriveAirport
ORDER BY AverageCost DESC;

/*
9) Which route is the longest?
*/

SELECT f.departAirport, f.arriveAirport, f.miles
FROM flight f
ORDER BY f.miles DESC LIMIT 1;


/*
10) List the top 5 passengers that have flown the most miles. Order by miles.
*/

SELECT p.firstName, p.lastName, SUM(f.miles) as miles
FROM flight f
JOIN reservation r ON f.ID = r.flightID
JOIN passenger p ON p.ID = r.passengerID
GROUP BY p.lastName
ORDER BY miles DESC LIMIT 5;

/*
11) Provide a list of American airline flights ordered by route and arrival date and time. Your results must look like this:
*/

SELECT a.name AS Name, CONCAT(f.departAirport,' --> ',f.arriveAirport) AS Route, DATE(f.scheduledArriveDateTime) AS 'Arrive Date', TIME(f.scheduledArriveDateTime) AS 'Arrive Time'
FROM flight f
JOIN airline a ON f.airlineID = a.ID
WHERE Name = 'American'
ORDER BY ROUTE ASC;

/*
12) Provide a report that counts the number of reservations and totals the reservation costs (as Revenue) by Airline, flight, and route. Order the report by total revenue in descending order.
*/

SELECT a.name AS Name, f.flightNumber AS Flight, CONCAT(f.departAirport,' --> ',f.arriveAirport) AS Route, COUNT(r.passengerID) AS "Reservation Count", SUM(r.cost) AS Revenue 
FROM flight f
JOIN airline a ON f.airlineID = a.ID
JOIN reservation r ON f.ID = r.flightID
GROUP BY Flight
ORDER BY Revenue DESC;

/*
13) List the average cost per reservation by route. Round results down to the dollar.
*/

SELECT CONCAT(f.departAirport,' --> ',f.arriveAirport) AS Route, ROUND(AVG(r.cost)) AS "Avg Revenue"
FROM flight f
JOIN airline a ON f.airlineID = a.ID
JOIN reservation r ON f.ID = r.flightID
GROUP BY Route
ORDER BY AVG(r.cost) DESC;

/*
14) List the average miles per flight by airline.
*/

SELECT a.name AS Airline, AVG(f.miles) AS "Avg Miles Per Flight"
FROM flight f
JOIN airline a ON f.airlineID = a.ID
GROUP BY Airline;

/*
15) Which airlines had flights that arrived early?
*/

SELECT a.name AS Airline
FROM flight f
JOIN airline a ON f.airlineID = a.ID
WHERE f.actualArriveDateTime < f.scheduledArriveDateTime
GROUP BY Airline;
CREATE TABLE `tripadvisor` (
	`review_id` varchar(100) not NULL primary key,
	`member_id` varchar(100),
	`hotel_id` varchar(100) not NULL,
	`rating` varchar(10) DEFAULT NULL,
	`recommend_list` tinytext,
	`review_text` text
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DELETE FROM tripadvisor;

INSERT INTO  tripadvisor (
	review_id,
	member_id,
	hotel_id,
	rating,
	recommend_list,
    review_text
)
SELECT review_id, member_id, hotel_id, rating, recommend_list, review_text
FROM review
WHERE member_id IN
    (     SELECT member_id
          FROM review
          WHERE recommend_list !=""
          GROUP BY member_id
          HAVING COUNT(*) >= 5
    )
AND recommend_list !="";

SELECT * FROM tripadvisor;
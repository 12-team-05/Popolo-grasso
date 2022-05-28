CREATE SCHEMA popolo AUTHORIZATION postgres;
CREATE TABLE popolo."topic" (
  topic_id SERIAL PRIMARY KEY,
  "name" TEXT NOT NULL,
  "created_date" timestamp NOT NULL 
);
CREATE TABLE popolo."message" (
  message_id SERIAL PRIMARY KEY,
  topic_id INT NOT NULL REFERENCES popolo."topic",
  "text" TEXT NOT NULL,
  "date" timestamp NOT NULL,
  "user" TEXT
);
create view popolo.forum_topics as 
select t.name, t.created_date, m.*
	from popolo.topic as t
	join (select * 
			from popolo.message 
			order by date 
			desc limit 1) as m on m.topic_id = t.topic_id;

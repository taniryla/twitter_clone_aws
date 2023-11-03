CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	username TEXT NOT NULL UNIQUE,
	email TEXT NOT NULL UNIQUE,
	password TEXT NOT NULL UNIQUE,
	bio TEXT,
    dob DATE,
	profile_img TEXT,
	bg_img TEXT
)

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    post_id INT,
    user_id INT,
    comment TEXT NOT NULL UNIQUE,
    created_on TIMESTAMP
)

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    tweet TEXT NOT NULL UNIQUE,
    stamp TIMESTAMP,
    user_id INT
)

CREATE TABLE retweets (
    id SERIAL PRIMARY KEY,
    tweet_id INT,
    user_id INT,
    retweet_stamp TIMESTAMP,
    retweet_text TEXT NOT NULL UNIQUE
)

CREATE TABLE timelines (
    id SERIAL PRIMARY KEY,
    post_id INT,
    retweet_id INT
)

CREATE TABLE bookmarks (
    id SERIAL PRIMARY KEY,
    post_id INT,
    user_id INT
)

-- 1-to-1 relationship 

ALTER TABLE bookmarks
ADD CONSTRAINT fk_bookmarks_posts
FOREIGN KEY (id)
REFERENCES posts;

-- 1-to-many relationships

ALTER TABLE bookmarks
ADD CONSTRAINT fk_bookmarks_users
FOREIGN KEY (id)
REFERENCES users;

ALTER TABLE comments
ADD CONSTRAINT fk_comments_users
FOREIGN KEY (id)
REFERENCES users;

ALTER TABLE comments
ADD CONSTRAINT fk_comments_posts
FOREIGN KEY (id)
REFERENCES posts;

ALTER TABLE posts
ADD CONSTRAINT fk_posts_users
FOREIGN KEY (id)
REFERENCES users;

ALTER TABLE posts
ADD CONSTRAINT fk_posts_timelines
FOREIGN KEY (id)
REFERENCES timelines;

ALTER TABLE retweets
ADD CONSTRAINT fk_retweets_timelines
FOREIGN KEY (id)
REFERENCES timelines;

ALTER TABLE retweets
ADD CONSTRAINT fk_retweets_posts
FOREIGN KEY (id)
REFERENCES posts;

ALTER TABLE retweets
ADD CONSTRAINT fk_retweets_users
FOREIGN KEY (id)
REFERENCES users;

-- many-to-many relationships

ALTER TABLE retweets
ADD CONSTRAINT fk_retweets_posts
FOREIGN KEY (id)
REFERENCES posts;


-- add in values

INSERT INTO users (id, username, email, password, bio, dob, profile_img, bg_img)
VALUES (1234, 'chako', 'chakoarai7@gmail.com', 'password1', 'Chako lives life better emotionally today than yesterday', '1978-2-27', 'https://scontent-sjc3-1.xx.fbcdn.net/v/t39.30808-6/262038495_106681035184517_3189048512221112770_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=a2f6c7&_nc_ohc=jYuUJoTLhYwAX_gxM1S&_nc_ht=scontent-sjc3-1.xx&oh=00_AfBm3j-5jA47HS4VhUM07JBZns9-Vnm7mk81fJaze1-HJQ&oe=65194048', 'https://i.guim.co.uk/img/media/bdf23d7b1bbb200cf72ae0c22f051bf926445b20/1_0_5075_3046/master/5075.jpg?width=1900&dpr=1&s=none');

INSERT INTO comments (post_id, user_id, comment, created_on)
VALUES (9012, 1234, 'Its a beautiful day in the neighborhood', '2004-10-19 10:23:54')

INSERT INTO posts (tweet, stamp, user_id)
VALUES ('What is today?', '2004-10-19 07:21:51', 1234)

-- create one index

CREATE INDEX posts_btree_index ON posts(tweet);

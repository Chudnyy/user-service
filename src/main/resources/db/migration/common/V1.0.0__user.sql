CREATE TABLE users
(
    first_name    VARCHAR(50)  NOT NULL,
    last_name     VARCHAR(50)  NOT NULL,
    email         VARCHAR(100) NOT NULL,
    sys_create_ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_users_email PRIMARY KEY (email)
)
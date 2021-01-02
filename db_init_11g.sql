
CREATE TABLE audit_events (
    id            INTEGER NOT NULL,
    name          VARCHAR2(32),
    module_id     INTEGER NOT NULL,
    audit_user    INTEGER,
    audit_export  INTEGER
);

ALTER TABLE audit_events ADD CONSTRAINT audit_pk PRIMARY KEY ( id );

CREATE TABLE audit_log (
    id                    INTEGER NOT NULL,
    user_id               INTEGER NOT NULL,
    audit_event_id        INTEGER NOT NULL,
    timestamp             DATE NOT NULL,
    audit_export_success  INTEGER
);

ALTER TABLE audit_log ADD CONSTRAINT audit_log_pk PRIMARY KEY ( id );

CREATE TABLE categories (
    id             INTEGER NOT NULL,
    module_id      INTEGER NOT NULL,
    category_name  VARCHAR2(64) NOT NULL,
    category_user  INTEGER NOT NULL
);

ALTER TABLE categories ADD CONSTRAINT categories_pk PRIMARY KEY ( id );

CREATE TABLE modules (
    id           INTEGER NOT NULL,
    name         VARCHAR2(32) NOT NULL,
    description  VARCHAR2(256) NOT NULL,
    code         VARCHAR2(32) NOT NULL,
    status       INTEGER NOT NULL
);

ALTER TABLE modules ADD CONSTRAINT modules_pk PRIMARY KEY ( id );

CREATE TABLE permissions (
    user_id  INTEGER NOT NULL,
    value    VARCHAR2(32) NOT NULL
);

CREATE TABLE users (
    id        INTEGER NOT NULL,
    username  VARCHAR2(32) NOT NULL,
    password  VARCHAR2(128) NOT NULL,
    email     VARCHAR2(128)
);

ALTER TABLE users ADD CONSTRAINT users_pk PRIMARY KEY ( id );

ALTER TABLE permissions
    ADD CONSTRAINT acl_users_fk FOREIGN KEY ( user_id )
        REFERENCES users ( id )
            ON DELETE CASCADE;

ALTER TABLE audit_events
    ADD CONSTRAINT audit_events_modules_fk FOREIGN KEY ( module_id )
        REFERENCES modules ( id );

ALTER TABLE audit_log
    ADD CONSTRAINT audit_log_audit_events_fk FOREIGN KEY ( audit_event_id )
        REFERENCES audit_events ( id );

ALTER TABLE audit_log
    ADD CONSTRAINT audit_log_users_fk FOREIGN KEY ( user_id )
        REFERENCES users ( id );

ALTER TABLE categories
    ADD CONSTRAINT categories_modules_fk FOREIGN KEY ( module_id )
        REFERENCES modules ( id );

ALTER TABLE categories
    ADD CONSTRAINT categories_users_fk FOREIGN KEY ( category_user )
        REFERENCES users ( id );


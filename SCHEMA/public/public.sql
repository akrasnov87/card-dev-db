CREATE SCHEMA public;

REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO card;
GRANT ALL ON SCHEMA public TO PUBLIC;

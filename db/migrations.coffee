module.exports = (client) ->
  console.log "Running migrations"

  migrations = """
  /* CREATE USER diary_api WITH PASSWORD 'Qk9ti4Bj'; */
  /* CREATE DATABASE diary_api WITH OWNER diary_api; */

  CREATE TABLE IF NOT EXISTS status(
     id         SERIAL PRIMARY KEY,
     message    VARCHAR(140) NOT NULL,
     created_at DATE NOT NULL DEFAULT now()::date,
     updated_at DATE NOT NULL DEFAULT now()::date
  );

  CREATE TABLE IF NOT EXISTS tags(
     id         SERIAL PRIMARY KEY,
     name       VARCHAR(140) NOT NULL,
     created_at DATE NOT NULL DEFAULT now()::date,
     updated_at DATE NOT NULL DEFAULT now()::date
  );

  CREATE TABLE IF NOT EXISTS status_tags(
     id           SERIAL PRIMARY KEY,
     status_id    INTEGER REFERENCES status ON DELETE CASCADE,
     tag_id       INTEGER REFERENCES tags   ON DELETE CASCADE,
     created_at DATE NOT NULL DEFAULT now()::date,
     updated_at DATE NOT NULL DEFAULT now()::date
  );

  """

  client.query migrations, (error, result) =>
      throw error if error



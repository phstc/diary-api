BaseModel = require "./base_model"

module.exports = class Status extends BaseModel
  @find: (id, callback) ->
    process.dbClient.query """
     SELECT * FROM status WHERE id = $1
    """, [id], (error, result) =>
      callback.call new Status(result.rows[0]), error

  @all: (callback) ->
    process.dbClient.query """
     SELECT * FROM status
    """, [], (error, result) =>
      statuses = []
      statuses.push new Status(attributes) for attributes in result.rows
      callback.call statuses, error

  update: (callback) ->
    process.dbClient.query """
      UPDATE status SET message = $1, updated_at = $2 WHERE id = $3
    """, [@get("message"), new Date, @get("id")], (error, result) =>
      callback.call @, error

  insert: (callback) ->
    query = process.dbClient.query """
      INSERT INTO status (message) VALUES ($1) RETURNING id
    """, [@get("message")], (error, result) =>
      @set "id", result.rows[0].id unless error
      callback.call @, error

  destroy: (callback) ->
    query = process.dbClient.query """
      DELETE FROM status WHERE id = $1
    """, [@get("id")], (error, result) =>
      callback.call @, error


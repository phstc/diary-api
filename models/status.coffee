BaseModel = require "./base_model"

module.exports = class Status extends BaseModel
  @find: (client, id, callback) ->
    client.query """
     SELECT * FROM status WHERE id = $1
    """, [id], (error, result) =>
      callback.call new Status(client, result.rows[0]), error

  @all: (client, callback) ->
    client.query """
     SELECT * FROM status
    """, [], (error, result) =>
      statuses = []
      statuses.push new Status(@client, attributes) for attributes in result.rows
      callback.call statuses, error

  update: (callback) ->
    @client.query """
      UPDATE status SET message = $1, updated_at = $2 WHERE id = $3
    """, [@get("message"), new Date, @get("id")], (error, result) =>
      callback.call @, error

  insert: (callback) ->
    query = @client.query """
      INSERT INTO status (message) VALUES ($1) RETURNING id
    """, [@get("message")], (error, result) =>
      @set "id", result.rows[0].id unless error
      callback.call @, error

  destroy: (callback) ->
    query = @client.query """
      DELETE FROM status WHERE id = $1
    """, [@get("id")], (error, result) =>
      callback.call @, error


express = require "express"
routes = require "./routes"
user = require "./routes/user"
http = require "http"
path = require "path"
pg = require "pg"

client = new pg.Client "tcp://diary_api:Qk9ti4Bj@localhost/diary_api"

client.connect (error) ->
  console.log error if error

require("./db/migrations")(client)

class BaseModel
  constructor: (@attributes={}) ->
    @fillAttributes @attributes

  save: (callback) ->
    if @get("id") then @update(callback) else @insert(callback)

  set: (attribute, value) ->
    @attributes[attribute] = value

  get: (attribute) ->
    @attributes[attribute]

  fillAttributes: (attributes) ->
    for attribute in attributes
      @set attribute, attributes[attribute]

class Status extends BaseModel
  load: (callback) ->
    client.query """
     SELECT * FROM status WHERE id = $1
    """, [@get("id")], (error, result) =>
      throw error if error
      @fillAttributes result.rows[0]
      callback @

  update: (callback) ->
    client.query """
      UPDATE status SET message = $1, updated_at = $2 WHERE id = $3
    """, [@get("message"), new Date, @get("id")], (error, result) =>
      throw error if error
      callback @

  insert: (callback) ->
    query = client.query """
      INSERT INTO status (message) VALUES ($1) RETURNING id
    """, [@get("message")], (error, result) =>
      throw error if error
      @set "id", result.rows[0].id
      callback @

app = express()

app.configure ->
  app.set "port", process.env.PORT || 3000
  app.set "views",  "#{__dirname}/views"
  app.set "view engine", "jade"
  app.use express.favicon()
  app.use express.logger("dev")
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(__dirname, "public"))

app.configure "development", ->
  app.use express.errorHandler()

app.get "/", (req, res) ->
   new Status(message: "Hello World").save (status) ->
     console.log status.attributes
     status2 = new Status(status.attributes).load (status2) ->
       console.log(status2.attributes)
   routes.index req, res

app.get "/users", user.list

(http.createServer app).listen app.get("port"), ->
  console.log "Express server listening on port #{app.get("port")}"


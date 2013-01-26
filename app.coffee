express = require "express"
http = require "http"
path = require "path"
pg = require "pg"
Status = require "./models/status"

client = new pg.Client "tcp://diary_api:Qk9ti4Bj@localhost/diary_api"

client.connect (error) ->
  throw error if error

require("./db/migrations")(client)

statuses = require("./routes/statuses")(client)

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

# curl -i -X POST -d "message=Hello World" http://localhost:3000/statuses
app.post "/statuses", statuses.create

# curl -i -X PUT -d "message=Hello Pablo" http://localhost:3000/statuses/{id}
app.put "/statuses/:id", statuses.update

# curl -i -X GET http://localhost:3000/statuses/{id}
app.get "/statuses/:id", statuses.show

# curl -i -X GET http://localhost:3000/statuses
app.get "/statuses", statuses.index

# curl -i -X DELETE http://localhost:3000/statuses/{id}
app.delete "/statuses/:id", statuses.destroy

(http.createServer app).listen app.get("port"), ->
  console.log "Express server listening on port #{app.get("port")}"


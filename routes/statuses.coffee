Status = require "../models/status"

module.exports = (client) ->
  create: (req, res) ->
    status = new Status client, message: req.body.message
    status.save (error) ->
      res.status if error then 422 else 201
      res.json @attributes

  update: (req, res) ->
    Status.find client, req.params.id, (error) ->
      if error
        res.status 404; res.end; return
      @set "message", req.body.message
      @save (error) ->
        res.status if error then 422 else 204
        res.json @attributes

  show: (req, res) ->
    Status.find client, req.params.id, (error) ->
      res.status if error then 404 else 200
      res.json @attributes

  index: (req, res) ->
    Status.all client, (error) ->
      statuses = []
      statuses.push status.attributes for status in @
      res.status 200
      res.json statuses

  destroy: (req, res) ->
    Status.find client, req.params.id, (error) ->
      if error
        res.status 404; res.end; return
      @destroy (error) ->
        res.status 204
        res.json @attributes

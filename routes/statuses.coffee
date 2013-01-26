Status = require "../models/status"

module.exports.create = (req, res) ->
  status = new Status message: req.body.message
  status.save (error) ->
    res.status if error then 422 else 201
    res.json @attributes

module.exports.update = (req, res) ->
  Status.find req.params.id, (error) ->
    if error
      res.status 404; res.end; return
    @set "message", req.body.message
    @save (error) ->
      res.status if error then 422 else 204
      res.json @attributes

module.exports.show = (req, res) ->
  Status.find req.params.id, (error) ->
    res.status if error then 404 else 200
    res.json @attributes

module.exports.index = (req, res) ->
  Status.all (error) ->
    statuses = []
    statuses.push status.attributes for status in @
    res.status 200
    res.json statuses

module.exports.destroy = (req, res) ->
  Status.find req.params.id, (error) ->
    if error
      res.status 404; res.end; return
    @destroy (error) ->
      res.status 204
      res.json @attributes

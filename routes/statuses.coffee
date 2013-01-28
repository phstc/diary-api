Status = require "../models/status"

module.exports.create = (req, res) ->
  status = new Status message: req.body.message
  status.save (result, error) ->
    if error
      res.status 422; res.end(); return
    res.status 201
    res.json result.attributes

module.exports.update = (req, res) ->
  Status.find req.params.id, (result, error) ->
    unless result
      res.status 404; res.end(); return
    result.set "message", req.body.message
    result.save (result, error) ->
      if error
        res.status 422; res.end(); return
      res.status 204
      res.end()

module.exports.show = (req, res) ->
    Status.find req.params.id, (result, error) ->
      unless result
        res.status 404; res.end(); return
      res.status 200
      res.json result.attributes

module.exports.index = (req, res) ->
  Status.all (result, error) ->
    statuses = []
    statuses.push status.attributes for status in result
    res.status 200
    res.json statuses

module.exports.destroy = (req, res) ->
  Status.find req.params.id, (result, error) ->
    unless result
      res.status 404; res.end(); return
    result.destroy (result, error) ->
      res.status 204
      res.end()

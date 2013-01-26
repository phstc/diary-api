module.exports = class BaseModel
  constructor: (@client, @attributes={}) ->
    @fillAttributes @attributes

  save: (callback) ->
    if @get("id") then @update(callback) else @insert(callback)

  set: (attribute, value) ->
    @attributes[attribute] = value

  get: (attribute) ->
    @attributes[attribute]

  fillAttributes: (attributes) ->
    for attribute of attributes
      @set attribute, attributes[attribute]

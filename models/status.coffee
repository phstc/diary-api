
# Cat = mongoose.model "Cat", schema

# kitty = new Cat name: "Zildjian"
# kitty.save (err) ->
  # console.log "meow" if (err)

module.exports = (mongoose) ->
  schema = mongoose.Schema message: "string"

  mongoose.model "Status", schema

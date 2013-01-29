process.env.NODE_ENV = "test"

request = require "superagent"

describe "#statuses", ->
  describe "#create", ->
    it "should create a status", (done) ->
      request
        .post("http://localhost:3000/statuses")
        .send(message: "Hello World")
        .set("Accept", "application/json")
        .end (res) ->
          res.body.message.should.eql "Hello World"
          res.status.should.eql 201
          done()

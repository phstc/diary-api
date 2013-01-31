process.env.NODE_ENV = "test"

pg = require "pg"
connectionString = "tcp://diary_api:Qk9ti4Bj@localhost/diary_api"
pg.connect connectionString, (error, client) ->
  throw error if error
  process.dbClient = client

Status = require "../../models/status"

request = require "superagent"

describe "#statuses", ->
  describe "#create", ->
    it "creates successfully", (done) ->
      request
        .post("http://localhost:3000/statuses")
        .send(message: "Hello World")
        .set("Accept", "application/json")
        .end (res) ->
          res.body.message.should.eql "Hello World"
          res.status.should.eql 201
          done()

    it "rejects when message is not present", (done) ->
      request
        .post("http://localhost:3000/statuses")
        .set("Accept", "application/json")
        .end (res) ->
          res.body.should.eql {}
          res.status.should.eql 422
          done()

  describe "#update", ->
    it "updates successfully", (done) ->
      status = new Status message: "Hello World"
      status.save (result, error) ->
        request
          .put("http://localhost:3000/statuses/#{result.attributes.id}")
          .send(message: "Hello again")
          .set("Accept", "application/json")
          .end (res) ->
            res.body.should.eql {}
            res.status.should.eql 204
            done()

    it "rejects when message is not present", (done) ->
      status = new Status message: "Hello World"
      status.save (result, error) ->
        request
          .put("http://localhost:3000/statuses/#{result.attributes.id}")
          .set("Accept", "application/json")
          .end (res) ->
            res.body.should.eql {}
            res.status.should.eql 422
            done()

  describe "#destroy", (done) ->
    it "destroys an status", (done) ->
      status = new Status message: "Hello World"
      status.save (result, error) ->
        request
          .del("http://localhost:3000/statuses/#{result.attributes.id}")
          .set("Accept", "application/json")
          .end (res) ->
            res.body.should.eql {}
            res.status.should.eql 204
            done()

    it "rejects when not found", (done) ->
      request
        .del("http://localhost:3000/statuses/999999999999")
        .set("Accept", "application/json")
        .end (res) ->
          res.body.should.eql {}
          res.status.should.eql 404
          done()

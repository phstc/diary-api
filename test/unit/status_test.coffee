# Status = require "../../app/models/status"

# describe "Status", ->
    # describe "#tags", ->
      # it "has no tags", ->
        # status = new Status "test1"
        # status.tags.should.be.empty

      # it "has tags", ->
        # status = new Status "test1 #test2 test3 #test4"
        # status.tags.should.eql ["#test2", "#test4"]

      # it "has unique tags", ->
        # status = new Status "#test2 #test2 test2 #test4"
        # status.tags.should.eql ["#test2", "#test4"]

      # it "accepts tags with accents", ->
        # status = new Status "#tést2 #táçãóéíúãÊ #TÉ"
        # status.tags.should.eql ["#tést2", "#táçãóéíúãÊ", "#TÉ"]

     # describe "#message", ->
       # it "sets a message", ->
         # status = new Status "Hello World #goodday"
         # status.message.should.eql "Hello World #goodday"


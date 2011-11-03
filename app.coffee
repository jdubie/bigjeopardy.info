express = require 'express'
cradle  = require 'cradle'
combo   = require 'combo'

nano = require('nano')('http://admin:admin@localhost:5984')
db = nano.use 'somacentral'

app = module.exports = express.createServer()


# Configuration

app.configure ->
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static __dirname + '/public'

app.configure 'development', ->
  app.use express.errorHandler
    dumpExceptions: true
    showStack: true

app.configure 'production', ->
  app.use express.errorHandler()


# Routes
app.get '/', (req,res) ->
  res.render 'home'

app.get '/flyer', (req,res) ->
  res.render 'flyer'


app.listen 3000

console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
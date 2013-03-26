http = require 'http'
path = require 'path'
express = require 'express'

next = (err)->
	console.error err.message
	process.exit 1

app = express()
app.configure ->
	app.set 'view engine', 'ejs'
	app.set 'views', path.join __dirname, 'views'
	app.use express.logger 'dev'
	app.use express.static path.join __dirname, 'public'
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router

app.get '/', (req, res, next)->
	res.render 'index'

server = http.createServer app
server.listen 8080, '127.0.0.1', (err)->
	return next err if err
	console.log 'All done, have fun!'

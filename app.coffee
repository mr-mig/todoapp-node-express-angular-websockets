express = require("express.io")
setupRoutes = require("./routes")
http = require("http")
path = require("path")
home = require('./controllers/home')
app = express()

auth = require('./auth')
passport = require('passport')

app.set "port", process.env.PORT or 3000
app.set "views", path.join(__dirname, "views")
app.set "view engine", "jade"

app.use express.favicon()
app.use express.json()
app.use express.urlencoded()
app.use express.methodOverride()
app.use express.cookieParser()
app.use express.bodyParser()

app.use express.session
	secret: 'somesesi1onSikrit09#123'
app.use passport.initialize();
app.use passport.session();

app.use app.router
app.use express.static(path.join(__dirname, "public"))

auth.configure()

# development only
app.use express.errorHandler()  if "development" is app.get("env")
#run io server
app.http().io()
#auth.configureIO()


#setup all routes
setupRoutes app

app.listen app.get("port"), ->
	console.log "HTTP server listening on port " + app.get("port")

#redirect all request to single page
app.use(home)

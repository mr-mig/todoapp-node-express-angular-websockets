# Preface
This TODO app is a hackathon result.

Development time: 24h in total

**This is not a full-fledged project and won't be supported.**

# Technologies
* Node.js
* Express.js
* Passport.js
* Express.io
* Angular
* CoffeeScript

If you will look inside, please bear in mind that the 1st priority was a **development speed**, and not best practices!
That's why the project has some **opinionated decisions** (the lack of database is one of them).

# Hot to run

1. Install node.js and npm (`sudo apt-get install nodejs npm -y`)
2. cd to project dir
3. run `npm install`
4. run `npm start`
5. server is available at `http://localhost:3000/`

There is an upstart config to run the project on ubuntu machine as a daemon.
And a simple bash script to upload the project to the host machine.

# API
The API is secured with token-based authentication.
The example URL is: `http://localhost:3000/api/create?access_token=<token>`

'get /api/list' - get all todos for the user
'post /api/create' - create a todo
'delete /api/delete/:id' - delete a todo
'post /api/update/:id' - update a todo
'post /api/input' - create a todo using parseable input, e.g `something__2d 1` (there are two spaces between title and date)

All post request must contain json payload:

```javascript
{
"title" : "blabla",
"id" : "can be empty or Integer",
"date" : 1388458223758,
"priority" : 1,
"done" : false
}
```

# Websockets
There is websocket support with realtime UI update.
You can try updating the user's todo list via REST API and watch simultaneous updates in browser.

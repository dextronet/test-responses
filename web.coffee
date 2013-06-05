http = require 'http'
url = require 'url'
fs = require 'fs'

responser = (request, response) ->
  query = url.parse(request.url, true).query

  status = query.status || 200

  serveFile = (file) ->
    fs.stat file, (err, stat) ->
      response.writeHead status, 'Content-Length': stat.size
      stream = fs.createReadStream file
      stream.pipe response

  if query.respond
    if match = query.respond.match /([0-9]{1,3})s/
      setTimeout ->
        response.writeHead status
        response.end()
      , parseInt(match[1]) * 1000
    else if match = query.respond.match /([0-9]{1,3})m/
      file = "files/" + match[0]
      size = parseInt(match[1])
      baseFile = "files/1m"
      fs.exists file, (exists) ->
        if exists
          serveFile file
        else
          fs.readFile baseFile, (err, data) ->
            data = new Array(size + 1).join(data)
            fs.writeFile file, data, ->
              serveFile file

    return

  response.writeHead status
  response.end()

port = process.env.PORT || 5000
http.createServer(responser).listen port
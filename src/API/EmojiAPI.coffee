###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

HTTPS = require "https"
Cache = require "./EmojiCache"

exports.queryAPI = (Endpoint, Callback, pResolve, pReject) ->
    this.contactAPI Endpoint, (Error, Result) ->
        if Error
            if typeof Callback == "function"
                Callback Error

                pReject Error

        if typeof Callback == "function"
            Callback null, JSON.parse Result[0]

        pResolve JSON.parse Result

exports.contactAPI = (Endpoint, Callback) ->
    try
        Stores = {
            "https://discordemoji.com/api": "/Emoji",
            "https://discordemoji.com/api/packs": "/Packs",
            "https://discordemoji.com/api/?request=stats": "/Stats"
        }

        Key = Cache.getCache Stores[Endpoint]

        if !Key
            HTTPS.get Endpoint, (Response) ->
                Error   = ""
                rawData = ""

                Code = Response.statusCode
                Type = Response.headers["content-type"]

                if Code != 200
                    Error = "# [DEmojiJS] Could not issue request @ " + Endpoint

                if Error
                    Response.resume()
                    Callback Error

                Response.setEncoding "utf8"

                Response.on "data", (Buffer) ->
                    rawData += JSON.parse JSON.stringify Buffer

                Response.on "end", () ->
                    try
                        Data = rawData

                        Cache.setCache Stores[Endpoint], Data
                    catch E
                        throw E

                    Callback Error, Data
        else
            Callback null, Key
    catch E
        throw E

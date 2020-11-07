###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

HTTPS = require "https"
Cache = require "./EmojiCache"

exports.GrabCategories = () ->
    if !Cache.getCache "/Categories"
        this.contactAPI "https://emoji.gg/api/?request=categories", (Error, Data) ->
            if Error
                throw Error

exports.contactAPI = (Endpoint, Callback) ->
    try
        Stores = {
            "https://emoji.gg/api/": "/Emoji",
            "https://emoji.gg/api/packs": "/Packs",
            "https://emoji.gg/api/?request=stats": "/Stats",
            "https://emoji.gg/api/?request=categories": "/Categories"
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

                    Callback Error, JSON.parse Data
        else
            Callback null, JSON.parse Key
    catch E
        throw E

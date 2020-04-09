###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabRandom
    constructor: (Input, Callback) ->
        return new Promise (Resolve, Reject) ->
            API.contactAPI "https://discordemoji.com/api/", (Error, Data) ->
                if Error then Reject Error

                if Input
                    Cats  = []
                    Store = []

                    for e in Data
                        if typeof Input != "boolean"
                            API.contactAPI "https://discordemoji.com/api/?request=categories", (Error, Categories) ->
                                if Error
                                    throw Error

                                # Store all categories in lowercase.
                                for c in Object.keys Categories
                                    Cats[c] = Categories[c].toLowerCase()

                            if Cats[e["category"]] == Input.toLowerCase()
                                Store.push e

                        if typeof Input == "boolean" && Input != false
                            if e["image"].includes ".gif"
                                Store.push e

                    Resolve Store[Math.floor Math.random() * Store.length + 1]
                else
                    Resolve Data[Math.floor Math.random() * Object.keys(Data).length + 1]
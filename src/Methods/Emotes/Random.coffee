###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabRandom
    constructor: (GIF, Callback) ->
        return new Promise (Resolve, Reject) ->
            API.contactAPI "https://discordemoji.com/api/", (Error, Data) ->
                if Error then Reject Error

                Index = Math.floor Math.random() * Object.keys(Data).length + 1
                
                if GIF
                    Store = []

                    for e in Data
                        if e["image"].includes ".gif"
                            Store.push e

                    Resolve Store[Math.floor Math.random() * Store.length + 1]
                else Resolve Data[Math.floor Math.random() * Object.keys(Data).length + 1]

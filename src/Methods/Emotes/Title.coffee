###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabTitle
    constructor: (Title, Callback) ->
        return new Promise (Resolve, Reject) ->
            if typeof Title != "string"
                Reject "# [DEmojiJS] Emote title has to be a string."

            API.contactAPI "https://discordemoji.com/api/", (Error, Data) ->
                if Error then Reject Error

                i = 0
                while i < Object.keys(Data).length
                    if Data[i]["title"] == Title
                        Resolve Data[i]

                    i++
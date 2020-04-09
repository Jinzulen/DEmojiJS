###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabID
    constructor: (ID, Callback) ->
        return new Promise (Resolve, Reject) ->
            if typeof ID != "number"
                Reject "# [DEmojiJS] Emote ID has to be a number."

            API.contactAPI "https://discordemoji.com/api/", (Error, Data) ->
                if Error then Reject Error

                i = 0
                while i < Object.keys(Data).length
                    if Data[i]["id"] == ID
                        Resolve Data[i]

                    i++
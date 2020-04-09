###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabTitle
    constructor: (Title, Callback) ->
        return new Promise (Resolve, Reject) ->
            if !Title then Reject "# [DEmojiJS] Please enter an emote title to continue."
            
            if typeof Title != "string"
                Reject "# [DEmojiJS] Emote title has to be a string."

            API.contactAPI "https://discordemoji.com/api/", (Error, Data) ->
                if Error then Reject Error

                i = 0
                while i < Object.keys(Data).length
                    # Get rid of case sensitivity.
                    Data[i]["title"] = Data[i]["title"].toLowerCase()

                    if Data[i]["title"] == Title.toLowerCase()
                        Resolve Data[i]

                    i++
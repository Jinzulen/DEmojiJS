###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabSlug
    constructor: (Slug, Callback) ->
        return new Promise (Resolve, Reject) ->
            if !Slug then Reject "# [DEmojiJS] Please enter an emote slug to continue."

            if typeof Slug != "string"
                Reject "# [DEmojiJS] Emote slug has to be a string."

            API.contactAPI "https://discordemoji.com/api/", (Error, Data) ->
                if Error then Reject Error

                i = 0
                while i < Object.keys(Data).length
                    if Data[i]["slug"] == Slug
                        Resolve Data[i]

                    i++
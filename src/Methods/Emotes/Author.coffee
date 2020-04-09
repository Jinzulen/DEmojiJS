###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabAuthor
    constructor: (Author, Callback) ->
        return new Promise (Resolve, Reject) ->
            if typeof Author != "string"
                Reject "# [DEmojiJS] Emote author has to be a string."

            API.contactAPI "https://discordemoji.com/api/", (Error, Data) ->
                if Error then Reject Error

                Store = []

                for e in Data
                    if e["submitted_by"] == Author
                        Store.push e

                        Resolve Store
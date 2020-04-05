###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright (C) 2020 Jinzulen <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = new class getStatistics
    constructor: (Callback) ->
        return new Promise (Resolve, Reject) ->
            API.contactAPI "https://discordemoji.com/api/?request=stats", (Error, Data) ->
                if Error then Reject Error

                Resolve Data

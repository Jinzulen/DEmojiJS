###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabStatistics
    constructor: (Options, Callback) ->
        return new Promise (Resolve, Reject) ->
            API.contactAPI "https://discordemoji.com/api/?request=stats", (Error, Data) ->
                if Error then Reject Error
                
                if Options.length >= 1
                    Store = {}

                    for o in Options
                        Store[o] = Data[o]
                        
                        Resolve Store
                else Resolve Data
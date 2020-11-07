###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabEverything
    constructor: (GIF, Callback) ->
        return new Promise (Resolve, Reject) ->
            API.contactAPI "https://emoji.gg/api/", (Error, Data) ->
                if Error then Reject Error
                
                if GIF
                    Store = []

                    for e in Data
                        if e["image"].includes ".gif"
                            Store.push e

                            Resolve Store
                else Resolve Data

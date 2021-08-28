###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class SearchPacks
    constructor: (ID, Callback) ->
        return new Promise (Resolve, Reject) ->
            API.contactAPI "https://emoji.gg/api/packs", (Error, Packs) ->
                if Error then Reject Error

                if ID
                    Store = {}

                    for p in Packs
                        # Get rid of case sensitivity.
                        if typeof ID != "number" then ID = ID.toLowerCase()

                        Store["id"]       = p["id"]
                        Store["slug"]     = p["slug"]
                        Store["image"]    = p["image"]
                        Store["amount"]   = p["amount"]
                        Store["download"] = "https://https://emoji.gg/pack/" + p["slug"]
                        Store["name"]     = p["name"].toLowerCase()

                        # Return results.
                        if Store["id"] == ID || Store["name"] == ID || Store["slug"] == ID
                            Resolve p
                else
                    Resolve Packs

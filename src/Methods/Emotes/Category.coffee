###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabCategory
    constructor: (Category, Callback) ->
        return new Promise (Resolve, Reject) ->
            if !Category then Reject "# [DEmojiJS] Please enter an emote category to continue."

            if typeof Category != "string"
                Reject "# [DEmojiJS] Emote Category has to be a string."

            # Stores.
            Cats = {}
            Store = []

            # Grab emotes.
            API.contactAPI "https://discordemoji.com/api/", (Error, Emotes) ->
                if Error then Reject Error

                # Grab categories.
                API.contactAPI "https://discordemoji.com/api/?request=categories", (Error, Categories) ->
                    if Error then Reject Error

                    # Store all categories in lowercase.
                    for c in Object.keys Categories
                        Cats[c] = Categories[c].toLowerCase()

                    # Search for emotes that fit the requested category.
                    for e in Emotes
                        if Cats[e["category"]] == Category.toLowerCase()
                            Store.push e
                            
                        Resolve Store
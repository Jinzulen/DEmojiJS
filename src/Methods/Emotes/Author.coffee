###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabAuthor
    constructor: (Author, GIF, Callback) ->
        return new Promise (Resolve, Reject) ->
            if !Author then Reject "# [DEmojiJS] Please enter an emote uplaoder to continue."
            
            if typeof Author != "string"
                Reject "# [DEmojiJS] Emote author has to be a string."

            API.contactAPI "https://emoji.gg/api/", (Error, Data) ->
                if Error then Reject Error

                Store = []
                if GIF then Type = ".gif" else Type = "."

                for e in Data
                    e["submitted_by"] = e["submitted_by"].toLowerCase()

                    if e["submitted_by"] == Author.toLowerCase() && e["image"].includes Type
                        Store.push e

                        Resolve Store
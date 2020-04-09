###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

API = require "../../API/EmojiAPI"

module.exports = class GrabLicense
    constructor: (License, GIF, Callback) ->
        return new Promise (Resolve, Reject) ->
            if !License
                Reject "# [DEmojiJS] Please enter a license name to continue."

            if typeof License != "string"
                Reject "# [DEmojiJS] Emote license has to be a string."

            API.contactAPI "https://discordemoji.com/api/", (Error, Data) ->
                if Error then Reject Error

                Store = []
                License = License.toLowerCase()
                Licenses = {"basic": "0", "cc by 4.0": "1", "wtfpl": "2"}

                if GIF then Type = ".gif" else Type = "."
                if !Licenses[License] then Reject "# [DEmojiJS] #{License} is not a valid license."

                for e in Data
                    if e["license"] == Licenses[License] && e["image"].includes Type
                        Store.push e

                        Resolve Store
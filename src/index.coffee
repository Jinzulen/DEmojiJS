###
# @author Jinzulen
# @license Apache 2.0
# @copyright Copyright 2020 Khalil G. <https://github.com/Jinzulen>
###

# Grab categories just once at run-time.
API = require "./API/EmojiAPI"

API.GrabCategories()

# Method routes scaffolding.
Methods = {}

Methods.Packs = (ID = null, Callback) ->
    new (require "./Methods/Packs/Search")(ID, Callback)

Methods.allEmoji = (GIF = false, Callback) ->
    new (require "./Methods/Emotes/All")(GIF, Callback)

Methods.randomEmoji = (Input = null, Callback) ->
    new (require "./Methods/Emotes/Random")(Input, Callback)

Methods.emojiByID = (ID, Callback) ->
    new (require "./Methods/Emotes/ID")(ID, Callback)

Methods.emojiByName = (Title, Callback) ->
    new (require "./Methods/Emotes/Title")(Title, Callback)

Methods.emojiBySlug = (Slug, Callback) ->
    new (require "./Methods/Emotes/Slug")(Slug, Callback)

Methods.emojiByAuthor = (Name, GIF = false, Callback) ->
    new (require "./Methods/Emotes/Author")(Name, GIF, Callback)

Methods.emojiByLicense = (License, GIF = false, Callback) ->
    new (require "./Methods/Emotes/License")(License, GIF, Callback)

Methods.emojiByCategory = (Category, Callback) ->
    new (require "./Methods/Emotes/Category")(Category, Callback)

Methods.Statistics = (Options = [], Callback) ->
    new (require "./Methods/Website/Statistics")(Options, Callback)

# Return methods.
module.exports = Methods

<img align="right" width="100" height="100" src="https://i.imgur.com/Iphriti.gif">

# DEmojiJS
### DiscordEmoji's number one API client for Node-based applications.

![CodeFactor](https://www.codefactor.io/repository/github/jinzulen/demojijs/badge/dev-1.3.0?style=for-the-badge) ![NPM Version](https://img.shields.io/npm/v/demojijs?style=for-the-badge) ![NPM Weekly Downloads](https://img.shields.io/npm/dw/demojijs.svg?style=for-the-badge)

## 1. Installation
DEmojiJS is trusted by hundreds of users from all over to power their interactions with the DiscordEmoji API. Why? It's **faster** thanks to its caching features, its wide array of **versatile search** functionalities and overall **stable** performance. Not convinced?

See for yourself:
```
npm i demojijs
```

## 2. Usage Examples
> Note #1: Please keep in mind that data in the DiscordEmoji database is case-sensitive, which means that if you were to request an emoji by name, it'd be have to be "KappaYugi" not "kappayugi" or such, same thing goes for requesting an emoji by author, etc.

> Note #2: Often times, you won't be able to fetch a recently uploaded emote, this is not a fault of DEmojiJS; the data provided by DiscordEmoji themselves through their API is often outdated by a month or two, give or take.

Firstly, require DEmojiJS:
```js
const Emoji = require("demojijs");
```

- Grabbing DiscordEmoji's statistics.
```js
// Grab all statistics.
Emoji.Statistics().then(Data => {
    console.log(`DiscordEmoji has ${Data.emoji} emojis, ${Data.users} users, ${Data.faves} favorited emojis and ${Data.pending_approvals} emojis pending approval.`);
}).catch(console.error);
// DiscordEmoji has 15660 emojis, 126446 users, 103646 favorited emojis and 17 emojis pending approval.

// Grab individual statistics.
// For reference on the currently available search parameters, visit: https://discordemoji.com/api/?request=stats
Emoji.Statistics(["users", "faves"]).then(console.log).catch(console.error);
// { users: 126468, faves: 103702 }
```

- Grabbing a random emote.
```js
Emoji.randomEmoji().then(console.log).catch(console.error);
```

- Grabbing all emotes.
```js
// Grab everything.
Emoji.allEmoji().then(console.log).catch(console.error);

// Grab only animted (GIF) emotes by simply setting "true" as the sole argument.
Emoji.allEmoji(true).then(Emotes => console.log(`${Emotes.length} animated emotes found.`)).catch(console.error);
```

- Grabbing an emote by ID.
```js
Emoji.emojiByID(1).then(console.log).catch(console.error);
```

- Grabbing an emote by title.
```js
Emoji.emojiByName("KappaYugi").then(console.log).catch(console.error);
```

- Grabbing emotes by author.
> Keep in mind that this will return an array.
1. Grab all of the user's emotes.
    ```js
    Emoji.emojiByAuthor("Jin").then(Emotes => {
        console.log(`This user has uploaded ${Emotes.length} emotes; here are a couple of them:`);

        Emotes.slice(-2).forEach(function(Emote) {
            console.log(`${Emote.title} => ${Emote.image}`);
        });
    }).catch(console.error);
    // This user has uploaded 90 emotes; here are a couple of them:
    // linkdab => https://discordemoji.com/assets/emoji/4955_linkdab.png
    // KappaYugi => https://discordemoji.com/assets/emoji/KappaYugi.png
    ```

2. Grab all of the user's animated (GIF) emotes.
    ```js
    // Simply set "true" as the second argument.
    Emoji.emojiByAuthor("Jin", true).then(Emotes => {
        console.log(`This user has uploaded ${Emotes.length} animated emotes; for example:`);

        Emotes.slice(-2).forEach(function(Emote) {
            console.log(`${Emote.title} => ${Emote.image}`);
        });
    }).catch(console.error);
    // This user has uploaded 7 animated emotes; for example:
    // linkwut => https://discordemoji.com/assets/emoji/5523_linkwut.gif
    // linklurk => https://discordemoji.com/assets/emoji/9136_linklurk.gif
    ```

## 3. License
This module is publisher under the [Apache 2.0](https://github.com/Jinzulen/DEmojiJS/blob/master/LICENSE.md) license.

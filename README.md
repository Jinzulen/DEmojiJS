<img align="left" width="100" height="100" src="https://i.imgur.com/raol2EB.png">

# DEmojiJS
### DiscordEmoji's number one API client for Node-based applications.

![CodeFactor](https://www.codefactor.io/repository/github/jinzulen/demojijs/badge/dev-1.3.0) ![NPM Weekly Downloads](https://img.shields.io/npm/dw/demojijs.svg)

[![https://nodei.co/npm/demojijs.png](https://nodei.co/npm/demojijs.png)](https://www.npmjs.com/package/demojijs)

## 1. Installation
DEmojiJS is trusted by hundreds of users from all over to power their interactions with the DiscordEmoji API. Why? It's **faster** thanks to its caching features, its wide array of **versatile search** functionalities and overall **stable** performance. Not convinced?

See for yourself:
```
npm i demojijs
```

## 2. Usage Examples
- Grabbing DiscordEmoji's statistics.
```js
Emoji.Statistics().then(Data => {
    console.log(`DiscordEmoji has ${Data.emoji} emojis, ${Data.users} users, ${Data.faves} favorited emojis and ${Data.pending_approvals} emojis pending approval.`);
}).catch(console.error);
// DiscordEmoji has 15660 emojis, 126446 users, 103646 favorited emojis and 17 emojis pending approval.
```

- Grabbing a random emote.
```js
Emoji.randomEmoji().then(console.log).catch(console.error);
```

## 3. License
This module is publisher under the [Apache 2.0](https://github.com/Jinzulen/DEmojiJS/blob/master/LICENSE.md) license.

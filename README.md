DEmojiJS is a lightweight, simple NodeJS wrapper around the DiscordEmoji API.

You can quickly and easily install the library using NPM, via the following command: `npm i demojijs`. - Alternatively, you can just download the ZIP from here and require it in your project.
[![https://nodei.co/npm/demojijs.png](https://nodei.co/npm/demojijs.png)](https://www.npmjs.com/package/demojijs)
[![Build Status](https://travis-ci.org/Jinzulen/DEmojiJS.png?branch=master)](https://travis-ci.org/Jinzulen/DEmojiJS)

## Features
- DiscordEmoji API Features:
1. You can fetch the full extent of DiscordEmoji's statistics, as published by their API, including:
    - Number of users in their database.
    - Number of emojis pending approval.
    - Number of emojis in their database.
    - Number of user favorites in their database.
    
2. You can fetch information on a particular emoji, as indicated by their API, the information includes:
    - Emoji ID
    - Emoji Name
    - Emoji Slug
    - Emoji Image
    - Emoji Width
    - Emoji Height
    - Emoji Source
    - Emoji License
    - Emoji Category
    - Emoji File Size
    - Emoji Favorites
    - Emoji Submitter
    - Emoji Description
    
3. You can fetch the full list of available emoji categories, as indicated by their API.

- Wrapper Features
1. **Caching:** DEmojiJS makes use of local, file cache to lighten the load on DiscordEmoji's API and improve response time, the cache lifetime is by default set to **12 hours**.

## Guides:
> Please keep in mind that data in the DiscordEmoji database is case-sensitive, which means that if you were to request an emoji by name, it'd be have to be "KappaYugi" not "kappayugi" or such, same thing goes for requesting an emoji by author, etc...

- First, call DEmojiJS using:
```js
const DEmojiJS = require('demojijs');
```

1. Fetching emojis:
- We have quite a number of ways to fetch emojis here, but let's get this thing out of the way first, we can get a random emoji using:
```js
/**
 * Emoji here will return a JSON object carrying the following information:
 * * id
 * * title
 * * slug
 * * image
 * * description
 * * category
 * * license
 * * source
 * * faves
 * * submitted_by
 * * width
 * * height
 * * filesize
 */
DEmojiJS.randomEmoji().then(Emoji => {
    console.log(`${Emoji.title} (${Emoji.image}), submitted by: ${Emoji.submitted_by}.`);
}).catch(console.error);
```

- Fetching an emoji by ID
```js
DEmojiJS.emojiByID(5054).then(Emoji => {
    console.log(`${Emoji.title} (${Emoji.image}), submitted by: ${Emoji.submitted_by}.`);
}).catch(console.error);
// {"id":5054,"title":"KappaYugi","slug":"KappaYugi","image":"https:\/\/discordemoji.com\/assets\/emoji\/KappaYugi.png","description":"KappaYugi is a emoji that you can use on discord or slack. View more info at https:\/\/discordemoji.com\/emoji\/KappaYugi","category":3,"license":"1","source":"","faves":8,"submitted_by":"Jin","width":0,"height":0,"filesize":0}
```

- Fetching an emoji by name
```js
DEmojiJS.emojiByName('KappaYugi').then(Emoji => {
    console.log(`${Emoji.title} (${Emoji.image}), submitted by: ${Emoji.submitted_by}.`);
}).then(console.error);
// {"id":5054,"title":"KappaYugi","slug":"KappaYugi","image":"https:\/\/discordemoji.com\/assets\/emoji\/KappaYugi.png","description":"KappaYugi is a emoji that you can use on discord or slack. View more info at https:\/\/discordemoji.com\/emoji\/KappaYugi","category":3,"license":"1","source":"","faves":8,"submitted_by":"Jin","width":0,"height":0,"filesize":0}
```

- Fetching emojis by author/person who submitted them:
```js
DEmojiJS.emojiByAuthor('Kohai').then(Emotes => {
    Emotes.forEach(function(Element) {
        console.log(`- ${Element.title} (${Element.image}) by ${Element.submitted_by}`);
    });
}).catch(console.error);

//- MadmanShrug (https://discordemoji.com/assets/emoji/6461_MadmanShrug.png) by Kohai
//- Telegram (https://discordemoji.com/assets/emoji/9297_Telegram.png) by Kohai
//- hedhurt (https://discordemoji.com/assets/emoji/6700_hedhurt.png) by Kohai
//- blobwitchtea (https://discordemoji.com/assets/emoji/9643_blobwitchtea.png) by Kohai
//- eymario (https://discordemoji.com/assets/emoji/5501_eymario.png) by Kohai
// [... 496 more items]
```

- Fetching emojis by license
> License input here is not case-sensitive.
```js
DEmojiJS.emojiByLicense('basic').then(Emotes => {
      console.log(`- Found ${Emotes.length} emotes using this license.`);
}).catch(console.error);
// - Found 4772 emotes using this license.

DEmojiJS.emojiByLicense('cc by 4.0').then(Emotes => {
      console.log(`- Found ${Emotes.length} emotes using this license.`);
}).catch(console.error);
// - Found 251 emotes using this license.

DEmojiJS.emojiByLicense('wtfpl').then(Emotes => {
      console.log(`- Found ${Emotes.length} emotes using this license.`);
}).catch(console.error);
//- Found 72 emotes using this license.
```

2. Fetching Statistics
```js
DEmojiJS.Statistics().then(Stats => {
      console.log(Stats.emoji);
      // returns: 5660

      console.log(Stats.users);
      // return: 34701

      console.log(Stats.faves);
      // returns: 30051

      console.log(Stats.pending_approvals);
      // returns: 1

      console.log(Stats);
      // returns: { emoji: 5660, users: 34701, faves: 30051, pending_approvals: 1 }
}).catch(console.error);
```

## Dependencies
- [underscore](https://www.npmjs.com/package/underscore)
- [node-file-cache](https://www.npmjs.com/package/node-file-cache)

## Contributors
- Jinzulen (Jin#8303) - Making this.
- Coffee-chan - Keeping me alive and focused. <3

## Useful Links
- [DiscordEmoji](https://discordemoji.com/)
- [DiscordEmoji Server](https://discord.gg/Fh6q2Fw)
- [DEmojiJS NPM](https://www.npmjs.com/package/demojijs)

## Developer Note
- Callbacks are being problematic, please avoid using them right now and instead go only for promises.
- This wrapper is released under the ISC license, as such, you can do with it what you want so long as credits remain.
- If you encounter an issue with it, then feel free to open an issue and I'll tend to it and see what can be done about it, same thing goes for feature requests.

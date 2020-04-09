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

> Note #2: Often times, you won't be able to fetch a recently uploaded emote, this is not a fault of DEmojiJS; the data provided by DiscordEmoji themselves through their API is often outdated by a month or two, give or take. Most of the time, entire chunks of emotes are missing given the API doesn't serve **every** emote in DiscordEmoji's database.

Firstly, require DEmojiJS:
```js
const Emoji = require("demojijs");
```

### 2.1 Packs
- Grabbing all packs
```js
Emoji.Packs().then(Packs => {
    console.log(`Found ${Packs.length} packs.`);

    Packs.forEach(function(Pack) {
        console.log(`- #${Pack.id} ${Pack.name} has ${Pack.amount} emotes and can be downloaded here: ${Pack.download}`);
    });
}).catch(console.error);
// Found 8 packs.
// - #9 Pensive Emojis has 8 emotes and can be downloaded here: https://discordemoji.com/assets/packs/download/pensive-pack.zip
// - #8 Original Remixes #1 has 12 emotes and can be downloaded here: https://discordemoji.com/assets/packs/download/original-remixes-1.zip
// - #7 Blob Pack #1 has 16 emotes and can be downloaded here: https://discordemoji.com/assets/packs/download/blob-pack-1.zip
// - #6 100 Remixes has 12 emotes and can be downloaded here: https://discordemoji.com/assets/packs/download/100-remixes.zip- #5 PUBG Pack has 10 emotes and can be downloaded here: https://discordemoji.com/assets/packs/download/pubg-pack.zip
// - #4 Minecraft Pack has 16 emotes and can be downloaded here: https://discordemoji.com/assets/packs/download/minecraft-pack.zip
// - #3 Pepe Pack #1 has 16 emotes and can be downloaded here: https://discordemoji.com/assets/packs/download/pepe-pack-1.zip
// - #2 Anime Pack #1 has 16 emotes and can be downloaded here: https://discordemoji.com/assets/packs/download/anime-pack-1.zip
```

- Grabbing a pack by ID, title or slug.
> Input is not case-sensitive.
```js
Emoji.Packs(4).then(console.log).catch(console.error);
Emoji.Packs("minecraft pack").then(console.log).catch(console.error);
Emoji.Packs("minecraft-pack").then(console.log).catch(console.error);
```

### 2.2 Emotes & Stats
- Grabbing DiscordEmoji's statistics.
```js
// Grab all statistics.
Emoji.Statistics().then(Data => {
    console.log(`DiscordEmoji has ${Data.emoji} emojis, ${Data.users} users, ${Data.faves} favorited emojis and ${Data.pending_approvals} emojis pending approval.`);
}).catch(console.error);
// DiscordEmoji has 15660 emojis, 126446 users, 103646 favorited emojis and 17 emojis pending approval.

// Grab individual statistics.
// For reference on the currently available search parameters, visit: https://discordemoji.com/api/?request=stats
// If you only want one parameter, make sure to keep it as an array rather than a string: Statistics(["users"]) not Statistics("users")
Emoji.Statistics(["users", "faves"]).then(console.log).catch(console.error);
// { users: 126468, faves: 103702 }
```

- Grabbing a random emote.
```js
// Grab a random emote.
Emoji.randomEmoji().then(console.log).catch(console.error);

// Grab a random animated (GIF) emote by simply setting "true" as the sole argument.
Emoji.randomEmoji(true).then(console.log).catch(console.error);

// Grab a random emote from a specific category by simply setting the name of the category as the sole argument.
Emoji.randomEmoji("anime").then(console.log).catch(console.error);
```

- Grabbing all emotes.
> Keep in mind that this will return an array if you choose to return GIFs only.
```js
// Grab everything.
Emoji.allEmoji().then(console.log).catch(console.error);

// Grab only animated (GIF) emotes by simply setting "true" as the sole argument.
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

- Grabbing an emote by category.
> Keep in mind that this will return an array and that the input is not case-sensitive.

> For reference on all the available categories, visit: https://discordemoji.com/api/?request=categories
```js
Emoji.emojiByCategory("anime").then(Emotes => console.log(`Found ${Emotes.length} emotes in this category.`)).catch(console.error);
// Found 1090 emotes in this category.
```

- Grabbing an emote by its slug.
```js
Emoji.emojiBySlug("5263_flashthink").then(Emote => {
    console.log(`${Emote.title}, uploaded by ${Emote.submitted_by}. => ${Emote.image}`)
}).catch(console.error);
// flashthink, uploaded by Jin. => https://discordemoji.com/assets/emoji/5263_flashthink.png
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

- Grabbing emotes by license.
> Keep in mind that this will return an array and that the input is not case-sensitive.
```js
Emoji.emojiByLicense("basic").then(Emotes => console.log(`Found ${Emotes.length} emotes.`)).catch(console.error);
Emoji.emojiByLicense("wtfpl").then(Emotes => console.log(`Found ${Emotes.length} emotes.`)).catch(console.error);
Emoji.emojiByLicense("cc by 4.0").then(Emotes => console.log(`Found ${Emotes.length} emotes.`)).catch(console.error);
// Found 5108 emotes.
// Found 83 emotes.
// Found 254 emotes.

// Grab animted (GIF) emotes under a certain license by setting "true" as the second argument.
Emoji.emojiByLicense("basic", true).then(Emotes => console.log(`Found ${Emotes.length} animated emotes.`)).catch(console.error);
Emoji.emojiByLicense("wtfpl", true).then(Emotes => console.log(`Found ${Emotes.length} animated emotes.`)).catch(console.error);
Emoji.emojiByLicense("cc by 4.0", true).then(Emotes => console.log(`Found ${Emotes.length} animted emotes.`)).catch(console.error);
// Found 649 animated emotes.
// Found 12 animated emotes.
// Found 36 animted emotes.
```

## 3. License
This module is publisher under the [Apache 2.0](https://github.com/Jinzulen/DEmojiJS/blob/master/LICENSE.md) license.
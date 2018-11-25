/**
 * Copyright (c) 2018 Jinzulen <Jinzu@protonmail.ch>
 * 
 * @license ISC
 */

const HTTPS = require('https'),
      _     = require('underscore'),
      Cache = require('node-file-cache').create({
            file: 'demoji-cache',
            life: 43200
      });

const Methods = {};

/**
 * Will tend to this among other things in later revisions.
 * 
 * @todo Proper error handling.
 */
process.on('unhandledRejection', (E) => {
      return;
});

function fetchAPI(Path, Callback)
{
      try
      {
            const cacheKey = Cache.get(Path);
            
            if (!cacheKey)
            {
                  HTTPS.get(Path, (Result) => {
                        let Error;
                        let rawData = '';
                        const Type = Result.headers['content-type'];
                        const Code = Result.statusCode;
                        
                        if (Code !== 200)
                        {
                              Error = '# [DEmojiJS] Could not send request for the specified emoji. Status code: ' + Code;
                              Error.code = 'ERR_REQUEST_SEND';
                        } else if (Type.indexOf('application/json') === -1) {
                              Error = '# [DEmojiJS] The content received isn\'t JSON. The returned content type is: ' + Type;
                              Error.code = 'ERR_REQUEST_NOT_JSON';
                        };
                        
                        if (Error)
                        {
                              Result.resume();
                              Callback(Error);
                              return;
                        };
                        
                        Result.setEncoding('utf8');
                        
                        Result.on('data', function (Buffer) {
                              rawData += Buffer;
                        });
                        
                        Result.on('end', () => {
                              let Data = null;
                              let Error = null;
                        
                              try
                              {
                                    Data = JSON.parse(JSON.stringify(rawData));

                                    if (Cache.set(Path, Data, 43200))
                                    {
                                          console.log(`# [DEmojiJS] Cached: ${Path}`);
                                    }
                              } catch (unusedError) {
                                    Error = '# [DEmojiJS] Failed to parse retrieved JSON.';
                                    Error.code = 'ERR_JSON_PARSE';
                              };
                        
                              Callback(Error, Data);
                        });
                  });
            } else {
                  let Data = null;
                  let Error = null;
            
                  try
                  {
                        Data = JSON.parse(JSON.stringify(cacheKey));
                  } catch (unusedError) {
                        Error = '# [DEmojiJS] Failed to parse retrieved JSON.';
                        Error.code = 'ERR_JSON_PARSE';
                  };
            
                  Callback(Error, Data);
            }
      } catch (E) { throw E; };
};

Methods.allEmoji = function allEmoji (Callback)
{
      return new Promise((Resolve, Reject) => {
            fetchAPI('https://discordemoji.com/api/', (Error, Result) => {
                  if(Error)
                  {
                        if (typeof Callback === 'function')
                        {
                              Callback(Error);
                        };

                        Reject(Error);
                        return;
                  };

                  if (typeof Callback === 'function')
                  {
                        Callback(null, Result[0]);
                  };

                  Resolve(JSON.parse(Result));
            });
      });
};

Methods.randomEmoji = function randomEmoji (Callback)
{
      return new Promise((Resolve, Reject) => {
            fetchAPI('https://discordemoji.com/api/', (Error, Result) => {
                  if (Error)
                  {
                        if (typeof Callback === 'function')
                        {
                              Callback(Error);
                        };

                        Reject(Error);
                        return;
                  };

                  if (typeof Callback === 'function')
                  {
                        Callback(null, Result[0]);
                  };

                  const Parse = JSON.parse(Result);
                  const Count = Math.floor(Math.random() * Object.keys(Parse).length) + 1;
                  
                  Resolve(Parse[Count]);
            });
      });
};

Methods.emojiByID = function emojiByID (ID, Callback)
{
      if (typeof ID !== 'number')
      {
            let Error = new TypeError('ID has to be a number.');
            Error.code = 'ERR_ID_NOT_NUM'

            throw Error;
      };

      return new Promise((Resolve, Reject) => {
            fetchAPI('https://discordemoji.com/api/', (Error, Result) => {
                  if (Error)
                  {
                        if (typeof Callback === 'function')
                        {
                              Callback(Error);
                        };

                        Reject(Error);
                        return;
                  };

                  if (typeof Callback === 'function')
                  {
                        Callback(null, Result[0]);
                  };
                  
                  Resolve(_.where(JSON.parse(Result), {
                        id: ID
                  })[0]);
            });
      });
};

Methods.emojiByName = function emojiByName (Name, Callback)
{
      if (typeof Name !== 'string')
      {
            let Error = new TypeError('Name has to be a string.');
            Error.code = 'ERR_NAME_NOT_STRING'

            throw Error;
      };

      return new Promise((Resolve, Reject) => {
            fetchAPI('https://discordemoji.com/api/', (Error, Result) => {
                  if (Error)
                  {
                        if (typeof Callback === 'function')
                        {
                              Callback(Error);
                        };

                        Reject(Error);
                        return;
                  };

                  if (typeof Callback === 'function')
                  {
                        Callback(null, Result[0]);
                  };
                  
                  Resolve(_.where(JSON.parse(Result), {
                        title: Name
                  })[0]);
            });
      });
};

Methods.emojiByAuthor = function emojiByAuthor (Author, Callback)
{
      if (typeof Author !== 'string')
      {
            let Error = new TypeError('Author has to be a string.');
            Error.code = 'ERR_AUTHNAME_NOT_STRING'

            throw Error;
      };

      return new Promise((Resolve, Reject) => {
            fetchAPI('https://discordemoji.com/api/', (Error, Result) => {
                  if (Error)
                  {
                        if (typeof Callback === 'function')
                        {
                              Callback(Error);
                        };

                        Reject(Error);
                        return;
                  };

                  if (typeof Callback === 'function')
                  {
                        Callback(null, Result[0]);
                  };

                  Resolve(_.where(JSON.parse(Result), {
                        submitted_by: Author
                  }));
            });
      });
};

Methods.emojiByLicense = function emojiByLicense (License, Callback)
{
      if (typeof License !== 'string')
      {
            let Error = new TypeError('License has to be a string.');
            Error.code = 'ERR_LIC_NOT_STRING'

            throw Error;
      };

      return new Promise((Resolve, Reject) => {
            fetchAPI('https://discordemoji.com/api/', (Error, Result) => {
                  if (Error)
                  {
                        if (typeof Callback === 'function')
                        {
                              Callback(Error);
                        };

                        Reject(Error);
                        return;
                  };

                  if (typeof Callback === 'function')
                  {
                        Callback(null, Result[0]);
                  };
                  
                  const uLicense = License.toLowerCase();
                  const Licenses = {'basic':'0','cc by 4.0':'1','wtfpl':'2'};

                  if (!uLicense.indexOf(Licenses))
                  {
                        let Error = new TypeError('License not found.');
                        Error.code = 'ERR_LIC_NOT_FOUND'
            
                        throw Error;
                  };

                  Resolve(_.where(JSON.parse(Result), {
                        license: Licenses[uLicense]
                  }));
            });
      });
};

Methods.Statistics = function Statistics (Callback)
{
      return new Promise((Resolve, Reject) => {
            fetchAPI('https://discordemoji.com/api/?request=stats', (Error, Result) => {
                  if (Error)
                  {
                        if (typeof Callback === 'function')
                        {
                              Callback(Error);
                        };

                        Reject(Error);
                        return;
                  };

                  if (typeof Callback === 'function')
                  {
                        Callback(null, Result[0]);
                  };

                  Resolve(JSON.parse(Result));
            });
      });
};

module.exports = Methods;

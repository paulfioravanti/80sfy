# 80sfy

[80sfy.com][] by [Art Sangurai][] ([original codebase repo][]) is a pretty cool
site if you love [synthwave][] music, so I decided to re-create it using
[Elm][].

You can see the results at:

- [Heroku][]: <https://elm-80sfy.herokuapp.com/>
- [Surge][]: <http://elm-80sfy.surge.sh/>

Note that it's currently only optimised for the Google Chrome desktop browser,
so it's probably best to view it with that.

## Development

### Dependencies

- [Elm][] 0.18.0
- [NodeJS][] 10.7.0

## Setup

### Global

This app was created using [Create Elm App][] and uses some commands that it
provides, so install it globally with `npm`:

```sh
npm install -g create-elm-app
```

### Application

```sh
git clone https://github.com/paulfioravanti/80sfy.git
cd 80sfy
npm install
elm-package install
cp .env.example .env
```

### Giphy Integration

Create an account at [Giphy Developers][], create an app to get your API key,
and copy/paste it into the `.env` file:

```sh
ELM_APP_GIPHY_API_KEY="Your API key here"
```

### Run Server

```sh
elm-app start
```

Now, you should be able to use the app at the following address:

- <http://localhost:3000>

## Gotchas

- If, like me, you use Chrome and have the [Video Speed Controller][]
  extension installed, then make sure to add the following URLs to its
  blacklist, or you may find that that newly fetched GIFs will not display as
  expected:

  ```sh
  http://localhost:3000/
  http://www.80sfy.com/
  https://elm-80sfy.herokuapp.com/
  http://elm-80sfy.surge.sh/
  ```

## Other Links

- [Love on Reddit for 80sfy.com][80sfy on Reddit]

[80sfy.com]: http://www.80sfy.com/
[80sfy on Reddit]: https://www.reddit.com/r/outrun/comments/5rdvks/my_boyfriend_made_a_website_that_plays_synthwave/
[Art Sangurai]: http://www.digitalbloc.com/
[Create Elm App]: https://github.com/halfzebra/create-elm-app
[Elm]: http://elm-lang.org/
[Giphy Developers]: https://developers.giphy.com/
[Heroku]: https://www.heroku.com/
[NodeJS]: https://nodejs.org/en/
[original codebase repo]: https://bitbucket.org/asangurai/80sfy/src/master/
[Soundcloud]: https://soundcloud.com
[Soundcloud register new app]: http://soundcloud.com/you/apps/new
[Surge]: https://surge.sh/
[synthwave]: https://en.wikipedia.org/wiki/Synthwave
[Video Speed Controller]: https://chrome.google.com/webstore/detail/video-speed-controller/nffaoalbilbmmfgbnbgppjihopabppdk?hl=en

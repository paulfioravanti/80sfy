# 80sfy

[80sfy.com][] by [Art Sangurai][] ([original codebase repo][]) is a pretty cool
site if you love [synthwave][] music, so I decided to re-create it using
[Elm][].

You can see the results at:

- [Heroku][]: <https://elm-80sfy.herokuapp.com/>
- [Surge][]: <http://elm-80sfy.surge.sh/>

Note that it's currently only optimised for the Google Chrome and Firefox
desktop browsers, so it's probably best to view it with either of those.

The only real difference between them should be that Chrome does not allow
audio auto play by default.

## Development

### Dependencies

- [Elm][] 0.19.1
- [NodeJS][] 13.0.1

## Setup

### Global

This app was created using [Create Elm App][] 4.0.0 (which uses Elm 0.19.1), and
uses some commands that it provides, so install it globally with `npm`:

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

## Deployment

Deployment is managed in the [`push`](push) script. It deploys out to both
Heroku and Surge and you execute it simply with the command:

```sh
./push
```


## Gotchas

### Video Speed Controller Chrome Extension

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

### Chrome Autoplay Policy

Chrome's autoplay policies [changed in April of 2018][Chrome Autoplay Policy
Changes], which seems to affect this app when it is first loaded, and you
attempt to press the play button on the controller (not the play button on the
embedded Soundcloud player): nothing happens, and if you open up the Chrome
inspector, in the console you will see a message like: "The AudioContext was not
allowed to start. It must be resumed (or created) after a user gesture on the
page.".

This can be mitigated in two ways:

1. When you play audio for the _first time_, click the Soundcloud play button,
rather than the controller play button. This would seem to let the autoplay
policy know that you, the user, have given permission for application widgets
to play sound. Once you have done this the first time, all subsequent play/pause
actions should work as expected.

2. Change your Chrome autoplay policy flag by:
  - Inputting `chrome://flags/#autoplay-policy` in your browser address field
  - Setting the value in the dropdown menu to be "No user gesture is required".

This will enable the controller play button to work as expected when you attempt
to play audio the first time the app is loaded.

## Other Links

- [Love on Reddit for 80sfy.com][80sfy on Reddit]

[80sfy.com]: http://www.80sfy.com/
[80sfy on Reddit]: https://www.reddit.com/r/outrun/comments/5rdvks/my_boyfriend_made_a_website_that_plays_synthwave/
[Art Sangurai]: http://www.digitalbloc.com/
[Chrome Autoplay Policy Changes]: https://developers.google.com/web/updates/2017/09/autoplay-policy-changes#webaudio
[Create Elm App]: https://github.com/halfzebra/create-elm-app
[Elm]: http://elm-lang.org/
[Giphy Developers]: https://developers.giphy.com/
[Heroku]: https://www.heroku.com/
[Map.! when compiling with --debug]: https://github.com/elm/compiler/issues/1851
[NodeJS]: https://nodejs.org/en/
[original codebase repo]: https://bitbucket.org/asangurai/80sfy/src/master/
[Soundcloud]: https://soundcloud.com
[Soundcloud register new app]: http://soundcloud.com/you/apps/new
[Surge]: https://surge.sh/
[synthwave]: https://en.wikipedia.org/wiki/Synthwave
[Video Speed Controller]: https://chrome.google.com/webstore/detail/video-speed-controller/nffaoalbilbmmfgbnbgppjihopabppdk?hl=en

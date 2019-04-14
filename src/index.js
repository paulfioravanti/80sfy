// import "@fortawesome/fontawesome";
// import "@fortawesome/fontawesome-free-solid";
// import "@fortawesome/fontawesome-free-regular";
// NOTE: This uses the webfonts with CSS and not the SVG with JS version of the
// Font Awesome version 5 fonts due to not being able to get colour gradients
// working with SVGs.
// See issue: https://github.com/FortAwesome/Font-Awesome/issues/11925
// (the workaround in the comments was a higher path of resistance than using
// the webfonts version).
// Other references:
// - https://fontawesome.com/how-to-use/js-component-packages
// - https://github.com/parcel-bundler/parcel/issues/626#issuecomment-360371880
import "@fortawesome/fontawesome-free-webfonts"
import "@fortawesome/fontawesome-free-webfonts/css/fa-solid.css"
import { Elm } from "./Main"
import * as AudioPlayer from "./audioPlayer"
import * as BrowserFullScreen from "./browserFullScreen"
import * as VideoPlayer from "./videoPlayer"

const app =
  Elm.Main.init({
    flags: {
      giphyApiKey: process.env.ELM_APP_GIPHY_API_KEY,
      soundCloudPlaylistUrl: process.env.ELM_APP_SOUNDCLOUD_PLAYLIST_URL,
      browserVendor: determineBrowserVendor()
    }
  })

app.ports.consoleLog.subscribe((json) => {
  console.log(json)
})

VideoPlayer.init(app)
AudioPlayer.init(app)
BrowserFullScreen.init(app)

function determineBrowserVendor() {
  if (BrowserFullScreen.isWebkit()) {
    return "webkit"
  } else if (BrowserFullScreen.isMozilla()) {
    return "mozilla"
  } else if (BrowserFullScreen.isOtherFullScreenCapableBrowser()) {
    return "other"
  }
}

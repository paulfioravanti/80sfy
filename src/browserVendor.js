export const BrowserVendor = {
  init,
  current,
}

const WEBKIT = "webkit"
const MOZILLA = "mozilla"
const OTHER = "other"

function init(app) {
  switch(current()) {
    case WEBKIT:
      initWebkitExitFullScreen(app)
      initWebkitFullScreenToggle(app)
      initWebkitRequestFullScreen(app)
      break
    case MOZILLA:
      initMozCancelFullScreen(app)
      initMozFullScreenToggle(app)
      initMozFullScreenToggleHack()
      initMozRequestFullScreen(app)
      break
    case OTHER:
      initOtherExitFullScreen(app)
      initOtherFullScreenToggle(app)
      initOtherRequestFullScreen(app)
    default:
      console.log("Could not determine browser vendor!")
  }
}

function current() {
  if (isWebkit()) {
    return WEBKIT
  } else if (isMozilla()) {
    return MOZILLA
  } else if (isOtherFullScreenCapableBrowser()) {
    return OTHER
  }
}

// WEBKIT

function isWebkit() {
  return (
    document.webkitFullscreenElement !== undefined &&
    document.documentElement.webkitRequestFullScreen &&
    document.webkitExitFullscreen
  )
}

function initWebkitExitFullScreen(app) {
  app.ports.webkitExitFullScreen.subscribe(() => {
    document.webkitExitFullscreen()
  })
}

function initWebkitFullScreenToggle(app) {
  app.ports.webkitFullScreenToggle.subscribe(() => {
    const isFullScreen = !!document.webkitFullscreenElement
    app.ports.toggleFullScreen.send(isFullScreen)
  })
}

function initWebkitRequestFullScreen(app) {
  app.ports.webkitRequestFullScreen.subscribe(() => {
    document.documentElement.webkitRequestFullScreen()
  })
}

// MOZILLA

function isMozilla() {
  return (
    document.mozFullScreenElement !== undefined &&
    document.documentElement.mozRequestFullScreen &&
    document.mozCancelFullScreen
  )
}

function initMozCancelFullScreen(app) {
  app.ports.mozCancelFullScreen.subscribe(() => {
    document.mozCancelFullScreen()
  })
}

function initMozFullScreenToggle(app) {
  app.ports.mozFullScreenToggle.subscribe(() => {
    const isFullScreen = !!document.mozFullScreenElement
    app.ports.toggleFullScreen.send(isFullScreen)
  })
}

// Hopefully this function can be removed in later versions of Elm, but the
// issue is that the Elm-style initMozFullScreenToggle function above does not
// seem to work as Firefox requires the fullscreen event to occur in the same
// clock tick as the user click. If you use the function above, in the console,
// you will see "Request for fullscreen was denied because
// Element.requestFullscreen() was not called from inside a short running
// user-generated event handler.". I don't currently know how to fix this.
// More information can be found at:
// - https://groups.google.com/d/msg/elm-dev/hhNu6SGOM54/TS0pDPtKCAAJ
// - https://stackoverflow.com/q/43240352/567863
function initMozFullScreenToggleHack() {
  window.mozFullScreenToggleHack = () => {
    const isFullScreen = !!document.mozFullScreenElement
    if (isFullScreen) {
      document.mozCancelFullScreen()
    } else {
      document.documentElement.mozRequestFullScreen()
    }
  }
}

function initMozRequestFullScreen(app) {
  app.ports.mozRequestFullScreen.subscribe(() => {
    document.documentElement.mozRequestFullScreen()
  })
}

// OTHER

function isOtherFullScreenCapableBrowser() {
  return (
    document.fullScreenElement !== undefined &&
    document.documentElement.requestFullScreen &&
    document.exitFullscreen
  )
}

function initOtherExitFullScreen(app) {
  app.ports.otherExitFullScreen.subscribe(() => {
    document.exitFullscreen()
  })
}

function initOtherFullScreenToggle(app) {
  app.ports.otherFullScreenToggle.subscribe(() => {
    const isFullScreen = !!document.fullscreenElement
    app.ports.toggleFullScreen.send(isFullScreen)
  })
}

function initOtherRequestFullScreen(app) {
  app.ports.otherRequestFullScreen.subscribe(() => {
    document.documentElement.requestFullScreen()
  })
}

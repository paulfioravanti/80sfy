export function init(app) {
  initFullScreenToggle(app)
  initRequestFullScreen(app)
  initExitFullScreen(app)

  initMozFullScreenToggle(app)
  initMozFullScreenToggleHack()
  initMozRequestFullScreen(app)
  initMozCancelFullScreen(app)

  initWebkitFullScreenToggle(app)
  initWebkitRequestFullScreen(app)
  initWebkitExitFullScreen(app)
}

export function isMozilla() {
  return (
    document.mozFullScreenElement !== "undefined" &&
    document.documentElement.mozRequestFullScreen &&
    document.mozCancelFullScreen
  )
}

export function isOtherFullScreenCapableBrowser() {
  return (
    document.fullScreenElement !== "undefined" &&
    document.documentElement.requestFullScreen &&
    document.exitFullscreen
  )
}

export function isWebkit() {
  return (
    document.webkitFullscreenElement !== "undefined" &&
    document.documentElement.webkitRequestFullScreen &&
    document.webkitExitFullscreen
  )
}

function initExitFullScreen(app) {
  app.ports.exitFullScreen.subscribe(() => {
    document.exitFullscreen()
  })
}

function initFullScreenToggle(app) {
  app.ports.fullScreenToggle.subscribe(() => {
    const isFullScreen = !!document.fullscreenElement
    app.ports.toggleFullScreen.send(isFullScreen)
  })
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
// More information can be found in this message on the Elm mailing list:
// https://groups.google.com/d/msg/elm-dev/hhNu6SGOM54/TS0pDPtKCAAJ
function initMozFullScreenToggleHack() {
  window.mozFullScreenToggleHack = function () {
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

function initRequestFullScreen(app) {
  app.ports.requestFullScreen.subscribe(() => {
    document.documentElement.requestFullScreen()
  })
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

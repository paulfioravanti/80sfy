export function init(app) {
  initFullScreenToggle(app)
  initRequestFullScreen(app)
  initExitFullScreen(app)

  initMozFullScreenToggle(app)
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

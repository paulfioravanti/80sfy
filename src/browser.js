export function init(app) {
  initExitFullScreen(app)
  initMozCancelFullScreen(app)
  initMozRequestFullScreen(app)
  initPerformFullScreenToggle(app)
  initRequestFullScreen(app)
  initWebkitExitFullScreen(app)
  initWebkitRequestFullScreen(app)
}

function initExitFullScreen(app) {
  app.ports.exitFullScreen.subscribe(() => {
    document.exitFullscreen()
  })
}

function initMozCancelFullScreen(app) {
  app.ports.mozCancelFullScreen.subscribe(() => {
    document.mozCancelFullScreen()
  })
}

function initMozRequestFullScreen(app) {
  app.ports.mozRequestFullScreen.subscribe(() => {
    document.documentElement.mozRequestFullScreen()
  })
}

function initPerformFullScreenToggle(app) {
  app.ports.performFullScreenToggle.subscribe(() => {
    const isFullScreen = !!fullScreenElement()
    app.ports.toggleFullScreen.send(isFullScreen)
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

function initWebkitRequestFullScreen(app) {
  app.ports.webkitRequestFullScreen.subscribe(() => {
    document.documentElement.webkitRequestFullScreen()
  })
}

function fullScreenElement() {
  return (
    document.fullscreenElement ||
    document.mozFullScreenElement ||
    document.webkitFullscreenElement
  )
}

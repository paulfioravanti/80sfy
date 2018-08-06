export function init(app) {
  initExitFullScreen(app)
  initHaltVideos(app)
  initPauseVideos(app)
  initPerformFullScreenToggle(app)
  initPlayVideos(app)
  initRequestFullScreen(app)
  initWindowBlurred(app)
  initWindowFocused(app)
}

function initExitFullScreen(app) {
  app.ports.exitFullScreen.subscribe(() => {
    exitFullScreen()
  })
}

function initHaltVideos(app) {
  app.ports.haltVideos.subscribe(() => {
    pauseVideoPlayers()
    app.ports.videosHalted.send(null)
  })
}

function initPauseVideos(app) {
  app.ports.pauseVideos.subscribe(() => {
    pauseVideoPlayers()
    app.ports.videosPaused.send(null)
  })
}

function initPerformFullScreenToggle(app) {
  app.ports.performFullScreenToggle.subscribe(() => {
    const isFullScreen = !!fullScreenElement()
    app.ports.toggleFullScreen.send(isFullScreen)
  })
}

function initPlayVideos(app) {
  app.ports.playVideos.subscribe(() => {
    playVideoPlayers()
    app.ports.videosPlaying.send(null)
  })
}

function initRequestFullScreen(app) {
  app.ports.requestFullScreen.subscribe(() => {
    requestFullScreen()
  })
}

function initWindowBlurred(app) {
  window.addEventListener("blur", event => {
    const activeElementId = event.target.document.activeElement.id
    app.ports.windowBlurred.send(activeElementId)
  })
}

function initWindowFocused(app) {
  window.addEventListener("focus", () => {
    app.ports.windowFocused.send(null)
  })
}

function requestFullScreen() {
  const documentElement = document.documentElement

  if (documentElement.requestFullScreen) {
    documentElement.requestFullScreen()
  } else if (documentElement.mozRequestFullScreen) {
    documentElement.mozRequestFullScreen()
  } else if (documentElement.webkitRequestFullScreen) {
    documentElement.webkitRequestFullScreen()
  }
}

function exitFullScreen() {
  if (document.exitFullscreen) {
    document.exitFullscreen()
  } else if (document.mozCancelFullScreen) {
    document.mozCancelFullScreen()
  } else if (document.webkitExitFullscreen) {
    document.webkitExitFullscreen()
  }
}

function pauseVideoPlayers() {
  videos().forEach(video => {
    video.pause()
  })
}

function playVideoPlayers() {
  videos().forEach(video => {
    if (videoPlayable(video)) {
      video.play()
    }
  })
}

function videos() {
  return [...document.getElementsByTagName("video")]
}

function fullScreenElement() {
  return (
    document.fullscreenElement ||
    document.mozFullScreenElement ||
    document.webkitFullscreenElement
  )
}

function videoPlayable(video) {
  return (
    video.paused ||
    video.ended ||
    video.seeking ||
    video.readyState > video.HAVE_FUTURE_DATA
  )
}

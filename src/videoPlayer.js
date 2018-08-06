export function init(app) {
  cancelFullScreen(app)
  haltVideos(app)
  pauseVideos(app)
  performFullScreenToggle(app)
  playVideos(app)
  windowBlurred(app)
  windowFocused(app)
}


function cancelFullScreen(app) {
  app.ports.exitFullScreen.subscribe(() => {
    exitFullScreen()
  })
}

function haltVideos(app) {
  app.ports.haltVideos.subscribe(() => {
    pauseVideoPlayers()
    app.ports.videosHalted.send(null)
  })
}

function pauseVideos(app) {
  app.ports.pauseVideos.subscribe(() => {
    pauseVideoPlayers()
    app.ports.videosPaused.send(null)
  })
}

function playVideos(app) {
  app.ports.playVideos.subscribe(() => {
    playVideoPlayers()
    app.ports.videosPlaying.send(null)
  })
}

function performFullScreenToggle(app) {
  app.ports.performFullScreenToggle.subscribe(() => {
    if (fullScreenElement()) {
      exitFullScreen()
    } else {
      requestFullScreen()
    }
  })
}

function windowBlurred(app) {
  window.addEventListener("blur", event => {
    const activeElementId = event.target.document.activeElement.id
    app.ports.windowBlurred.send(activeElementId)
  })
}

function windowFocused(app) {
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

export function initPorts(app) {
  cancelFullScreen(app)
  pauseVideos(app)
  playVideos(app)
  toggleFullScreen(app)
}

function cancelFullScreen(app) {
  app.ports.exitFullScreen.subscribe(() => {
    exitFullScreen()
  })
}


function pauseVideos(app) {
  app.ports.pauseVideos.subscribe(() => {
    const videos = [...document.getElementsByTagName("video")]
    videos.forEach((video) => {
      video.pause()
    })
  })
}

function playVideos(app) {
  app.ports.playVideos.subscribe(() => {
    const videos = [...document.getElementsByTagName("video")]
    videos.forEach((video) => {
      video.play()
    })
  })
}

function toggleFullScreen(app) {
  app.ports.toggleFullScreen.subscribe(() => {
    const fullScreenElement =
      document.fullscreenElement ||
      document.mozFullScreenElement ||
      document.webkitFullscreenElement

    if (fullScreenElement) {
      exitFullScreen()
    } else {
      launchFullScreen()
    }
  })
}

function launchFullScreen() {
  const documentElement = document.documentElement

  if (documentElement.requestFullScreen) {
    documentElement.requestFullScreen()
  } else if (documentElement.mozRequestFullScreen) {
    documentElement.mozRequestFullScreen()
  } else {
    documentElement.webkitRequestFullScreen &&
      documentElement.webkitRequestFullScreen()
  }
}

function exitFullScreen() {
  if (document.exitFullscreen) {
    document.exitFullscreen()
  } else if (document.mozCancelFullScreen) {
    document.mozCancelFullScreen()
  } else {
    document.webkitExitFullscreen && document.webkitExitFullscreen()
  }
}

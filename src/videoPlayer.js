export function initPorts(app) {
  cancelFullScreen(app)
  pause(app)
  play(app)
  toggleFullScreen(app)
}

function cancelFullScreen(app) {
  app.ports.exitFullScreen.subscribe(() => {
    exitFullScreen()
  })
}


function pause(app) {
  app.ports.pauseVideos.subscribe(() => {
    pauseVideos()
  })
}

function play(app) {
  app.ports.playVideos.subscribe(() => {
    playVideos()
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

function pauseVideos() {
  const videos = [...document.getElementsByTagName("video")]
  videos.forEach((video) => {
    video.pause()
  })
}

function playVideos() {
  const videos = [...document.getElementsByTagName("video")]
  videos.forEach((video) => {
    video.play()
  })
}

export function initPorts(app) {
  toggleFullScreen(app)
  toggleVideoPlay(app)
}

function toggleFullScreen(app) {
  app.ports.toggleFullScreen.subscribe(() => {
    let fullScreenElement =
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

function toggleVideoPlay(app) {
  app.ports.toggleVideoPlay.subscribe((play) => {
    let videos = Array.from(document.getElementsByTagName("video"))

    if (play) {
      videos.forEach((video) => {
        video.play()
      })
    } else {
      videos.forEach((video) => {
        video.pause()
      })
    }
  })
}

function launchFullScreen() {
  let documentElement = document.documentElement

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

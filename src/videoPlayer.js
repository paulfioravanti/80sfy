export function initPorts(app) {
  initWindowListeners(app)
  cancelFullScreen(app)
  pause(app)
  play(app)
  toggleFullScreen(app)
}

// REF: https://stackoverflow.com/questions/1760250/how-to-tell-if-browser-tab-is-active
function initWindowListeners(app) {
  ["focus", "blur"].forEach((event) => {
    window.addEventListener(event, (e) => {
      const prevType =
        window.sessionStorage.getItem("elm-80sfy-last-event-type")
      if (prevType != e.type) {
        switch (e.type) {
          case "blur":
            pauseVideos()
            app.ports.videosHalted.send(null)
            break
          case "focus":
            playVideos()
            app.ports.videosPlaying.send(null)
            break
        }
      }
      window.sessionStorage.setItem("elm-80sfy-last-event-type", e.type)
    })
  })
}

function cancelFullScreen(app) {
  app.ports.exitFullScreen.subscribe(() => {
    exitFullScreen()
  })
}


function pause(app) {
  app.ports.pauseVideos.subscribe(() => {
    pauseVideos()
    app.ports.videosPaused.send(null)
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


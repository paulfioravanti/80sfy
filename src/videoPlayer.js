export function init(app) {
  initWindowListeners(app)
  cancelFullScreen(app)
  haltVideos(app)
  pauseVideos(app)
  playVideos(app)
  toggleFullScreen(app)
}

// REF: https://stackoverflow.com/questions/1760250/how-to-tell-if-browser-tab-is-active
function initWindowListeners(app) {
  ["focus", "blur"].forEach((eventType) => {
    window.addEventListener(eventType, event => {
      const previousEventType =
        window.sessionStorage.getItem("elm-80sfy-last-event-type")
      const currentEventType = event.type
      const audioPlayerNotInFocus =
        event.target.document.activeElement.id !== "track-player"

      if (previousEventType != currentEventType) {
        switch (currentEventType) {
          case "blur":
            // NOTE: If the document target has "blurred" from the video player
            // to the SoundCloud iframe, then the Elm app does not need to
            // consider this a "real" blur for purposes of displaying the
            // "Gifs Paused" overlay.
            if (audioPlayerNotInFocus) {
              app.ports.windowBlurred.send(null)
            }
            break
          case "focus":
            app.ports.windowFocused.send(null)
            break
        }
      }
      window.sessionStorage.setItem(
        "elm-80sfy-last-event-type", currentEventType
      )
    })
  })
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

function toggleFullScreen(app) {
  app.ports.toggleFullScreen.subscribe(() => {
    if (fullScreenElement()) {
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

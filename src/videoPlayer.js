export const VideoPlayer = {
  init
}

function init(app) {
  initHaltVideos(app)
  initPauseVideos(app)
  initPlayVideos(app)
  initWindowBlurred(app)
  initWindowFocused(app)
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

function initPlayVideos(app) {
  app.ports.playVideos.subscribe(() => {
    playVideoPlayers()
    app.ports.videosPlaying.send(null)
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

function videoPlayable(video) {
  return (
    video.paused ||
    video.ended ||
    video.seeking ||
    video.readyState > video.HAVE_FUTURE_DATA
  )
}

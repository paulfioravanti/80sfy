export const VideoPlayer = {
  init
}

function init(ports) {
  initHaltVideos(ports)
  initPauseVideos(ports)
  initPlayVideos(ports)
  initWindowBlurred(ports)
  initWindowFocused(ports)
}

function initHaltVideos(ports) {
  ports.haltVideos.subscribe(() => {
    pauseVideoPlayers()
    ports.videosHalted.send(null)
  })
}

function initPauseVideos(ports) {
  ports.pauseVideos.subscribe(() => {
    pauseVideoPlayers()
    ports.videosPaused.send(null)
  })
}

function initPlayVideos(ports) {
  ports.playVideos.subscribe(() => {
    playVideoPlayers()
    ports.fromSoundCloudWidget.send({
      "tag": "VIDEOS_PLAYING"
    })
  })
}

function initWindowBlurred(ports) {
  window.addEventListener("blur", event => {
    const activeElementId = event.target.document.activeElement.id
    ports.windowBlurred.send(activeElementId)
  })
}

function initWindowFocused(ports) {
  window.addEventListener("focus", () => {
    ports.windowFocused.send(null)
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

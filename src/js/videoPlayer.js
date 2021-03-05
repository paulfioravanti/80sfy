export const VideoPlayer = {
  init
}

function init(ports) {
  initWindowEventListeners(ports)
  ports.videoPlayerOut.subscribe(({ tag }) => {
    switch (tag) {
    case "HALT_VIDEOS":
      pauseVideoPlayers()
      ports.videosHalted.send(null)
      break
    case "PAUSE_VIDEOS":
      pauseVideoPlayers()
      ports.videosPaused.send(null)
      break
    case "PLAY_VIDEOS":
      playVideoPlayers()
      ports.videoPlayerIn.send({
        tag: "VIDEOS_PLAYING"
      })
      break
    default:
      console.log(`Unexpected videoPlayer tag ${tag}`)
    }
  })
}

function initWindowEventListeners(ports) {
  window.addEventListener("blur", event => {
    const activeElementId = event.target.document.activeElement.id
    ports.videoPlayerIn.send({
      tag: "WINDOW_BLURRED",
      payload: activeElementId
    })
  })
  window.addEventListener("focus", () => {
    ports.videoPlayerIn.send({
      tag: "WINDOW_FOCUSED"
    })
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

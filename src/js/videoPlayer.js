export const VideoPlayer = {
  init
}

function init(ports) {
  initWindowEventListeners(ports)
  ports.outbound.subscribe(({ tag }) => {
    switch (tag) {
    case "HALT_VIDEOS":
      pauseVideoPlayers()
      ports.inbound.send({
        tag: "VIDEOS_HALTED"
      })
      break
    case "PAUSE_VIDEOS":
      pauseVideoPlayers()
      ports.inbound.send({
        tag: "VIDEOS_PAUSED"
      })
      break
    case "PLAY_VIDEOS":
      playVideoPlayers()
      ports.inbound.send({
        tag: "VIDEOS_PLAYING"
      })
      break
    }
  })
}

function initWindowEventListeners(ports) {
  window.addEventListener("blur", event => {
    // NOTE: Reason for the setTimeout is for Firefox reasons:
    // https://gist.github.com/jaydson/1780598#gistcomment-2609301
    // "The problem seems to be that, at the time Firefox fires the blur event,
    // it has not yet updated the document.activeElement, so it evaluates to
    // false" and hence the id always ends up being blank.
    window.setTimeout(() => {
      const activeElementId = event.target.document.activeElement.id
      ports.inbound.send({
        tag: "WINDOW_BLURRED",
        data: activeElementId
      })
    }, 0)
  })
  window.addEventListener("focus", () => {
    ports.inbound.send({
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

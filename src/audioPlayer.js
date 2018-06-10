export function initPorts(app) {
  initAudioPlayer(app)
  pauseAudio(app)
  playAudio(app)
}

let scPlayer

function initAudioPlayer(app) {
  app.ports.initAudioPlayer.subscribe(() => {
    scPlayer = SC.Widget("track-player")
  })
}

function pauseAudio(app) {
  app.ports.pauseAudio.subscribe(() => {
    scPlayer.pause()
  })
}

function playAudio(app) {
  app.ports.playAudio.subscribe(() => {
    scPlayer.play()
  })
}

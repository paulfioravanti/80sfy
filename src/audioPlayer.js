export function initPorts(app) {
  initAudioPlayer(app)
}

let scPlayer

function initAudioPlayer(app) {
  app.ports.initAudioPlayer.subscribe(() => {
    scPlayer = SC.Widget("track-player")
  })
}

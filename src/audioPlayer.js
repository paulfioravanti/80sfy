export function initPorts(app) {
  initAudioPlayer(app)
  nextTrack(app)
  pauseAudio(app)
  playAudio(app)
  setVolume(app)
}

let scPlayer

function initAudioPlayer(app) {
  app.ports.initAudioPlayer.subscribe((volume) => {
    scPlayer = SC.Widget("track-player")
    scPlayer.setVolume(volume)
  })
}

function nextTrack(app) {
  app.ports.nextTrack.subscribe(() => {
    scPlayer.next()
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

function setVolume(app) {
  app.ports.setVolume.subscribe((volume) => {
    scPlayer.setVolume(volume)
  })
}

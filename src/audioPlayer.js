export function initPorts(app) {
  initAudioPlayer(app)
  nextTrack(app)
  pauseAudio(app)
  playAudio(app)
  setVolume(app)
  skipToTrack(app)
}

let scPlayer

function initAudioPlayer(app) {
  app.ports.initAudioPlayer.subscribe((volume) => {
    window.requestAnimationFrame(() => {
      scPlayer = SC.Widget("track-player")
      scPlayer.setVolume(volume)
      scPlayer.bind(SC.Widget.Events.READY, () => {
        scPlayer.getSounds((sounds) => {
          app.ports.setPlaylistLength.send(sounds.length)
        })
        app.ports.requestNextTrackNumber.send(null)
      })
      scPlayer.bind(SC.Widget.Events.PLAY, () => {
        app.ports.playAudioPlayer.send(null)
      })
      scPlayer.bind(SC.Widget.Events.PAUSE, () => {
        app.ports.pauseAudioPlayer.send(null)
      })
      scPlayer.bind(SC.Widget.Events.FINISH, () => {
        app.ports.requestNextTrackNumber.send(null)
      })
    })
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

function skipToTrack(app) {
  app.ports.skipToTrack.subscribe((trackNumber) => {
    scPlayer.skip(trackNumber)
  })
}

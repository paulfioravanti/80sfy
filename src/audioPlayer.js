export function initPorts(app) {
  initAudioPlayer(app)
  pause(app)
  play(app)
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
      })
      scPlayer.bind(SC.Widget.Events.PLAY, () => {
        app.ports.play.send(null)
      })
      scPlayer.bind(SC.Widget.Events.PAUSE, () => {
        app.ports.pause.send(null)
      })
      scPlayer.bind(SC.Widget.Events.FINISH, () => {
        app.ports.requestNextTrackNumber.send(null)
      })
    })
  })
}

function pause(app) {
  app.ports.pauseAudio.subscribe(() => {
    scPlayer.pause()
  })
}

function play(app) {
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

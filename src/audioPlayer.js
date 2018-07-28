export function initPorts(app) {
  initAudioPlayer(app)
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
      // NOTE: Events need to be placed under the READY event, even though
      // doing so currently seems to halt the videoplayer when the app first
      // loads. Moving the other event bindings outside of the READY scope
      // does enable the video player to keep on playing, but the call to
      // `getSounds` fails and hence the audio player only ever ends up with
      // one track in it.
      scPlayer.bind(SC.Widget.Events.READY, () => {
        scPlayer.setVolume(volume)
        scPlayer.getSounds((sounds) => {
          app.ports.setPlaylistLength.send(sounds.length)
        })
        scPlayer.bind(SC.Widget.Events.PLAY, () => {
          app.ports.audioPlaying.send(null)
        })
        scPlayer.bind(SC.Widget.Events.PAUSE, () => {
          app.ports.audioPaused.send(null)
        })
        scPlayer.bind(SC.Widget.Events.FINISH, () => {
          app.ports.requestNextTrackNumber.send(null)
        })
      })
    })
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

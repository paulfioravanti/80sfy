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
      scPlayer.bind(SC.Widget.Events.READY, () => {
        scPlayer.setVolume(volume)
        scPlayer.getSounds((sounds) => {
          app.ports.setPlaylistLength.send(sounds.length)
        })
        scPlayer.bind(SC.Widget.Events.PLAY, sound => {
          // Only let Elm know about SoundCloud player play events if at least
          // some of the sound has been loaded and can therefore actually play.
          if (sound.loadedProgress > 0) {
            app.ports.audioPlaying.send(null)
          }
        })
        scPlayer.bind(SC.Widget.Events.PAUSE, sound => {
          // Only let Elm know about SoundCloud player pause events if the
          // sound has actually first been played.
          if (sound.currentPosition > 0) {
            app.ports.audioPaused.send(null)
          }
        })
        scPlayer.bind(SC.Widget.Events.FINISH, () => {
          app.ports.requestNextTrackNumber.send(null)
        })
      })
      // NOTE: This call is to make sure that when the site is first loaded,
      // the videos play (without sound), but the control panel button shows
      // the play button to start the SoundCloud player (and technically the
      // videos as well), rather than the pause button.
      //
      // This is a bit of a hack for aesthetic reasons: I didn't want the site
      // to start with videos playing for a bit, and then automatically paused
      // suddenly for what looks like no reason. This is also the only time when
      // the controls on the control panel and the video playback itself should
      // be "out of sync".
      app.ports.videosPlaying.send(null)
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

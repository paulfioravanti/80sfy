export function init(app) {
  app.ports.initAudioPlayer.subscribe((volume) => {
    window.requestAnimationFrame(() => {
      const scPlayer = SC.Widget("track-player")
      scPlayer.bind(SC.Widget.Events.READY, () => {
        getSounds(scPlayer, app)
        playAudio(scPlayer, app)
        pauseAudio(scPlayer, app)
        setVolume(scPlayer, app)
        skipToTrack(scPlayer, app)
        trackFinished(scPlayer, app)
        initPlayerState(scPlayer, volume, app)
      })
    })
  })
}

function getSounds(scPlayer, app) {
  scPlayer.getSounds(sounds => {
    app.ports.setPlaylistLength.send(sounds.length)
  })
}

function playAudio(scPlayer, app) {
  app.ports.playAudio.subscribe(() => {
    scPlayer.play()
  })
  scPlayer.bind(SC.Widget.Events.PLAY, sound => {
    // Only let Elm know about SoundCloud player play events if at least
    // some of the sound has been loaded and can therefore actually play.
    if (sound.loadedProgress > 0) {
      app.ports.audioPlaying.send(null)
    }
  })
}

function pauseAudio(scPlayer, app) {
  app.ports.pauseAudio.subscribe(() => {
    scPlayer.pause()
  })
  scPlayer.bind(SC.Widget.Events.PAUSE, sound => {
    // Only let Elm know about SoundCloud player pause events if the
    // sound has actually first been played.
    if (sound.currentPosition > 0) {
      app.ports.audioPaused.send(null)
    }
  })
}

function setVolume(scPlayer, app, volume) {
  app.ports.setVolume.subscribe((volume) => {
    scPlayer.setVolume(volume)
  })
}

function skipToTrack(scPlayer, app) {
  app.ports.skipToTrack.subscribe((trackNumber) => {
    scPlayer.skip(trackNumber)
  })
}

function trackFinished(scPlayer, app) {
  scPlayer.bind(SC.Widget.Events.FINISH, () => {
    app.ports.requestNextTrackNumber.send(null)
  })
}

function initPlayerState(scPlayer, volume, app) {
  scPlayer.setVolume(volume)
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
}

export const AudioPlayer = {
  init
}

function init(app) {
  app.ports.initAudioPlayer.subscribe(({ id: id, volume: volume }) => {
    window.requestAnimationFrame(() => {
      const scPlayer = SC.Widget(id)
      scPlayer.bind(SC.Widget.Events.READY, () => {
        initAudioPlayer(scPlayer, volume, app)
        initPlayAudio(scPlayer, app)
        initPauseAudio(scPlayer, app)
        initSetVolume(scPlayer, app)
        initSkipToTrack(scPlayer, app)
        initTrackFinished(scPlayer, app)
      })
    })
  })
}

function initAudioPlayer(scPlayer, volume, app) {
  scPlayer.setVolume(volume)
  scPlayer.getSounds(sounds => {
    app.ports.setPlaylistLength.send(sounds.length)
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
}

function initPlayAudio(scPlayer, app) {
  app.ports.playAudio.subscribe(() => {
    scPlayer.play()
  })
  scPlayer.bind(SC.Widget.Events.PLAY, sound => {
    app.ports.audioPlaying.send(sound.loadedProgress)
  })
}

function initPauseAudio(scPlayer, app) {
  app.ports.pauseAudio.subscribe(() => {
    scPlayer.pause()
  })
  scPlayer.bind(SC.Widget.Events.PAUSE, sound => {
    app.ports.audioPaused.send(sound.currentPosition)
  })
}

function initSetVolume(scPlayer, app) {
  app.ports.setVolume.subscribe(volume => {
    scPlayer.setVolume(volume)
  })
}

function initSkipToTrack(scPlayer, app) {
  app.ports.skipToTrack.subscribe(trackNumber => {
    scPlayer.skip(trackNumber)
  })
}

function initTrackFinished(scPlayer, app) {
  scPlayer.bind(SC.Widget.Events.FINISH, () => {
    app.ports.requestNextTrackNumber.send(null)
  })
}

export const SoundCloudWidget = {
  init
}

function init(ports) {
  ports.toSoundCloudWidget.subscribe(({ tag, payload }) => {
    switch (tag) {
    case "INIT": {
      const { id, volume } = payload
      window.requestAnimationFrame(() => {
        const scPlayer = SC.Widget(id)
        scPlayer.bind(SC.Widget.Events.READY, () => {
          initAudioPlayer(scPlayer, volume, ports)
          initPlayAudio(scPlayer, ports)
          initPauseAudio(scPlayer, ports)
          initSetVolume(scPlayer, ports)
          initSkipToTrack(scPlayer, ports)
          initTrackFinished(scPlayer, ports)
        })
      })
      break
    }
    default:
      console.log(`Unexpected SoundCloudWidget tag ${tag}`)
    }
  })
}

function initAudioPlayer(scPlayer, volume, ports) {
  scPlayer.setVolume(volume)
  scPlayer.getSounds(sounds => {
    ports.playlistLengthSet.send(sounds.length)
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
  ports.videosPlaying.send(null)
}

function initPlayAudio(scPlayer, ports) {
  ports.playAudio.subscribe(() => {
    scPlayer.play()
  })
  scPlayer.bind(SC.Widget.Events.PLAY, sound => {
    ports.audioPlaying.send(sound.loadedProgress)
  })
}

function initPauseAudio(scPlayer, ports) {
  ports.pauseAudio.subscribe(() => {
    scPlayer.pause()
  })
  scPlayer.bind(SC.Widget.Events.PAUSE, sound => {
    ports.audioPaused.send(sound.currentPosition)
  })
}

function initSetVolume(scPlayer, ports) {
  ports.setVolume.subscribe(volume => {
    scPlayer.setVolume(volume)
  })
}

function initSkipToTrack(scPlayer, ports) {
  ports.skipToTrack.subscribe(trackNumber => {
    scPlayer.skip(trackNumber)
  })
}

function initTrackFinished(scPlayer, ports) {
  scPlayer.bind(SC.Widget.Events.FINISH, () => {
    ports.nextTrackNumberRequested.send(null)
  })
}

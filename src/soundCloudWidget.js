export const SoundCloudWidget = {
  init
}

function init(ports) {
  ports.toSoundCloudWidget.subscribe(({ tag, payload }) => {
    switch (tag) {
    case "INIT_WIDGET":
      initWidget(ports, payload)
      break
    default:
      console.log(`Unexpected soundCloudWidget tag ${tag}`)
    }
  })
}

function initWidget(ports, { id, volume }) {
  window.requestAnimationFrame(() => {
    const scPlayer = SC.Widget(id)
    scPlayer.bind(SC.Widget.Events.READY, () => {
      initAudioPlayer(scPlayer, volume, ports)
      bindSoundCloudWidgetEvents(scPlayer, ports)
      initPortSubscriptions(scPlayer, ports)
    })
  })
}

function initAudioPlayer(scPlayer, volume, ports) {
  scPlayer.setVolume(volume)
  scPlayer.getSounds(sounds => {
    ports.fromSoundCloudWidget.send({
      tag: "PLAYLIST_LENGTH_SET",
      payload: sounds.length
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
  ports.fromSoundCloudWidget.send({
    tag: "VIDEOS_PLAYING"
  })
}

function bindSoundCloudWidgetEvents(scPlayer, ports) {
  scPlayer.bind(SC.Widget.Events.PLAY, sound => {
    ports.fromSoundCloudWidget.send({
      tag: "AUDIO_PLAYING",
      payload: sound.loadedProgress
    })
  })
  scPlayer.bind(SC.Widget.Events.PAUSE, sound => {
    ports.fromSoundCloudWidget.send({
      tag: "AUDIO_PAUSED",
      payload: sound.currentPosition
    })
  })
  scPlayer.bind(SC.Widget.Events.FINISH, () => {
    ports.fromSoundCloudWidget.send({
      tag: "NEXT_TRACK_NUMBER_REQUESTED"
    })
  })
}

function initPortSubscriptions(scPlayer, ports) {
  ports.toSoundCloudWidget.subscribe(({ tag, payload }) => {
    switch (tag) {
    case "PLAY_AUDIO":
      scPlayer.play()
      break
    case "PAUSE_AUDIO":
      scPlayer.pause()
      break
    case "SET_VOLUME":
      scPlayer.setVolume(payload.volume)
      break
    case "SKIP_TO_TRACK":
      scPlayer.skip(payload.trackNumber)
      break
    default:
      console.log(`Unexpected SoundCloudWidget tag ${tag}`)
    }
  })
}

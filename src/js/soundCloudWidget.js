export const SoundCloudWidget = {
  init
}

function init(ports) {
  ports.outbound.subscribe(({ tag, data }) => {
    switch (tag) {
    case "INIT_WIDGET":
      initWidget(ports, data)
      break
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
  // NOTE: This call is to make sure that when the site is first loaded,
  // the videos play (without sound), but the control panel button shows
  // the play button to start the SoundCloud player (and technically the
  // videos as well), rather than the pause button.
  //
  // This is a bit of a hack for ａｅｓｔｈｅｔｉｃ reasons: I didn't want the
  // site to start with videos playing for a bit, and then automatically paused
  // suddenly for what looks like no reason. This is also the only time when
  // the controls on the control panel and the video playback itself should
  // be "out of sync".
  ports.inbound.send({
    tag: "VIDEOS_PLAYING"
  })
  // NOTE: The SoundCloud Iframe seems to require a little bit of time to
  // initialise before it can get its sounds, so in order to avoid
  // "Uncaught Error: mediaPayload required." errors displaying in the console,
  // introduce this one-time delay.
  window.setTimeout(() => {
    scPlayer.getSounds(sounds => {
      ports.inbound.send({
        tag: "PLAYLIST_LENGTH_FETCHED",
        data: sounds.length
      })
    })
  }, 3000)
}

function bindSoundCloudWidgetEvents(scPlayer, ports) {
  scPlayer.bind(SC.Widget.Events.PLAY, sound => {
    ports.inbound.send({
      tag: "AUDIO_PLAYING",
      data: sound.loadedProgress
    })
  })
  scPlayer.bind(SC.Widget.Events.PAUSE, sound => {
    ports.inbound.send({
      tag: "AUDIO_PAUSED",
      data: sound.currentPosition
    })
  })
  scPlayer.bind(SC.Widget.Events.FINISH, () => {
    ports.inbound.send({
      tag: "NEXT_TRACK_NUMBER_REQUESTED"
    })
  })
}

function initPortSubscriptions(scPlayer, ports) {
  ports.outbound.subscribe(({ tag, data }) => {
    switch (tag) {
    case "PLAY_AUDIO":
      scPlayer.play()
      break
    case "PAUSE_AUDIO":
      scPlayer.pause()
      break
    case "SET_VOLUME":
      scPlayer.setVolume(data.volume)
      break
    case "SKIP_TO_TRACK":
      // NOTE: The call to `scPlayer.skip` forcably *unpauses* the player, so if
      // the player was originally paused before the `skip` command, we want to
      // keep the SoundCloud widget player paused by *re-pausing* it.
      scPlayer.isPaused(paused => {
        scPlayer.skip(data.trackNumber)
        if (paused) {
          scPlayer.pause()
        }
      })
      break
    }
  })
}

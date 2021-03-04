export const Mozilla = {
  isMozilla,
  handleMessages,
  initFullScreenHack
}

function isMozilla() {
  return (
    document.mozFullScreenElement !== undefined &&
    document.documentElement.mozRequestFullScreen &&
    document.mozCancelFullScreen
  )
}

function handleMessages(ports) {
  ports.toBrowserVendor.subscribe(({ tag }) => {
    switch (tag) {
    case "EXIT_FULL_SCREEN":
      document.mozCancelFullScreen()
      break
    case "REQUEST_FULL_SCREEN":
      document.documentElement.mozRequestFullScreen()
      break
    case "TOGGLE_FULL_SCREEN": {
      const isFullScreen = !!document.mozFullScreenElement
      if (isFullScreen) {
        document.mozCancelFullScreen()
      } else {
        document.documentElement.mozRequestFullScreen()
      }
      break
    }
    default:
      console.log(`Unexpected browserVendor tag ${tag}`)
    }
  })
}

function initFullScreenHack() {
  // Hopefully this function can be removed in later versions of Elm, but
  // the issue is that the Elm-style initMozFullScreenToggle function above
  // does not seem to work as Firefox requires the fullscreen event to occur
  // in the same clock tick as the user click. If you use the function
  // above, in the console, you will see "Request for fullscreen was denied
  // because Element.requestFullscreen() was not called from inside a short
  // running user-generated event handler.". I don't currently know how to
  // fix this.
  // More information can be found at:
  // - https://groups.google.com/d/msg/elm-dev/hhNu6SGOM54/TS0pDPtKCAAJ
  // - https://stackoverflow.com/q/43240352/567863
  window.mozFullScreenToggleHack = () => {
    const isFullScreen = !!document.mozFullScreenElement
    if (isFullScreen) {
      document.mozCancelFullScreen()
    } else {
      document.documentElement.mozRequestFullScreen()
    }
  }
}

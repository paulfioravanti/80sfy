export const BrowserVendor = {
  init,
  current,
}

const WEBKIT = "webkit"
const MOZILLA = "mozilla"
const OTHER = "other"

function init(ports) {
  switch(current()) {
  case WEBKIT:
    handleWebkitMessages(ports)
    break
  case MOZILLA:
    handleMozillaMessages(ports)
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
    break
  case OTHER:
    handleOtherMessages(ports)
    break
  default:
    console.log("Could not determine browser vendor!")
  }
}

function current() {
  if (isWebkit()) {
    return WEBKIT
  } else if (isMozilla()) {
    return MOZILLA
  } else if (isOtherFullScreenCapableBrowser()) {
    return OTHER
  }
}

// WEBKIT

function isWebkit() {
  return (
    document.webkitFullscreenElement !== undefined &&
    document.documentElement.webkitRequestFullScreen &&
    document.webkitExitFullscreen
  )
}

function handleWebkitMessages(ports) {
  ports.toBrowserVendor.subscribe(({ tag }) => {
    switch (tag) {
    case "EXIT_FULL_SCREEN":
      document.webkitExitFullscreen()
      break
    case "FULL_SCREEN_TOGGLE": {
      const isFullScreen = !!document.webkitFullscreenElement
      ports.fromBrowserVendor.send({
        "tag": "IS_FULL_SCREEN",
        "payload": isFullScreen
      })
      break
    }
    case "REQUEST_FULL_SCREEN":
      document.documentElement.webkitRequestFullScreen()
      break
    default:
      console.log(`Unexpected tag ${tag}`)
    }
  })
}

// MOZILLA

function isMozilla() {
  return (
    document.mozFullScreenElement !== undefined &&
    document.documentElement.mozRequestFullScreen &&
    document.mozCancelFullScreen
  )
}

function handleMozillaMessages(ports) {
  ports.toBrowserVendor.subscribe(({ tag }) => {
    switch (tag) {
    case "EXIT_FULL_SCREEN":
      document.mozCancelFullScreen()
      break
    case "FULL_SCREEN_TOGGLE": {
      const isFullScreen = !!document.mozFullScreenElement
      ports.fromBrowserVendor.send({
        "tag": "IS_FULL_SCREEN",
        "payload": isFullScreen
      })
      break
    }
    case "REQUEST_FULL_SCREEN":
      document.documentElement.mozRequestFullScreen()
      break
    default:
      console.log(`Unexpected tag ${tag}`)
    }
  })
}

// OTHER

function isOtherFullScreenCapableBrowser() {
  return (
    document.fullScreenElement !== undefined &&
    document.documentElement.requestFullScreen &&
    document.exitFullscreen
  )
}

function handleOtherMessages(ports) {
  ports.toBrowserVendor.subscribe(({ tag }) => {
    switch (tag) {
    case "EXIT_FULL_SCREEN":
      document.exitFullscreen()
      break
    case "FULL_SCREEN_TOGGLE": {
      const isFullScreen = !!document.fullscreenElement
      ports.fromBrowserVendor.send({
        "tag": "IS_FULL_SCREEN",
        "payload": isFullScreen
      })
      break
    }
    case "REQUEST_FULL_SCREEN":
      document.documentElement.requestFullScreen()
      break
    default:
      console.log(`Unexpected tag ${tag}`)
    }
  })
}

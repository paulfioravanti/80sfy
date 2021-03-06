export const Other = {
  isFullscreenEnabledBrowser,
  handleMessages
}

function isFullscreenEnabledBrowser() {
  return (
    document.fullscreenEnabled &&
    document.documentElement.requestFullscreen &&
    document.exitFullscreen
  )
}

function handleMessages(ports) {
  ports.outbound.subscribe(({ tag }) => {
    switch (tag) {
    case "EXIT_FULL_SCREEN":
      document.exitFullscreen()
      break
    case "TOGGLE_FULL_SCREEN": {
      const isFullScreen = !!document.fullscreenElement
      if (isFullScreen) {
        document.exitFullscreen()
      } else {
        document.documentElement.requestFullscreen()
      }
      break
    }
    }
  })
}

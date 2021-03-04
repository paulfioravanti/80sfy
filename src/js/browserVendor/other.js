export const OTHER = "other"

export function isOtherFullScreenCapableBrowser() {
  return (
    document.fullScreenElement !== undefined &&
    document.documentElement.requestFullScreen &&
    document.exitFullscreen
  )
}

export function handleOtherMessages(ports) {
  ports.toBrowserVendor.subscribe(({ tag }) => {
    switch (tag) {
    case "EXIT_FULL_SCREEN":
      document.exitFullscreen()
      break
    case "REQUEST_FULL_SCREEN":
      document.documentElement.requestFullScreen()
      break
    case "TOGGLE_FULL_SCREEN": {
      const isFullScreen = !!document.fullscreenElement
      if (isFullScreen) {
        document.exitFullscreen()
      } else {
        document.documentElement.requestFullScreen()
      }
      break
    }
    default:
      console.log(`Unexpected browserVendor tag ${tag}`)
    }
  })
}

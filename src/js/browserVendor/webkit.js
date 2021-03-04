export const WEBKIT = "webkit"

export function isWebkit() {
  return (
    document.webkitFullscreenElement !== undefined &&
    document.documentElement.webkitRequestFullScreen &&
    document.webkitExitFullscreen
  )
}

export function handleWebkitMessages(ports) {
  ports.toBrowserVendor.subscribe(({ tag }) => {
    switch (tag) {
    case "EXIT_FULL_SCREEN":
      document.webkitExitFullscreen()
      break
    case "REQUEST_FULL_SCREEN":
      document.documentElement.webkitRequestFullScreen()
      break
    case "TOGGLE_FULL_SCREEN": {
      const isFullScreen = !!document.webkitFullscreenElement
      if (isFullScreen) {
        document.webkitExitFullscreen()
      } else {
        document.documentElement.webkitRequestFullScreen()
      }
      break
    }
    default:
      console.log(`Unexpected browserVendor tag ${tag}`)
    }
  })
}

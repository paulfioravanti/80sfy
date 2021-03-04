import {
  WEBKIT,
  isWebkit,
  handleWebkitMessages
} from "./browserVendor/webkit"
import {
  MOZILLA,
  isMozilla,
  handleMozillaMessages,
  initMozillaFullScreenHack
} from "./browserVendor/mozilla"
import {
  OTHER,
  isOtherFullScreenCapableBrowser,
  handleOtherMessages
} from "./browserVendor/other"

export const BrowserVendor = {
  init,
  current,
}

function init(ports) {
  switch (current()) {
  case WEBKIT:
    handleWebkitMessages(ports)
    break
  case MOZILLA:
    handleMozillaMessages(ports)
    initMozillaFullScreenHack()
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

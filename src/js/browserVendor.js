import { Mozilla } from "./browserVendor/mozilla"
import { Other } from "./browserVendor/other"
import { Webkit } from "./browserVendor/webkit"

export const BrowserVendor = {
  init,
  current,
}

const MOZILLA = "mozilla"
const OTHER = "other"
const WEBKIT = "webkit"

function init(ports) {
  switch (current()) {
  case MOZILLA:
    Mozilla.handleMessages(ports)
    Mozilla.initFullScreenHack()
    break
  case OTHER:
    Other.handleOtherMessages(ports)
    break
  case WEBKIT:
    Webkit.handleMessages(ports)
    break
  default:
    console.log("Could not determine browser vendor!")
  }
}

function current() {
  if (Mozilla.isMozilla()) {
    return MOZILLA
  } else if (Other.isFullScreenCapableBrowser()) {
    return OTHER
  } else if (Webkit.isWebkit()) {
    return WEBKIT
  } else {
    return null
  }
}

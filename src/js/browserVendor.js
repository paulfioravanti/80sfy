import { Other } from "./browserVendor/other"
import { Webkit } from "./browserVendor/webkit"

export const BrowserVendor = {
  init,
  current,
}

const WEBKIT = "webkit"
const OTHER = "other"

function init(ports) {
  switch (current()) {
  case WEBKIT:
    Webkit.handleMessages(ports)
    break
  case OTHER:
    Other.handleMessages(ports)
    break
  default:
    console.log("Could not determine browser vendor!")
  }
}

function current() {
  if (Webkit.isWebkit()) {
    return WEBKIT
  } else if (Other.isFullScreenEnabledBrowser()) {
    return OTHER
  } else {
    return null
  }
}

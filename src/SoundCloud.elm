module SoundCloud exposing
    ( SoundCloudIframeUrl
    , SoundCloudPlaylistUrl
    , defaultPlaylistUrlString
    , iframeUrl
    , initWidget
    , playlistUrl
    , rawIframeUrl
    , rawPlaylistUrl
    )

import Port
import SoundCloud.Url as Url


type alias SoundCloudIframeUrl =
    Url.SoundCloudIframeUrl


type alias SoundCloudPlaylistUrl =
    Url.SoundCloudPlaylistUrl


defaultPlaylistUrlString : String
defaultPlaylistUrlString =
    Url.defaultPlaylistUrlString


iframeUrl : SoundCloudPlaylistUrl -> SoundCloudIframeUrl
iframeUrl soundCloudPlaylistUrl =
    Url.iframeUrl soundCloudPlaylistUrl


initWidget : ( String, Int ) -> Cmd msg
initWidget payloadValues =
    Port.initSoundCloudWidget payloadValues


rawIframeUrl : SoundCloudIframeUrl -> String
rawIframeUrl soundCloudIframeUrl =
    Url.rawIframeUrl soundCloudIframeUrl


rawPlaylistUrl : SoundCloudPlaylistUrl -> String
rawPlaylistUrl soundCloudPlaylistUrl =
    Url.rawPlaylistUrl soundCloudPlaylistUrl


playlistUrl : String -> SoundCloudPlaylistUrl
playlistUrl rawSoundCloudPlaylistUrlString =
    Url.playlistUrl rawSoundCloudPlaylistUrlString

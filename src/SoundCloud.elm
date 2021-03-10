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

import Port exposing (SoundCloudWidgetPayload)
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


initWidget : SoundCloudWidgetPayload -> Cmd msg
initWidget payload =
    Port.initSoundCloudWidget payload


rawIframeUrl : SoundCloudIframeUrl -> String
rawIframeUrl soundCloudIframeUrl =
    Url.rawIframeUrl soundCloudIframeUrl


rawPlaylistUrl : SoundCloudPlaylistUrl -> String
rawPlaylistUrl soundCloudPlaylistUrl =
    Url.rawPlaylistUrl soundCloudPlaylistUrl


playlistUrl : String -> SoundCloudPlaylistUrl
playlistUrl rawSoundCloudPlaylistUrlString =
    Url.playlistUrl rawSoundCloudPlaylistUrlString

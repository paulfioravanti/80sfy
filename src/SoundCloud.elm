module SoundCloud exposing
    ( SoundCloudIframeUrl
    , SoundCloudPlaylistUrl
    , defaultPlaylistUrl
    , defaultPlaylistUrlString
    , iframeUrl
    , playlistUrl
    , rawIframeUrl
    , rawPlaylistUrl
    )

import SoundCloud.Url as Url


type alias SoundCloudIframeUrl =
    Url.SoundCloudIframeUrl


type alias SoundCloudPlaylistUrl =
    Url.SoundCloudPlaylistUrl


defaultPlaylistUrl : SoundCloudPlaylistUrl
defaultPlaylistUrl =
    Url.defaultPlaylistUrl


defaultPlaylistUrlString : String
defaultPlaylistUrlString =
    Url.defaultPlaylistUrlString


iframeUrl : SoundCloudPlaylistUrl -> SoundCloudIframeUrl
iframeUrl soundCloudPlaylistUrl =
    Url.iframeUrl soundCloudPlaylistUrl


rawIframeUrl : SoundCloudIframeUrl -> String
rawIframeUrl soundCloudIframeUrl =
    Url.rawIframeUrl soundCloudIframeUrl


rawPlaylistUrl : SoundCloudPlaylistUrl -> String
rawPlaylistUrl soundCloudPlaylistUrl =
    Url.rawPlaylistUrl soundCloudPlaylistUrl


playlistUrl : String -> Maybe SoundCloudPlaylistUrl
playlistUrl rawSoundCloudPlaylistUrlString =
    Url.playlistUrl rawSoundCloudPlaylistUrlString

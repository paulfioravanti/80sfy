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

import SoundCloud.Flags exposing (Flags)
import SoundCloud.Ports as Ports


type SoundCloudIframeUrl
    = SoundCloudIframeUrl String


type SoundCloudPlaylistUrl
    = SoundCloudPlaylistUrl String


defaultPlaylistUrlString : String
defaultPlaylistUrlString =
    "https://api.soundcloud.com/playlists/193785575"


iframeUrl : SoundCloudPlaylistUrl -> SoundCloudIframeUrl
iframeUrl soundCloudPlaylistUrl =
    let
        rawIframeUrlString =
            "https://w.soundcloud.com/player/"
                ++ "?url="
                ++ rawPlaylistUrl soundCloudPlaylistUrl
                ++ "&auto_play=false"
                ++ "&buying=true"
                ++ "&liking=true"
                ++ "&download=true"
                ++ "&sharing=true"
                ++ "&show_artwork=true"
                ++ "&show_comments=false"
                ++ "&show_playcount=false"
                ++ "&show_user=false"
                ++ "&hide_related=false"
                ++ "&visual=false"
                ++ "&callback=true"
    in
    SoundCloudIframeUrl rawIframeUrlString


initWidget : Flags -> Cmd msg
initWidget flags =
    Ports.initSoundCloudWidget flags


rawIframeUrl : SoundCloudIframeUrl -> String
rawIframeUrl (SoundCloudIframeUrl rawIframeUrlString) =
    rawIframeUrlString


rawPlaylistUrl : SoundCloudPlaylistUrl -> String
rawPlaylistUrl (SoundCloudPlaylistUrl rawplaylistUrlString) =
    rawplaylistUrlString


playlistUrl : String -> SoundCloudPlaylistUrl
playlistUrl rawSoundCloudPlaylistUrlString =
    SoundCloudPlaylistUrl rawSoundCloudPlaylistUrlString

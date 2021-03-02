module SoundCloud.Url exposing
    ( SoundCloudIframeUrl
    , SoundCloudPlaylistUrl
    , defaultPlaylistUrlString
    , iframeUrl
    , playlistUrl
    , rawIframeUrl
    , rawPlaylistUrl
    )


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


rawIframeUrl : SoundCloudIframeUrl -> String
rawIframeUrl (SoundCloudIframeUrl rawIframeUrlString) =
    rawIframeUrlString


rawPlaylistUrl : SoundCloudPlaylistUrl -> String
rawPlaylistUrl (SoundCloudPlaylistUrl rawplaylistUrlString) =
    rawplaylistUrlString


playlistUrl : String -> SoundCloudPlaylistUrl
playlistUrl rawSoundCloudPlaylistUrlString =
    SoundCloudPlaylistUrl rawSoundCloudPlaylistUrlString

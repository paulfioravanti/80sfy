module SoundCloud.Url exposing
    ( SoundCloudIframeUrl
    , SoundCloudPlaylistUrl
    , defaultPlaylistUrl
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


defaultPlaylistUrl : SoundCloudPlaylistUrl
defaultPlaylistUrl =
    SoundCloudPlaylistUrl (playlistUrlPrefix ++ defaultPlaylistUrlString)


defaultPlaylistUrlString : String
defaultPlaylistUrlString =
    playlistUrlPrefix ++ "playlists/193785575"


iframeUrl : SoundCloudPlaylistUrl -> SoundCloudIframeUrl
iframeUrl soundCloudPlaylistUrl =
    let
        -- NOTE: auto_play here is false due to not wanting to have the first
        -- track in the non-shuffled playlist start playing automatically as
        -- soon as the iframe loads.
        rawIframeUrlString : String
        rawIframeUrlString =
            String.join
                ""
                [ "https://w.soundcloud.com/player/"
                , "?url="
                , rawPlaylistUrl soundCloudPlaylistUrl
                , "&auto_play=false"
                , "&buying=false"
                , "&liking=false"
                , "&download=false"
                , "&sharing=false"
                , "&show_artwork=true"
                , "&show_comments=false"
                , "&show_playcount=false"
                , "&show_user=false"
                , "&hide_related=false"
                , "&visual=false"
                , "&callback=true"
                ]
    in
    SoundCloudIframeUrl rawIframeUrlString


playlistUrl : String -> Maybe SoundCloudPlaylistUrl
playlistUrl rawSoundCloudPlaylistUrlString =
    let
        isValidUrl : Bool
        isValidUrl =
            String.startsWith playlistUrlPrefix rawSoundCloudPlaylistUrlString
    in
    if isValidUrl then
        Just (SoundCloudPlaylistUrl rawSoundCloudPlaylistUrlString)

    else
        Nothing


rawIframeUrl : SoundCloudIframeUrl -> String
rawIframeUrl (SoundCloudIframeUrl rawIframeUrlString) =
    rawIframeUrlString


rawPlaylistUrl : SoundCloudPlaylistUrl -> String
rawPlaylistUrl (SoundCloudPlaylistUrl rawplaylistUrlString) =
    rawplaylistUrlString



-- PRIVATE


playlistUrlPrefix : String
playlistUrlPrefix =
    "https://api.soundcloud.com/"

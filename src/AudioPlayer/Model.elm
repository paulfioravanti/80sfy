module AudioPlayer.Model exposing (AudioPlayer, Status(..), init, isPlaying)


type Status
    = Playing
    | Paused


type alias AudioPlayer =
    { muted : Bool
    , playlistLength : Int
    , playlistTrackOrder : List Int
    , soundCloudIframeUrl : String
    , status : Status
    , volume : Int
    }


init : String -> AudioPlayer
init soundCloudPlaylistUrl =
    { muted = False
    , playlistLength = 0
    , playlistTrackOrder = []
    , soundCloudIframeUrl = iframeUrl soundCloudPlaylistUrl
    , status = Paused
    , volume = 80
    }


iframeUrl : String -> String
iframeUrl soundCloudPlaylistUrl =
    "https://w.soundcloud.com/player/"
        ++ "?url="
        ++ soundCloudPlaylistUrl
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


isPlaying : AudioPlayer -> Bool
isPlaying { status } =
    status == Playing

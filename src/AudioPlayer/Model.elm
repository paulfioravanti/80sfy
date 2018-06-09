module AudioPlayer.Model exposing (AudioPlayer, init)


type alias AudioPlayer =
    { muted : Bool
    , playing : Bool
    , soundCloudIframeUrl : String
    , volume : String
    }


init : String -> AudioPlayer
init soundCloudPlaylistUrl =
    { muted = False
    , playing = False
    , soundCloudIframeUrl = iframeUrl soundCloudPlaylistUrl
    , volume = "80"
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

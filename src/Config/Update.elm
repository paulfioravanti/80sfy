module Config.Update exposing (ParentMsgs, update)

import AudioPlayer
import Config.Model as Model exposing (Config)
import Config.Msg as Msg exposing (Msg)
import Config.Task as Task
import Gif exposing (GifDisplayIntervalSeconds)
import Http exposing (Error)
import Ports
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag exposing (Tag)
import VideoPlayer exposing (VideoPlayerId)


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , configMsg : Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : ParentMsgs msgs msg -> Msg -> Config -> ( Config, Cmd msg )
update parentMsgs msg config =
    case msg of
        Msg.InitTags tagList ->
            ( { config | tags = List.map Tag.tag tagList }, Cmd.none )

        Msg.RandomTagGenerated videoPlayerId tag ->
            let
                randomGifUrlFetchedMsg : Result Error String -> msg
                randomGifUrlFetchedMsg =
                    VideoPlayer.randomGifUrlFetchedMsg
                        parentMsgs.videoPlayerMsg
                        videoPlayerId

                fetchRandomGifUrl : Cmd msg
                fetchRandomGifUrl =
                    Gif.fetchRandomGifUrl
                        randomGifUrlFetchedMsg
                        config.giphyApiKey
                        tag
            in
            ( config, fetchRandomGifUrl )

        Msg.Save soundCloudPlaylistUrl tags displayIntervalSeconds ->
            let
                gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
                gifDisplayIntervalSeconds =
                    Model.parseGifDisplayIntervalSeconds
                        config.gifDisplayIntervalSeconds
                        displayIntervalSeconds

                cmd : Cmd msg
                cmd =
                    if
                        soundCloudPlaylistUrl
                            == config.soundCloudPlaylistUrl
                    then
                        Cmd.none

                    else
                        AudioPlayer.performAudioPlayerReset
                            parentMsgs.audioPlayerMsg
                            soundCloudPlaylistUrl
            in
            ( { config
                | gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
                , soundCloudPlaylistUrl = soundCloudPlaylistUrl
                , tags = tags
              }
            , cmd
            )

        Msg.TagsFetched (Ok rawTags) ->
            let
                tags : List Tag
                tags =
                    List.map Tag.tag rawTags

                generateRandomTagForVideoPlayer : VideoPlayerId -> Cmd msg
                generateRandomTagForVideoPlayer videoPlayerId =
                    let
                        randomTagGeneratedMsg : Tag -> msg
                        randomTagGeneratedMsg =
                            Msg.randomTagGenerated
                                parentMsgs.configMsg
                                videoPlayerId
                    in
                    Tag.generateRandomTag randomTagGeneratedMsg tags

                performInitSecretConfigTags : Cmd msg
                performInitSecretConfigTags =
                    Task.performInitTags
                        parentMsgs.configMsg
                        rawTags
            in
            ( { config | tags = tags }
            , Cmd.batch
                [ generateRandomTagForVideoPlayer (VideoPlayer.id "1")
                , generateRandomTagForVideoPlayer (VideoPlayer.id "2")
                , performInitSecretConfigTags
                ]
            )

        Msg.TagsFetched (Err error) ->
            ( config, Ports.logError "Fetching Tags Failed" error )

        Msg.ToggleInactivityPauseOverride ->
            let
                toggledOverrideInactivityPause : Bool
                toggledOverrideInactivityPause =
                    not config.overrideInactivityPause
            in
            ( { config
                | overrideInactivityPause = toggledOverrideInactivityPause
              }
            , Cmd.none
            )

        Msg.ToggleVisibility ->
            ( { config | visible = not config.visible }
            , Cmd.none
            )

        Msg.UpdateGifDisplaySeconds seconds ->
            let
                gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
                gifDisplayIntervalSeconds =
                    Gif.updateDisplayIntervalSeconds
                        seconds
                        config.gifDisplayIntervalSeconds
            in
            ( { config
                | gifDisplayIntervalSeconds = gifDisplayIntervalSeconds
              }
            , Cmd.none
            )

        Msg.UpdateSoundCloudPlaylistUrl rawSoundCloudPlaylistUrl ->
            let
                soundCloudPlaylistUrl : SoundCloudPlaylistUrl
                soundCloudPlaylistUrl =
                    SoundCloud.playlistUrl rawSoundCloudPlaylistUrl
            in
            ( { config | soundCloudPlaylistUrl = soundCloudPlaylistUrl }
            , Cmd.none
            )

        Msg.UpdateTags tags ->
            ( { config | tags = Tag.tagList tags }
            , Cmd.none
            )

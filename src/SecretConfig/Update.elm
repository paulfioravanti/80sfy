module SecretConfig.Update exposing (ParentMsgs, update)

import AudioPlayer
import Gif exposing (GifDisplayIntervalSeconds)
import Http exposing (Error)
import SecretConfig.Model as Model exposing (SecretConfig)
import SecretConfig.Msg as Msg exposing (Msg)
import SoundCloud exposing (SoundCloudPlaylistUrl)
import Tag
import VideoPlayer exposing (VideoPlayerId)


type alias ParentMsgs msgs msg =
    { msgs
        | audioPlayerMsg : AudioPlayer.Msg -> msg
        , videoPlayerMsg : VideoPlayer.Msg -> msg
    }


update : ParentMsgs msgs msg -> Msg -> SecretConfig -> ( SecretConfig, Cmd msg )
update parentMsgs msg secretConfig =
    case msg of
        Msg.InitTags tagList ->
            ( { secretConfig | tags = List.map Tag.tag tagList }, Cmd.none )

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
                        secretConfig.giphyApiKey
                        tag
            in
            ( secretConfig, fetchRandomGifUrl )

        Msg.Save soundCloudPlaylistUrl tagsString gifDisplayIntervalSeconds ->
            let
                updatedConfig : SecretConfig
                updatedConfig =
                    Model.update
                        soundCloudPlaylistUrl
                        tagsString
                        gifDisplayIntervalSeconds
                        secretConfig

                cmd : Cmd msg
                cmd =
                    if
                        soundCloudPlaylistUrl
                            == secretConfig.soundCloudPlaylistUrl
                    then
                        Cmd.none

                    else
                        AudioPlayer.performAudioPlayerReset
                            parentMsgs.audioPlayerMsg
                            soundCloudPlaylistUrl
            in
            ( updatedConfig, cmd )

        Msg.ToggleInactivityPauseOverride ->
            let
                toggledOverrideInactivityPause : Bool
                toggledOverrideInactivityPause =
                    not secretConfig.overrideInactivityPause
            in
            ( { secretConfig
                | overrideInactivityPause = toggledOverrideInactivityPause
              }
            , Cmd.none
            )

        Msg.ToggleVisibility ->
            ( { secretConfig | visible = not secretConfig.visible }
            , Cmd.none
            )

        Msg.UpdateGifDisplaySeconds seconds ->
            let
                gifDisplayIntervalSeconds : GifDisplayIntervalSeconds
                gifDisplayIntervalSeconds =
                    Gif.updateDisplayIntervalSeconds
                        seconds
                        secretConfig.gifDisplayIntervalSeconds
            in
            ( { secretConfig
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
            ( { secretConfig | soundCloudPlaylistUrl = soundCloudPlaylistUrl }
            , Cmd.none
            )

        Msg.UpdateTags tags ->
            ( { secretConfig | tags = Tag.tagList tags }
            , Cmd.none
            )

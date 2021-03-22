module ReviewConfig exposing (config)

{-| Do not rename the ReviewConfig module or the config function, because
`elm-review` will look for these.

To add packages that contain rules, add them to this review project using

    `elm install author/packagename`

when inside the directory containing this file.

-}

import NoAlways
import NoBooleanCase
import NoDebug.Log
import NoDebug.TodoOrToString
import NoDuplicatePorts
import NoExposingEverything
import NoImportingEverything
import NoInconsistentAliases
import NoIndirectInternal
import NoMissingSubscriptionsCall
import NoMissingTypeAnnotation
import NoMissingTypeAnnotationInLetIn
import NoMissingTypeExpose
import NoModuleOnExposedNames
import NoRecursiveUpdate
import NoRedundantConcat
import NoUnsafePorts
import NoUnused.CustomTypeConstructorArgs
import NoUnused.CustomTypeConstructors
import NoUnused.Dependencies
import NoUnused.Exports
import NoUnused.Modules
import NoUnused.Parameters
import NoUnused.Patterns
import NoUnused.Variables
import NoUnusedPorts
import NoUselessSubscriptions
import Review.Rule exposing (Rule)


config : List Rule
config =
    -- NOTE: This rule removed since it fails on external Msgs that *need* to
    -- take a Posix argument yet are not themselves used in the application.
    -- , NoUnused.CustomTypeConstructorArgs.rule
    -- , NoMissingSubscriptionsCall.rule
    -- , NoMissingTypeAnnotationInLetIn.rule
    -- , NoMissingTypeExpose.rule
    -- , NoModuleOnExposedNames.rule
    [ NoAlways.rule
    , NoBooleanCase.rule
    , NoDebug.Log.rule
    , NoDebug.TodoOrToString.rule
    , NoDuplicatePorts.rule
    , NoExposingEverything.rule
    , NoImportingEverything.rule []
    , NoInconsistentAliases.config
        [ ( "Json.Decode", "Decode" )
        , ( "Json.Encode", "Encode" )
        ]
        |> NoInconsistentAliases.noMissingAliases
        |> NoInconsistentAliases.rule
    , NoIndirectInternal.rule
    , NoMissingTypeAnnotation.rule
    , NoRecursiveUpdate.rule
    , NoRedundantConcat.rule
    , NoUnsafePorts.rule NoUnsafePorts.onlyIncomingPorts
    , NoUnused.CustomTypeConstructors.rule []
    , NoUnused.Dependencies.rule
    , NoUnused.Exports.rule
    , NoUnused.Modules.rule
    , NoUnused.Parameters.rule
    , NoUnused.Patterns.rule
    , NoUnused.Variables.rule
    , NoUnusedPorts.rule
    , NoUselessSubscriptions.rule
    ]

module Note exposing (Note, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Time exposing (..)



-- NOTE


type alias Note =
    { title : String
    , id : String
    , content : String
    , timeCreated : Posix
    }



-- VIEW


view : Note -> Html msg
view model =
    let
        postDate =
            getHumanReadableDate model.timeCreated

        postTime =
            getHumanReadableTime model.timeCreated
    in
    article
        []
        [ h1 [] [ text model.title ]
        , small [] [ text ("Created " ++ postDate ++ " "), time [ datetime postTime ] [ text postTime ] ]
        , p [] [ text model.content ]
        ]


getHumanReadableDate : Posix -> String
getHumanReadableDate createdTime =
    toEnglishMonth (toMonth utc createdTime) ++ " " ++ String.fromInt (toDay utc createdTime)


getHumanReadableTime : Posix -> String
getHumanReadableTime createdTime =
    toTwoDigitString (toHour utc createdTime) ++ ":" ++ toTwoDigitString (toMinute utc createdTime)


toTwoDigitString : Int -> String
toTwoDigitString int =
    case int < 10 of
        True ->
            "0" ++ String.fromInt int

        False ->
            String.fromInt int


toEnglishMonth : Month -> String
toEnglishMonth month =
    case month of
        Jan ->
            "january"

        Feb ->
            "february"

        Mar ->
            "march"

        Apr ->
            "april"

        May ->
            "may"

        Jun ->
            "june"

        Jul ->
            "july"

        Aug ->
            "august"

        Sep ->
            "september"

        Oct ->
            "october"

        Nov ->
            "november"

        Dec ->
            "december"

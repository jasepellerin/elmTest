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
    article
        []
        [ h1 [] [ text model.title ]
        , small [] [ text ("Created " ++ getHumanReadableDatetime model.timeCreated) ]
        , p [] [ text model.content ]
        ]


getHumanReadableDatetime : Posix -> String
getHumanReadableDatetime createdTime =
    toEnglishMonth (toMonth utc createdTime) ++ " " ++ String.fromInt (toDay utc createdTime) ++ " " ++ String.fromInt (toHour utc createdTime) ++ ":" ++ String.fromInt (toMinute utc createdTime)


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

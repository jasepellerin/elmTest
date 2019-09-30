module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    { name : String
    , password : String
    , passwordAgain : String
    , passwordsMatch : Bool
    }


init : Model
init =
    Model "" "" "" True



-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Name string ->
            { model | name = string }

        Password string ->
            { model | password = string }

        PasswordAgain string ->
            { model | passwordAgain = string }



-- VIEW


view : Model -> Html Msg
view model =
    div
        [ style "background-color"
            (if model.passwordsMatch == True then
                "unset"

             else
                "red"
            )
        ]
        [ viewInput "Username" "text" Name
        , viewInput "Password" "password" Password
        , viewInput "Re-enter Password" "password" PasswordAgain
        , viewValidation model
        ]


viewInput : String -> String -> (String -> Msg) -> Html Msg
viewInput title inputType toMsg =
    label []
        [ text title
        , input
            [ type_ inputType
            , onInput toMsg
            ]
            []
        ]


viewValidation model =
    if String.length model.password < 8 then
        div [ style "color" "red" ] [ text "Password needs 8 or more characters" ]

    else if model.password /= model.passwordAgain then
        div [ style "color" "red" ] [ text "Passwords do not match!" ]

    else
        div [ style "color" "green" ] [ text "OK" ]

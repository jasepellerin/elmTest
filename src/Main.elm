module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Note
import Task
import Time


main : Program () Model Msg
main =
    Browser.document
        { init = init
        , subscriptions = subscriptions
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { currentId : Int
    , name : String
    , notes : List Note.Note
    , zone : Time.Zone
    }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


init : () -> ( Model, Cmd Msg )
init =
    always
        ( { currentId = 1
          , name = "Test"
          , zone = Time.utc
          , notes =
                []
          }
        , Task.perform AdjustTimeZone Time.here
        )



-- UPDATE


type Msg
    = AdjustTimeZone Time.Zone
    | AddNoteClick
    | AddNote Time.Posix


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AdjustTimeZone newZone ->
            ( { model | zone = newZone }, Cmd.none )

        AddNoteClick ->
            ( model, Task.perform AddNote Time.now )

        AddNote time ->
            let
                newNote =
                    { title = "New Note!"
                    , content = "We dynamic"
                    , id = model.currentId
                    , timeCreated = time
                    }
            in
            ( { model | notes = newNote :: model.notes, currentId = model.currentId + 1 }, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { body =
        [ header [] [ h1 [ style "display" "inline-block" ] [ text "notorious" ], button [ onClick AddNoteClick ] [ text "add note" ] ]
        , main_ [] (List.map (Note.view model.zone) model.notes)
        ]
    , title = "notorious"
    }

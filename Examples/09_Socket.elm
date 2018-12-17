module SocketToMe exposing (Model, Msg(..), init, main, socketUrl, subscriptions, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket



-- MODEL


type alias Model =
    { input : String
    , messages : List String
    }


init : ( Model, Cmd Msg )
init =
    ( Model "" [], Cmd.none )


socketUrl : String
socketUrl =
    "ws://localhost:8080/connect"



-- UPDATE


type Msg
    = Input String
    | SendToSocket
    | NewMessageReceived String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input str ->
            ( { model | input = str }, Cmd.none )

        SendToSocket ->
            ( model, WebSocket.send socketUrl model.input )

        NewMessageReceived str ->
            ( { model | messages = str :: model.messages }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ WebSocket.listen socketUrl NewMessageReceived
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ ul []
            (List.reverse
                (List.map (\i -> li [] [ text i ]) model.messages)
            )
        , input [ onInput Input ] []
        , button [ onClick SendToSocket ] [ text "Send" ]
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

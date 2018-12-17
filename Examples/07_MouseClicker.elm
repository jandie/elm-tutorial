module MouseClicker exposing (Model, main)

import Char exposing (..)
import Html exposing (..)
import Keyboard exposing (..)
import Mouse exposing (..)


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { x : Int
    , y : Int
    , keyPressed : Keyboard.KeyCode
    }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model 0 0 0, Cmd.none )



-- MESSAGES


type Msg
    = MouseMessage Position
    | KeyboardMessage Keyboard.KeyCode



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMessage position ->
            ( { model | x = position.x, y = position.y }, Cmd.none )

        KeyboardMessage code ->
            ( { model | keyPressed = code }, Cmd.none )



-- SUBSCRIPTION


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.moves MouseMessage
        , Keyboard.presses KeyboardMessage
        ]



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ p []
            [ text
                ("Position X is : "
                    ++ toString model.x
                    ++ " and Y is: "
                    ++ toString model.y
                )
            ]
        , div []
            [ text
                ("You pressed : "
                    ++ toString (Char.fromCode model.keyPressed)
                )
            ]
        ]

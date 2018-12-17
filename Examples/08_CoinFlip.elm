module CoinFlip exposing (Model, Msg(..), generateSide, init, main, subscriptions, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Random exposing (..)


main : Program Never Model Msg
main =
    program
        { init = init
        , subscriptions = subscriptions
        , view = view
        , update = update
        }



-- MODEL


type alias Model =
    { side : String
    , number : Int
    }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model "Heads" 0, Cmd.none )



-- MESSAGES


type Msg
    = StartFlip
    | GenerateFlip Bool
    | GetNum
    | GenerateNum Int



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UPDATES


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartFlip ->
            ( model, Random.generate GenerateFlip Random.bool )

        GenerateFlip bool ->
            ( { model | side = generateSide bool }, Cmd.none )

        GetNum ->
            ( model, Random.generate GenerateNum (Random.int 1 100) )

        GenerateNum num ->
            ( { model | number = num }, Cmd.none )


generateSide : Bool -> String
generateSide bool =
    if bool then
        "Heads"

    else
        "Tails"



-- VIEW


getImage : Model -> Attribute Msg
getImage { side } =
    let
        imgUrl =
            if side == "Heads" then
                "../images/heads.jpg"

            else
                "../images/tails.jpg"
    in
    src imgUrl


mainStyle : Attribute Msg
mainStyle =
    style
        [ ( "fontSize", "4em" )
        , ( "textAlign", "center" )
        ]


view : Model -> Html Msg
view model =
    div [ mainStyle ]
        [ img
            [ getImage model
            , style
                [ ( "height", "200px" )
                , ( "width", "200px" )
                ]
            ]
            []
        , br [] []
        , p [] [ text ("The result is: " ++ model.side) ]
        , p [] [ text ("The number is: " ++ toString model.number) ]
        , div []
            [ button [ onClick StartFlip ] [ text "Flip" ]
            ]
        , div []
            [ button [ onClick GetNum ] [ text "Generate number" ]
            ]
        ]

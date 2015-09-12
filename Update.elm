module Update where

import Signal exposing (Address)

import List exposing (filter, length)
import String

import Utils exposing (fixStr)
import Model exposing (..)

type Action = ActNop
            | ActChangePage          Page
            | ActUpdateRegisterName  String
            | ActUpdateRegisterLogin String
            | ActUpdateRegisterPass  String
            | ActRegister
            | ActUpdateLogin         String
            | ActUpdatePass          String
            | ActLogin
            | ActLogout

update : Action -> Model -> Model
update action model =
    case action of
        ActNop -> model

        ActUpdateRegisterName  name'  -> let form' = model.register_form in { model | register_form <- { form' | name     <- name'  }}
        ActUpdateRegisterLogin login' -> let form' = model.register_form in { model | register_form <- { form' | login    <- login' }}
        ActUpdateRegisterPass  pass'  -> let form' = model.register_form in { model | register_form <- { form' | password <- pass'  }}
        ActRegister ->  let
                            name'   = fixStr model.register_form.name
                            login'  = fixStr model.register_form.login
                            pass'   = fixStr model.register_form.password
                            account = model.accounts |> filter (\st -> login' == fixStr st.login) |> List.head
                        in
            if List.any ((==) 0 << String.length) [name', login', pass'] then
                { model | message <- "Please fill all the fields"}
            else
                case account of
                    Just _ ->
                        { model | message  <- "This user already exists!", register_form <- { id = 0, name = "", login = "", password = ""} }
                    Nothing ->
                        { model | accounts <- model.accounts ++ [ { id       = length model.accounts
                                                                  , name     = model.register_form.name
                                                                  , login    = model.register_form.login
                                                                  , password = model.register_form.password
                                                                  } ]
                                , message       <- "You sucessfully registered!"
                                , register_form <- { id = 0, name = "", login = "", password = ""}
                                }

        ActChangePage  page' -> { model | page     <- page' }
        ActUpdateLogin text  -> { model | login    <- text  }
        ActUpdatePass  text  -> { model | password <- text  }
        
        ActLogin -> let account = model.accounts |> filter (\acc -> fixStr acc.login    == fixStr model.login
                                                                 && fixStr acc.password == fixStr model.password) |> List.head
                    in

            case account of

                Just account ->
                    { model | login     <- ""
                            , password  <- ""
                            , account   <- Just account
                            , message   <- "Bem Vindo " ++ account.name ++ "!" }
                Nothing ->
                    { model | login     <- ""
                            , password  <- ""
                            , account   <- Nothing
                            , message   <- "Wrong Login or Password!" }
        
        ActLogout ->
            if model.account == Nothing then
                { model | message <- "You are not logged" }
            else
                { model | account   <- Nothing
                        , message   <- "Você deslogou :)" }

module Lib
    ( someFunc
    ) where

import Greetings

import Foreign.C.String
import Greetings

someFunc :: IO ()
someFunc = withCString "Rust 🦀" hello

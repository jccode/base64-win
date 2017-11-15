module Lib
    ( mainFunc
    ) where

import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as C
import System.Environment
import Data.ByteString.Base64


mainFunc :: IO ()
mainFunc = do
    args <- getArgs
    let len = length args
    if len == 0
       then showHelp
      else if (args !! 0) == "-h"
           then showHelp
           else codec (args!!0) (C.pack (args!!1))


showHelp :: IO ()
showHelp = do
    putStrLn "-h: show this help message"
    putStrLn "-d: decode text"
    putStrLn "-h: encode text"


codec :: String -> C.ByteString -> IO ()
codec cmd bs
    | cmd == "-d" = case decode bs of
        Left err -> putStrLn "Invalid base64 string"
        Right p -> B.putStr p
    | cmd == "-e" = B.putStr (encode bs)
    | otherwise   = putStrLn "Invalid command"


module Lux.Main where

import Control.Concurrent
import Control.Monad
import qualified Control.Concurrent.BoundedChan as BC
import System.Process

import Lux.Core
import Lux.Inputs.Nagios

main = do
			putStrLn "Starting Lux"
			putStrLn "Loading config"
			-- TODO load config
			channel <- BC.newBoundedChan channelSize
			putStrLn "Starting input threads"
			-- TODO Map below over LuxConfig commands
			_ <- mapM (commandThread channel) dummyCommands
			putStrLn "Starting output thread"
			_ <- forkIO $ forever $ do
				event <- BC.readChan channel
				putStrLn $ show event
			putStrLn "Running"
			forever $ threadDelay 1000 -- FIXME Block forever hack

commandThread :: Command c => BC.BoundedChan Response -> c -> IO ThreadId
commandThread channel command = do
									putStrLn $ "Starting input thread for TODO" -- TODO Show
									forkIO $ forever $ do
															threadDelay $ 10 * 1000 * 1000
															result <- runCheck command
															BC.writeChan channel result


dummyCommands :: Command c => [c]
dummyCommands = [NagiosPlugin "/usr/bin/uptime"]

channelSize :: Int
channelSize = 10


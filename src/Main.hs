module Main where

import Control.Concurrent
import Control.Monad
import qualified Control.Concurrent.BoundedChan as BC
import GHC.IO.Exception
import System.Process

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

runCheck :: Command -> IO Response
runCheck (ExternalCommand fp) = do 
									(code, stdout, _) <- readProcessWithExitCode fp [] ""
									return (Response (determineStatus code) stdout []) -- TODO Parse output

determineStatus :: ExitCode -> Status
determineStatus ExitSuccess = Ok
determineStatus (ExitFailure 1) = Warning
determineStatus (ExitFailure 2) = Critical
determineStatus _ = undefined -- TODO Handling things outside of scope?

commandThread :: BC.BoundedChan Response -> Command -> IO ThreadId
commandThread channel command = do
									putStrLn $ "Starting input thread for TODO" -- TODO Show
									forkIO $ forever $ do
															threadDelay $ 10 * 1000 * 1000
															result <- runCheck command
															BC.writeChan channel result


type LuxConfig = [Command] -- FIXME

data Command = ExternalCommand FilePath 
--			 | InternalCommand (IO Response)

dummyCommands :: [Command]
dummyCommands = [ExternalCommand "/usr/bin/uptime"]

channelSize :: Int
channelSize = 10

data Status = Ok
			| Warning 
			| Critical deriving (Enum, Show)

type Description = String
type MetricKey = String
type MetricValue = Float
data Metric = Metric MetricKey MetricValue deriving (Show)
data Response = Response Status Description [Metric] deriving (Show)


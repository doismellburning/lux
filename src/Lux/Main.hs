import Control.Concurrent
import Control.Monad
import qualified Control.Concurrent.BoundedChan as BC
import System.Process

import Lux.Core
import Lux.Inputs.Nagios
import Lux.Outputs.Graphite

main = do
			putStrLn "Starting Lux"
			putStrLn "Loading config"
			-- TODO load config
			channel <- BC.newBoundedChan channelSize
			putStrLn "Starting input threads"
			-- TODO Map below over LuxConfig commands
			_ <- mapM (commandThread channel) dummyCommands
			putStrLn "Starting output thread"
			_ <- graphiteThread channel
			putStrLn "Running"
			forever $ threadDelay 1000 -- FIXME Block forever hack

runCheck :: Command -> IO Response
runCheck (NagiosPlugin fp) =
	do
		(code, stdout, _) <- readProcessWithExitCode fp [] ""
		return $ parseNagiosOutput code stdout

commandThread :: BC.BoundedChan Response -> Command -> IO ThreadId
commandThread channel command =
	do
		putStrLn $ "Starting input thread for TODO" -- TODO Show
		forkIO $ forever $
			do
				threadDelay $ 10 * 1000 * 1000
				result <- runCheck command
				BC.writeChan channel result


--type LuxConfig = [Command] -- FIXME

data Command = NagiosPlugin FilePath
--			 | InternalCommand (IO Response)

dummyCommands :: [Command]
dummyCommands = [NagiosPlugin "/usr/bin/uptime"]

channelSize :: Int
channelSize = 10


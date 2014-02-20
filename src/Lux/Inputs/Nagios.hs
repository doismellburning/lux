module Lux.Inputs.Nagios (
	NagiosPlugin(..)
) where

import Data.Text
import GHC.IO.Exception
import System.Process

import Lux.Core

data NagiosPlugin = NagiosPlugin String

instance Command NagiosPlugin where
	runCheck = run

parseNagiosOutput :: ExitCode -> String -> Response
parseNagiosOutput code stdout =
	let
		status = determineStatus code
		(description, metrics) = parseNagiosOutput2 stdout
	in Response status description metrics

parseNagiosOutput2 :: String -> (String, [Metric])
parseNagiosOutput2 stdout =
	let
		description = (unpack . strip . pack) stdout
	in (description, [])

determineStatus :: ExitCode -> Status
determineStatus ExitSuccess = Ok
determineStatus (ExitFailure 1) = Warning
determineStatus (ExitFailure 2) = Critical
determineStatus _ = undefined -- TODO Handling things outside of scope?

run :: NagiosPlugin -> IO Response
run (NagiosPlugin fp) =
	do
		(code, stdout, _) <- readProcessWithExitCode fp [] ""
		return $ parseNagiosOutput code stdout

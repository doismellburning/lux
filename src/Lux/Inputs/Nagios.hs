module Lux.Inputs.Nagios where

import Data.Text
import GHC.IO.Exception

import Lux.Core

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

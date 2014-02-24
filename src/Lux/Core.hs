module Lux.Core where

data Status =
	Ok
	| Warning
	| Critical
	deriving (Enum, Show)

type Description = String
type MetricKey = String
type MetricValue = Double
data Metric = Metric MetricKey MetricValue deriving (Eq, Show)
data Response = Response Status Description [Metric] deriving (Show)

metrics :: Response -> [Metric]
metrics (Response _ _ ms) = ms

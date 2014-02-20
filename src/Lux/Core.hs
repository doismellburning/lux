module Lux.Core where

data Status =
	Ok
	| Warning
	| Critical
	deriving (Enum, Show)

type Description = String
type MetricKey = String
type MetricValue = Float
data Metric = Metric MetricKey MetricValue deriving (Eq, Show)
data Response = Response Status Description [Metric] deriving (Show)


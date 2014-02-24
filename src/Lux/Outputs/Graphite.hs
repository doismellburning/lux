module Lux.Outputs.Graphite where

import Control.Concurrent
import qualified Control.Concurrent.BoundedChan as BC
import Control.Monad
import qualified Data.ByteString.Char8 as C8
import qualified Network.Metric.Sink.Graphite as Graphite
import Network.Metric.Internal

import Lux.Core

graphiteThread :: BC.BoundedChan Response -> IO ThreadId
graphiteThread channel =
	do
		sink <- Graphite.open (C8.pack "foo") "bar" 8000
		forkIO $ forever $ do
			event <- BC.readChan channel
			mapM (Graphite.push sink) $ measure event

instance Measurable Response where
	measure a = map (\(Metric k v) -> Gauge (C8.pack "") (C8.pack k) v) $ metrics a

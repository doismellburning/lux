import Test.Hspec
import Lux.Core
import Lux.Inputs.Nagios

main :: IO ()
main = hspec $ do
	describe "Nagios support" $ do
		it "parses basic Nagios plugin output" $ do
			let stdout = "Lorem"
			stdout `shouldParseAs` (stdout, [])

		it "extracts Nagios metric data" $ do
			pendingWith "an understanding of the metric data format"

		it "handles multi-line Nagios descriptions" $ do
			pendingWith "parsing woe"

shouldParseAs :: String -> (String, [Metric]) -> Expectation
shouldParseAs input output = (parseNagiosOutput2 input) `shouldBe` output

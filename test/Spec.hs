import Test.Hspec
import Lux.Main hiding (main)

main :: IO ()
main = hspec $ do
	describe "Nagios support" $ do
		it "parses basic nagios plugin output" $ do
			let stdout = "Lorem"
			let parsed = parseNagiosOutput2 stdout
			parsed `shouldBe` (stdout, [])

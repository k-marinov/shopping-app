import Quick
import Nimble

@testable import ShoppingApp

class StringUtilSpec: QuickSpec {

    override func spec() {
        describe("StringUtil") {
            describe("isNilOrEmpty") {
                context("when has nil string") {
                    it("returns true") {
                        let value: String? = nil
                        expect(StringUtil.isNilOrEmpty(value)).to(beTrue())
                    }
                }

                context("when has empty string") {
                    it("returns true") {
                        expect(StringUtil.isNilOrEmpty("")).to(beTrue())
                    }
                }

                context("when has string with value") {
                    it("returns false") {
                        expect(StringUtil.isNilOrEmpty("john-lewis")).to(beFalse())
                    }
                }
            }
        }
    }

}

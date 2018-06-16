import Quick
import Nimble

@testable import ShoppingApp

class HttpSchemeProtocolSpec: QuickSpec {

    override func spec() {
        describe("HttpSchemeProtocol") {
            describe("addHttpScheme") {
                context("when has image url with empty string") {
                    it("returns nil") {
                        let imageUrl: String? = MockHttpSchemeBuilder().addHttpScheme(to: "")
                        expect(imageUrl).to(beNil())
                    }
                }

                context("when image url has already http scheme added") {
                    it("does not add https") {
                        let imageUrl: String? = MockHttpSchemeBuilder().addHttpScheme(to: "http://johnlewis.com/image/1")
                        expect(imageUrl).to(equal("http://johnlewis.com/image/1"))
                    }
                }

                context("when image url has already https scheme added") {
                    it("does not add https") {
                        let imageUrl: String? = MockHttpSchemeBuilder().addHttpScheme(to: "https://johnlewis.com/image/1")
                        expect(imageUrl).to(equal("https://johnlewis.com/image/1"))
                    }
                }

                context("when image url does not have https scheme added") {
                    it("adds https") {
                        let imageUrl: String? = MockHttpSchemeBuilder().addHttpScheme(to: "//johnlewis.com/image/1")
                        expect(imageUrl).to(equal("https://johnlewis.com/image/1"))
                    }
                }
            }
        }
    }

}

import Foundation
import SwiftyJSON

@testable import ShoppingApp

class PriceMother {

    class func emptyJson() -> JSON {
        let data: Data = "{}".data(using: String.Encoding.utf8)!
        return JSON(data)
    }

    class func priceWithNowValue() -> JSON {
        let data: Data = "{\"now\":\"331.10\"}".data(using: .utf8)!
        return JSON(data)
    }

    class func priceWithNowValueEmpty() -> JSON {
        let data: Data = "{\"now\":\"\"}".data(using: .utf8)!
        return JSON(data)
    }

}

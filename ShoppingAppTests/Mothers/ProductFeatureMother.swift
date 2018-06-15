
import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductFeatureMother {

    private static let feature: String =
    """
    { "name": "Dimensions", "value": "H84.5cm x W60cm x D60cm" }
    """

    class func featureJson() -> JSON {
        let data: Data = feature.data(using: .utf8)!
        return JSON(data)
    }

}

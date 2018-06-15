import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductAdditionalServicesMother {

    private static let additionalServices: String =
    """
    { "includedServices": [ "2 year guarantee included", "1 month free service" ] }
    """

    private static let additionalServicesEmptyStrings: String =
    """
    { "includedServices": [ "", "" ] }
    """

    class func additionalServicesEmptyStringsJson() -> JSON {
        let data: Data = additionalServicesEmptyStrings.data(using: .utf8)!
        return JSON(data)
    }

    class func additionalServicesJson() -> JSON {
        let data: Data = additionalServices.data(using: .utf8)!
        return JSON(data)
    }

}

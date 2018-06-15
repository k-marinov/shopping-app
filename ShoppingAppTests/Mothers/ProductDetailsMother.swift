import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductDetailsMother {

    class func productDetails3215462Json() -> JSON {
        let data: Data = FileHelper().createData(fromFilename: "product-details-3215462", ofType: "json")!
        return JSON(data)
    }

    let productInformation3215462: String = "<p>Reliable and versatile, the Freestanding Dishwasher from Bosch</p>"

}

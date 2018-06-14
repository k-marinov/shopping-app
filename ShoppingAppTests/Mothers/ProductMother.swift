import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductMother {

    class func createProductsJsonData() -> Data {
        return FileHelper().createData(fromFilename: "products", ofType: "json")!
    }

    class func createEmptyProductsJsonData() -> Data {
        return  "{\"products\": []}".data(using: .utf8)!
    }

}

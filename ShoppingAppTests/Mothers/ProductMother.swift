import Foundation
import SwiftyJSON

@testable import ShoppingApp

class ProductMother {

    class func createProducts() -> ProductsResource {
        return ProductsResource(json: JSON(productsJsonData()))
    }

    class func productsJsonData() -> Data {
        return FileHelper().createData(fromFilename: "products", ofType: "json")!
    }

    class func emptyProductsJsonData() -> Data {
        return  "{\"products\": []}".data(using: .utf8)!
    }

    class func productWithEmptyId() -> ProductResource {
        let data = "{\"productId\":\"\"}".data(using: .utf8)!
        return ProductResource(json: JSON(data))
    }

    class func emptyProductJson() -> JSON {
        let data: Data = "{}".data(using: .utf8)!
        return JSON(data)
    }

    class func product3215462Json() -> JSON {
        let data: Data = FileHelper().createData(fromFilename: "product-3215462", ofType: "json")!
        return JSON(data)
    }

}

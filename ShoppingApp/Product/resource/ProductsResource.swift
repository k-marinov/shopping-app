import Foundation
import SwiftyJSON

struct ProductsResource: RootResource {

    private(set) var products: [ProductResource] = [ProductResource]()

    init(data: Data) {
         map(from: JSON(data))
    }

    private mutating func map(from json: JSON) {
        let newProducts: [ProductResource] = json["products"].arrayValue.compactMap { ProductResource(json: $0) }
        products.append(contentsOf: newProducts)
    }
    
}

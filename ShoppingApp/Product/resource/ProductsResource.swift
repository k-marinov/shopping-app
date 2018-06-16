import Foundation
import SwiftyJSON

struct ProductsResource: Resource {

    private(set) var products: [ProductResource] = [ProductResource]()

    init(json: JSON) {
         map(from: json)
    }

    private mutating func map(from json: JSON) {
        let newProducts: [ProductResource] = json["products"].arrayValue
            .compactMap { ProductResource(json: $0) }
        products.append(contentsOf: newProducts)
    }
    
}

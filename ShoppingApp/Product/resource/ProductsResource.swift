import Foundation

struct ProductsResource: RootResource {

    private(set) var products: [ProductResource] = [ProductResource]()

    init(data: Data) {
    }
    
}

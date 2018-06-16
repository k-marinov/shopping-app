@testable import ShoppingApp

class MockComponentCreator: ComponentCreatable {

    var productService: ProductService!

    init() {
    }

    func mockProductService() -> MockProductService {
        return productService as! MockProductService
    }

    func create(with componentCreatable: ComponentCreatable) -> ProductService {
        return productService
    }

    class func buildAllMocks() -> MockComponentCreator {
        let creator: MockComponentCreator = MockComponentCreator()
        creator.productService = MockProductService(componentCreatable: creator)
        return creator
    }

}

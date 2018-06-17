@testable import ShoppingApp

class MockComponentCreator: ComponentCreatable {

    var productService: ProductService!
    var productDetailRouter: ProductDetailRouter!

    init() {
    }

    func mockProductService() -> MockProductService {
        return productService as! MockProductService
    }

    func mockProductDetailRouter() -> MockProductDetailRouter {
        return productDetailRouter as! MockProductDetailRouter
    }

    func create(with componentCreatable: ComponentCreatable) -> ProductService {
        return productService
    }

    func create() -> ProductDetailRouter {
        return productDetailRouter
    }

    class func buildAllMocks() -> MockComponentCreator {
        let creator: MockComponentCreator = MockComponentCreator()
        creator.productService = MockProductService(componentCreatable: creator)
        creator.productDetailRouter = MockProductDetailRouter()
        return creator
    }

}

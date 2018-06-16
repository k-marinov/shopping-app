import RxSwift

@testable import ShoppingApp

class MockProductService: ProductService {

    var isRequestSuccess = false

    override func findAllProducts(with request: ProductsRequest) -> Observable<[ProductResource]> {
        return isRequestSuccess
            ? Observable.just(ProductMother.createProducts().products)
            : Observable.error(ApiError.client)
    }

}

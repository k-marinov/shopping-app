import RxSwift

@testable import ShoppingApp

class MockProductService: ProductService {

    var isFindAllProductsRequestSuccess = false
    var isFindProductDetailRequestSuccess = false

    override func findAllProducts(with request: ProductsRequest) -> Observable<[ProductResource]> {
        return isFindAllProductsRequestSuccess
            ? Observable.just(ProductMother.createProducts().products)
            : Observable.error(ApiError.client)
    }

    override func findProductDetail(with request: ProductDetailRequest) -> Observable<ProductResource> {
        return isFindProductDetailRequestSuccess
            ? Observable.just(ProductResource(json: ProductMother.product3215462Json()))
            : Observable.error(ApiError.client)
    }

}

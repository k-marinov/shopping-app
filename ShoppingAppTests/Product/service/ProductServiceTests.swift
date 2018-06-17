import XCTest
import RxSwift

@testable import ShoppingApp

class ProductServiceTests: XCTestCase {

    private let productsMocker: ProductsHttpMocker = ProductsHttpMocker()
    private let productsDetailMocker: ProductDetailHttpMocker = ProductDetailHttpMocker()
    private let service: ProductService = ProductService(componentCreatable: ComponentCreator())
    private let disposeBag: DisposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        productsMocker.setUpStubs()
        productsDetailMocker.setUpStubs()
    }

    override func tearDown() {
        productsMocker.removeStubs()
        productsDetailMocker.removeStubs()
        super.tearDown()
    }

    func testFindAllProducts_whenStatusCode200_returnsProducts() {
        let url = "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=\(Constants.validApiKey)&pageSize=20"
        let request = MockProductsRequest(url: url, method: HttpMethod.get)
        var products: [ProductResource] = [ProductResource]()

        let expectation = self.expectation(description: "")
        service.findAllProducts(with: request)
            .subscribe(onNext: { newProducts in
                products.append(contentsOf: newProducts)
                expectation.fulfill()
            }, onError: { error in
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(products.count, 3)
    }

    func testFindAllProducts_whenStatusCode401_returnsApiErrorClient() {
        let url = "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=\(Constants.invalidApiKey)&pageSize=20"
        let request = MockProductsRequest(url: url, method: HttpMethod.get)
        var apiError: ApiError?

        let expectation = self.expectation(description: "")
        service.findAllProducts(with: request)
            .subscribe(onNext: { _ in
                expectation.fulfill()
            }, onError: { error in
                apiError = error as? ApiError
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(apiError, ApiError.client)
    }

    func testFindProductDetail_whenStatusCode200_returnsProductDetail() {
        var product: ProductResource?

        let expectation = self.expectation(description: "")
        service.findProductDetail(with: try! ProductDetailRequest(productId: Constants.validProductId))
            .subscribe(onNext: { newProduct in
                product = newProduct
                expectation.fulfill()
            }, onError: { error in
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(product?.id, "3215462")
        XCTAssertEqual(product?.imageUrls().count, 4)
        XCTAssertEqual(product?.includedServicesFormatted(), "2 year guarantee included, 1 month free service")
    }

    func testFindProductDetail_whenStatusCode404_returnsApiErrorClient() {
        var apiError: ApiError?

        let expectation = self.expectation(description: "")
        service.findProductDetail(with: try! ProductDetailRequest(productId: Constants.invalidProductId))
            .subscribe(onNext: { _ in
                expectation.fulfill()
            }, onError: { error in
                apiError = error as? ApiError
                expectation.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expectation], timeout: Constants.timeout)

        XCTAssertEqual(apiError, ApiError.client)
    }

}

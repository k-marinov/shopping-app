import XCTest
import RxSwift

@testable import ShoppingApp

class ProductServiceTests: XCTestCase {

    private let mocker: ProductsHttpMocker = ProductsHttpMocker()
    private let service: ProductService = ProductService(componentCreatable: ComponentCreator())
    private let disposeBag: DisposeBag = DisposeBag()

    override func setUp() {
        super.setUp()
        mocker.setUpStubs()
    }

    override func tearDown() {
        mocker.removeStubs()
        super.tearDown()
    }

    func testFindAllProducts_whenStatusCode200_returnsProducts() {
        let url = "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=\(Constants.validApiKey)&pageSize=20"
        let request = MockProductsRequest(url: url, method: HttpMethod.get)
        var products: [ProductResource] = [ProductResource]()

        let expect = expectation(description: "find all products success")
        service.findAllProducts(with: request)
            .subscribe(onNext: { newProducts in
                products.append(contentsOf: newProducts)
                expect.fulfill()
            }, onError: { error in
                expect.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expect], timeout: Constants.timeout)

        XCTAssertEqual(products.count, 3)
    }

    func testFindAllProducts_whenStatusCode200_returnsApiErrorClient() {
        let url = "https://api.johnlewis.com/v1/products/search?q=dishwasher&key=\(Constants.invalidApiKey)&pageSize=20"
        let request = MockProductsRequest(url: url, method: HttpMethod.get)
        var apiError: ApiError?

        let expect = expectation(description: "find all products error")
        service.findAllProducts(with: request)
            .subscribe(onNext: { _ in
                expect.fulfill()
            }, onError: { error in
                apiError = error as? ApiError
                expect.fulfill()
            }).disposed(by: disposeBag)
        wait(for: [expect], timeout: Constants.timeout)

        XCTAssertEqual(apiError, ApiError.client)
    }

}

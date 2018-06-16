import XCTest

@testable import ShoppingApp

class ProductCellTests: XCTestCase {

    var cell: ProductCell!

    override func setUp() {
        super.setUp()
        cell = NibCreator.createNib(ofClass: ProductCell.self) as! ProductCell
    }

    func testConfigureCell_whenHasContent_setsLabelText() {
        let product: ProductResource = ProductMother.createProducts().products.first!
        cell.configureCell(with: product)

        XCTAssertEqual(cell.priceLabel.text, "£349.00")
        XCTAssertEqual(cell.titleLabel.text, "Bosch SMS25AW00G Freestanding Dishwasher, White")
    }

    func testIdentifier_returnsProductCellString() {
        XCTAssertEqual(ProductCell.identifier, "ProductCell")
    }

}

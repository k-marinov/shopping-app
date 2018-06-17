import UIKit
import XCTest

@testable import ShoppingApp

class CollectionViewDataSourceTests: XCTestCase {

    private var cell: ProductCell!
    private var dataSource: CollectionViewDataSource<ProductResource, ProductCell>!
    private var delegate: CollectionViewDelegate = CollectionViewDelegate()
    private var collectionView: UICollectionView!
    private var products: [ProductResource] = ProductMother.createProducts().products
    let frame: CGRect = CGRect(x: 0, y: 0, width: 1256, height: 2560)
    var collector: RxCollector<IndexPath>!

    override func setUp() {
        super.setUp()
        setUpCollectionView()
    }

    func testAppendOnce_whenNewItemsAreAddedTwice_appendsOnce() {
        dataSource.appendOnce(contentsOf: products)
        dataSource.appendOnce(contentsOf: products)
        collectionView.reloadData()
        let count = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)

        XCTAssertEqual(count, 3)
    }

    func testDidSelectItemAtIndexPath_whenHasGivenIndexPath_returnsCount() {
        let expectedIndexPath: IndexPath = IndexPath(row: 1, section: 0)
        collector = RxCollector<IndexPath>().collect(from: delegate.didSelectItem())
        delegate.collectionView(collectionView, didSelectItemAt: expectedIndexPath)

        XCTAssertEqual(collector.results.count, 1)
        XCTAssertEqual(collector.results[0], expectedIndexPath)
    }

    func testCellForItemAt_whenHasGivenIndexPath_returnsProductCell() {
        let indexPath: IndexPath = IndexPath(row: 1, section: 0)
        let cell: UICollectionViewCell = dataSource.collectionView(collectionView, cellForItemAt: indexPath)

        XCTAssertTrue(cell is ProductCell)
    }

    func testCellForItemAt_whenHasGivenIndexPath_returnsConfiguredProductCell() {
        let indexPath: IndexPath = IndexPath(row: 1, section: 0)
        let cell: UICollectionViewCell = dataSource.collectionView(collectionView, cellForItemAt: indexPath)
        let productCell: ProductCell = cell as! ProductCell
        
        XCTAssertEqual(productCell.priceLabel.text, "£359.00")
        XCTAssertEqual(productCell.titleLabel.text, "Bosch SMV40C30GB Fully Integrated Dishwasher")
    }

    private func setUpCollectionView() {
        dataSource = CollectionViewDataSource<ProductResource, ProductCell>()
        dataSource.appendOnce(contentsOf: products)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.registerCellNib(with: ProductCell.identifier)
        collectionView.dataSource = dataSource
        collectionView.delegate = delegate
        collectionView.reloadData()
    }

}

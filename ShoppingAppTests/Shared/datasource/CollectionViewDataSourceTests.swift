import UIKit
import XCTest

@testable import ShoppingApp

class CollectionViewDataSourceTests: XCTestCase {

    private var cell: ProductCell!
    private var dataSource: CollectionViewDataSource<ProductResource, ProductCell>!
    private var collectionView: UICollectionView!
    private var products: [ProductResource] = ProductMother.createProducts().products
    let frame: CGRect = CGRect(x: 0, y: 0, width: 1256, height: 2560)
    var collector: RxCollector<IndexPath>!

    override func setUp() {
        super.setUp()
        dataSource = CollectionViewDataSource<ProductResource, ProductCell>()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: UICollectionViewFlowLayout.init())
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        dataSource.appendOnce(contentsOf: products)
    }

    func testAppendOnce_whenNewItemsAreAddedTwice_appendsOnce() {
        dataSource.appendOnce(contentsOf: products)
        dataSource.appendOnce(contentsOf: products)
        let count = dataSource.collectionView(collectionView, numberOfItemsInSection: 0)

        XCTAssertEqual(count, 3)
    }

    func testDidSelectItemAtIndexPath_whenHasGivenIndexPath_returnsCount() {
        let expectedIndexPath: IndexPath = IndexPath(row: 1, section: 0)
        collector = RxCollector<IndexPath>().collect(from: dataSource.didSelectItemAtIndexPath())
        dataSource.collectionView(collectionView, didSelectItemAt: expectedIndexPath)

        XCTAssertEqual(collector.results.count, 1)
        XCTAssertEqual(collector.results[0], expectedIndexPath)
    }

}

import UIKit
import RxSwift

class CollectionViewDataSource<ITEM: CollectionViewItem, CELL: CollectionViewCell>: NSObject, UICollectionViewDataSource,
UICollectionViewDelegate {

    private(set) var items: [CollectionViewItem] = [CollectionViewItem]()
    private let didSelectItem: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CELL = collectionView.dequeueReusableCell(withReuseIdentifier: CELL.identifier, for: indexPath) as! CELL
        cell.configureCell(with: items[indexPath.row])
        return cell as! UICollectionViewCell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItem.onNext(indexPath)
    }

    func appendOnce(contentsOf newItems: [CollectionViewItem]) {
        items.removeAll()
        items.append(contentsOf: newItems)
    }

    func didSelectItemAtIndexPath() -> Observable<IndexPath> {
        return didSelectItem.asObservable()
    }

}

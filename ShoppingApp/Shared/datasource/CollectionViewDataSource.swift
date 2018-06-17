import UIKit
import RxSwift

class CollectionViewDataSource<ITEM: CollectionViewItem, CELL: CollectionViewCell>: NSObject, UICollectionViewDataSource {

    private var items: [CollectionViewItem] = [CollectionViewItem]()

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

    func appendOnce(contentsOf newItems: [CollectionViewItem]) {
        items.removeAll()
        items.append(contentsOf: newItems)
    }

    func findItem(at indexPath: IndexPath) -> CollectionViewItem {
        return items[indexPath.row]
    }

    func count() -> Int {
        return items.count
    }

}

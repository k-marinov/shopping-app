import UIKit
import RxSwift

class CollectionViewDataSource<ITEM: CollectionViewItem, CELL: CollectionViewCell>: NSObject, UICollectionViewDataSource {
//UICollectionViewDelegate {

    private var items: [CollectionViewItem] = [CollectionViewItem]()
    //private let didSelectItemAt: PublishSubject<CollectionViewItem> = PublishSubject<CollectionViewItem>()
   // private let publishSelectedPage: PublishSubject<Int> = PublishSubject<Int>()
    
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
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        didSelectItemAt.onNext(items[indexPath.row])
//    }

    func appendOnce(contentsOf newItems: [CollectionViewItem]) {
        items.removeAll()
        items.append(contentsOf: newItems)
    }

    func findItem(at indexPath: IndexPath) -> CollectionViewItem {
        return items[indexPath.row]
    }

//    func didSelectItem() -> Observable<CollectionViewItem> {
//        return didSelectItemAt.asObservable()
//    }
//
//    func selectedPage() -> Observable<Int> {
//        return publishSelectedPage.asObservable()
//    }

    func count() -> Int {
        return items.count
    }
//
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        publishSelectedPage.onNext(selectedPage(scrollView))
//    }
//
//    private func selectedPage(_ scrollView: UIScrollView) -> Int {
//        let pageWidth: CGFloat = scrollView.frame.size.width;
//        let currentPage: CGFloat = scrollView.contentOffset.x / pageWidth;
//
//        if (0.0 != fmodf(Float(currentPage), 1.0)) {
//            return Int(currentPage + CGFloat(1.0));
//        } else {
//            return Int(currentPage);
//        }
//    }

}

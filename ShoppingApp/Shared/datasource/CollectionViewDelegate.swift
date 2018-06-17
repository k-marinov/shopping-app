import UIKit
import RxSwift

class CollectionViewDelegate: NSObject, UICollectionViewDelegate {

    private var items: [CollectionViewItem] = [CollectionViewItem]()
    private let didSelectItemAt: PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    private let publishSelectedPage: PublishSubject<Int> = PublishSubject<Int>()

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAt.onNext(indexPath)
    }

    func didSelectItem() -> Observable<IndexPath> {
        return didSelectItemAt.asObservable()
    }

    func selectedPage() -> Observable<Int> {
        return publishSelectedPage.asObservable()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        publishSelectedPage.onNext(selectedPage(scrollView))
    }

    private func selectedPage(_ scrollView: UIScrollView) -> Int {
        let pageWidth: CGFloat = scrollView.frame.size.width;
        let currentPage: CGFloat = scrollView.contentOffset.x / pageWidth;

        if (0.0 != fmodf(Float(currentPage), 1.0)) {
            return Int(currentPage + CGFloat(1.0));
        } else {
            return Int(currentPage);
        }
    }

}

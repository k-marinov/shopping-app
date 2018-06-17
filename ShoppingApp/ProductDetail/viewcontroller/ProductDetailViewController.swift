import UIKit
import RxSwift

class ProductDetailViewController: UIViewController, ModelableViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    private let disposeBag: DisposeBag = DisposeBag()
    private lazy var productDetailViewModel: ProductDetailViewModel = {
        return self.viewModel as! ProductDetailViewModel
    }()
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        subscribe()
        productDetailViewModel.loadProductDetail()
            .subscribe()
            .disposed(by: disposeBag)
    }

    private func setUp() {
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        setUpCollectionViewDataSourceAndDelegate()
        setUpCollectionViewLayout()
    }

    private func setUpCollectionViewDataSourceAndDelegate() {
        collectionView.dataSource = productDetailViewModel.imageUrlsDataSource
        collectionView.delegate = productDetailViewModel.imageUrlsDataSource
    }

    private func setUpCollectionViewLayout() {
        collectionView.collectionViewLayout = collectionViewFlowLayout()
    }

    private func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let length: CGFloat = UIScreen.main.bounds.size.width
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: length, height: length)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }

    private func subscribe() {
        productDetailViewModel.reloadImageUrls
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                self?.collectionView.reloadData()
                self?.pageControl.numberOfPages = count
            }).disposed(by: disposeBag)

        productDetailViewModel.publishProductDetail
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] product in
                self?.setUp(product: product)
            }).disposed(by: disposeBag)

        productDetailViewModel.isLoading
            .asObservable()
            .observeOn(MainScheduler.instance)
            .bind(to: activityIndicatorView.rx.isLoading)
            .disposed(by: disposeBag)

        productDetailViewModel.selectedPage()
            .bind { [weak self] pageNumber in
            self?.pageControl.currentPage = pageNumber
        }.disposed(by: disposeBag)
    }

    private func setUp(product: ProductResource) {
        setUpNavigationBarTitle(product.title)
    }

    private func setUpNavigationBarTitle(_ title: String) {
        navigationItem.title = title
    }
}

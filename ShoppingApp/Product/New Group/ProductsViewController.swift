import UIKit
import RxSwift

class ProductsViewController: UIViewController, ModelableViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    private let disposeBag: DisposeBag = DisposeBag()
    private(set) lazy var productsViewModel: ProductsViewModel = {
        return self.viewModel as! ProductsViewModel
    }()
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        subscribe()
        productsViewModel.loadProducts()
            .subscribe()
            .disposed(by: disposeBag)
        NotificationCenter.default.addObserver(
            self, selector: #selector(orientationChanged),
            name:  Notification.Name("UIDeviceOrientationDidChangeNotification"), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func orientationChanged() {
        setUpCollectionViewLayout()
        view.layoutIfNeeded()
    }

    private func setUp() {
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        collectionView.registerCellNib(with: ProductCell.identifier)
        setUpCollectionViewDataSource()
        setUpCollectionViewLayout()
    }

    private func setUpCollectionViewDataSource() {
        collectionView.dataSource = productsViewModel.dataSource
        collectionView.delegate = productsViewModel.delegate
    }

    private func setUpCollectionViewLayout() {
        collectionView.collectionViewLayout = collectionViewFlowLayout()
    }

    private func collectionViewFlowLayout() -> UICollectionViewFlowLayout {
        let column: CGFloat = 3.0
        let length: CGFloat = UIScreen.main.bounds.size.width / column
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: length, height: length)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }

    private func subscribe() {
        productsViewModel.reloadData
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] count in
                self?.collectionView.reloadData()
                self?.setUpNavigationBarTitle(count)
            }).disposed(by: disposeBag)

         productsViewModel.isLoading
            .asObservable()
            .bind(to: activityIndicatorView.rx.isLoading)
            .disposed(by: disposeBag)
    }

    private func setUpNavigationBarTitle(_ count: Int) {
        navigationItem.title = "Dishwashers(\(count))"
    }

}


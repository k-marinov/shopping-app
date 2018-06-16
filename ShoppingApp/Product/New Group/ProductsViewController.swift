import UIKit
import RxSwift

class ProductsViewController: UIViewController, ModelableViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let disposeBag: DisposeBag = DisposeBag()
    private lazy var productsViewModel: ProductsViewModel = {
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
    }

    private func setUp() {
        setUpNavigationBarTitle()
        setUpCollectionView()
    }

    private func setUpCollectionView() {
        collectionView.registerCellNib(with: ProductCell.identifier)
        collectionView.dataSource = productsViewModel.dataSource
        collectionView.delegate = productsViewModel.dataSource
    }

    private func subscribe() {
        productsViewModel.reloadData
            .asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }

    private func setUpNavigationBarTitle() {
        navigationItem.title = "Products"
    }

}


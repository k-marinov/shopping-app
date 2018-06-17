import UIKit
import RxSwift

class ProductDetailViewController: UIViewController, ModelableViewController {

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
    }

    private func subscribe(){
        productDetailViewModel.publishProductDetail
            .asObservable()
            .subscribe(onNext: { [weak self] product in
                self?.setUp(product: product)
            }).disposed(by: disposeBag)

        productDetailViewModel.isLoading
            .asObservable()
            .bind(to: activityIndicatorView.rx.isLoading)
            .disposed(by: disposeBag)
    }

    private func setUp(product: ProductResource) {
        setUpNavigationBarTitle(product.title)
    }

    private func setUpNavigationBarTitle(_ title: String) {
        navigationItem.title = title
    }
}

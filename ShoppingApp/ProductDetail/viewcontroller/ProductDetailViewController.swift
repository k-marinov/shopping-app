import UIKit
import RxSwift

class ProductDetailViewController: UIViewController, ModelableViewController {

    private let disposeBag: DisposeBag = DisposeBag()
    private lazy var productDetailViewModel: ProductDetailViewModel = {
        return self.viewModel as! ProductDetailViewModel
    }()
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        subscribe()
    }

    private func setUp() {
    }

    private func subscribe(){
    }

}

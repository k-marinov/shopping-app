import UIKit

class ProductsViewController: UIViewController, ModelableViewController {

    private lazy var productsViewModel: ProductsViewModel = {
        return self.viewModel as! ProductsViewModel
    }()
    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}


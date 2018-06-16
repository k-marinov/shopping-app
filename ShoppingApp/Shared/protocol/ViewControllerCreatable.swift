import UIKit

protocol ViewControllerCreatable {

    func createViewController<VC: UIViewController> (
        withViewModel viewModel: ViewModel,
        viewControllerType: VC.Type) -> UIViewController

    func createViewController<VC: UIViewController>(viewControllerType type: VC.Type) -> UIViewController

}

extension ViewControllerCreatable {

    func createViewController<VC: UIViewController> (
        withViewModel viewModel: ViewModel,
        viewControllerType: VC.Type) -> UIViewController {

        var modelableViewController: ModelableViewController =
            createViewController(viewControllerType: viewControllerType) as! ModelableViewController
        modelableViewController.viewModel = viewModel
        return modelableViewController as! VC
    }

    func createViewController<VC: UIViewController>(viewControllerType type: VC.Type) -> UIViewController {
        let storyboardName: String = String(describing: type)
        let storyboard: UIStoryboard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController: VC = storyboard.instantiateViewController(withIdentifier: storyboardName) as! VC
        return viewController
    }

}

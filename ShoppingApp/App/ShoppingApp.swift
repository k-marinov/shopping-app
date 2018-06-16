import UIKit

class ShoppingApp {

    private let shoppingAppRouter: ShoppingAppRouter
    private let componentCreatable: ComponentCreatable

    required init(componentCreatable: ComponentCreatable) {
        self.componentCreatable = componentCreatable
        shoppingAppRouter = componentCreatable.create(with: componentCreatable)
    }

    func setUp(with window: UIWindow) -> UIWindow {
        UIApplication.shared.statusBarStyle = .lightContent
        return shoppingAppRouter.setRootViewController(to: window, componentCreatable: componentCreatable)
    }

}

import UIKit

class ShoppingApp {

    private var componentCreatable: ComponentCreatable!

    init(componentCreatable: ComponentCreatable) {
        self.componentCreatable = componentCreatable
    }

    func setUp(with window: UIWindow) {
        UIApplication.shared.statusBarStyle = .lightContent
    }

}

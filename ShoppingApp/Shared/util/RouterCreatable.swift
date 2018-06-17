protocol RouterCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ShoppingAppRouter

    func create(with componentCreatable: ComponentCreatable) -> ProductsRouter

    func create() -> ProductDetailRouter

}

extension RouterCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ShoppingAppRouter {
        return ShoppingAppRouter(componentCreatable: componentCreatable)
    }

    func create(with componentCreatable: ComponentCreatable) -> ProductsRouter {
        return ProductsRouter(componentCreatable: componentCreatable)
    }

    func create() -> ProductDetailRouter {
        return ProductDetailRouter()
    }

}

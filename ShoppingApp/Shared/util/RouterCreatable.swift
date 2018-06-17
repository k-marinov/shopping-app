protocol RouterCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ShoppingAppRouter

    func create() -> ProductsRouter

    func create() -> ProductDetailRouter

}

extension RouterCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ShoppingAppRouter {
        return ShoppingAppRouter(componentCreatable: componentCreatable)
    }

    func create() -> ProductsRouter {
        return ProductsRouter()
    }

    func create() -> ProductDetailRouter {
        return ProductDetailRouter()
    }

}

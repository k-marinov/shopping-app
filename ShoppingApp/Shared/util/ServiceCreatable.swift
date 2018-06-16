protocol ServiceCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ProductService

}

extension ServiceCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ProductService {
        return ProductService(componentCreatable: componentCreatable)
    }

}

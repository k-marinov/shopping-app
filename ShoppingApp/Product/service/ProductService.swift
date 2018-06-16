import RxSwift

class ProductService: Service {

    private var productRemote: ProductRemote

    required init(componentCreatable: ComponentCreatable) {
        productRemote = componentCreatable.create(with: componentCreatable)
    }

}

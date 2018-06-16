import RxSwift

class ProductRemote {

    private let apiClient: ApiClient

    required init(componentCreatable: ComponentCreatable) {
        apiClient = componentCreatable.create(with: componentCreatable)
    }

}

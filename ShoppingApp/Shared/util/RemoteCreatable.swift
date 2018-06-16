protocol RemoteCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ProductRemote

}

extension RemoteCreatable {

    func create(with componentCreatable: ComponentCreatable) -> ProductRemote {
        return ProductRemote(componentCreatable: componentCreatable)
    }

}

protocol HttpSchemeBuilder {

    func addHttpScheme(to imageUrl: String)  -> String?

}

extension HttpSchemeBuilder {

    func addHttpScheme(to imageUrl: String) -> String? {
        if StringUtil.isNilOrEmpty(imageUrl) {
            return nil
        }
        if imageUrl.hasPrefix("https:") || imageUrl.hasPrefix("http:") {
            return imageUrl
        }
        return "https:\(imageUrl)"
    }

}

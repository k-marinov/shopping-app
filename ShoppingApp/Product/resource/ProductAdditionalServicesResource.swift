import SwiftyJSON

struct ProductAdditionalServicesResource: Resource {

    private var includedServices: [String] = ["",""]
    private let separator: String = ", "

    init(json: JSON) {
        let services: [String] = json["includedServices"].arrayValue.compactMap { $0.stringValue }
        includedServices.append(contentsOf: services)
    }

    func includedServicesFormatted() -> String {
        let substring: Substring = includedServices
            .filter { !StringUtil.isNilOrEmpty($0) }
            .map { $0 + separator }
            .reduce("", +)
            .dropLast(separator.count)
        return String(substring)
    }

}

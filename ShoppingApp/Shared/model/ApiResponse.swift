import Foundation
import SwiftyJSON

struct ApiResponse {

    private(set) var resource: Resource?

    init<RESOURCE: Resource>(resourceType: RESOURCE.Type, httpResponse: HttpResponse) {
        resource = createResource(resourceType: resourceType, data: httpResponse.data)
    }

    private func createResource<RESOURCE: Resource>(resourceType: RESOURCE.Type, data: Data?) -> Resource? {
        if hasData(withData: data) {
            return RESOURCE(json: JSON(data!))
        }
        return nil
    }

    private func hasData(withData data: Data?) -> Bool {
        if let data: Data = data, data.count > 0 {
            return true
        }
        return false
    }

}

import Foundation

struct Service: Codable {
    let name: String
    let description: String
    let link: String
    let icon_url: String
}

struct Services: Codable {
    let services: [Service]
}

struct Response: Codable {
    let body: Services
    let status: Int
}

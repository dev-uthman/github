import UIKit

struct GistsData: Decodable {
    let files: [String: File]
    var owner: UserData
}

struct UserData: Codable {
    var login: String
    var avatar_url: String
}

struct DetailsUserData: Decodable {
    var login: String?
    var avatar_url: String?
    var name: String?
    var location: String?
    var company: String?
    var public_repos: Int?
}

struct RepositoryData: Codable {
    var name: String?
    var html_url: String?
}

struct File: Decodable, Equatable {
    let filename: String
    let type: String
    let language: String?
    let rawURL: URL
    let size: Int
    
    enum CodingKeys: String, CodingKey {
        case filename
        case type
        case language
        case rawURL = "raw_url"
        case size
    }
}

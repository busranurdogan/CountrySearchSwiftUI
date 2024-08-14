
import Foundation

struct Country: Identifiable, Codable {
    var id: UUID
    var name: CountryName
    var capital: [String]
    var population: Int
    var flags: Flags
    var capitalInfo: CapitalInfo?
    
    struct CountryName: Codable {
        var official: String
    }

    struct Flags: Codable {
        var png: String
        var svg: String
    }

    struct CapitalInfo : Codable {
        var latlng : [Double]?
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID()
        self.name = try container.decode(CountryName.self, forKey: .name)
        self.capital = try container.decodeIfPresent([String].self, forKey: .capital) ?? []
        self.population = try container.decode(Int.self, forKey: .population)
        self.flags = try container.decode(Flags.self, forKey: .flags)
        self.capitalInfo = try container.decodeIfPresent(CapitalInfo.self, forKey: .capitalInfo)
    }

    init(id: UUID = UUID(), name: CountryName, capital: [String]?, population: Int, flags: Flags, capitalInfo: CapitalInfo?) {
        self.id = id
        self.name = name
        self.capital = capital ?? []
        self.population = population
        self.flags = flags
        self.capitalInfo = capitalInfo
    }

}


import Foundation

struct WeatherResponse {
    let description: String
    let temperature: Double
    let iconUrl: String
    var iconImageData: Data? // 이미지 데이터 추가

    init?(json: Any) {
        guard let jsonDict = json as? [String: Any],
              let weatherArray = jsonDict["weather"] as? [[String: Any]],
              let mainDict = jsonDict["main"] as? [String: Any],
              let description = weatherArray.first?["description"] as? String,
              let icon = weatherArray.first?["icon"] as? String,
              let temperature = mainDict["temp"] as? Double
        else {
            return nil
        }

        self.description = description
        self.temperature = temperature
        self.iconUrl = "https://openweathermap.org/img/wn/\(icon)@2x.png"
    }
}

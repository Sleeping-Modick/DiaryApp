//
//  WeatherManager.swift
//  DiaryApp
//
//  Created by 김기현 on 2023/09/03.
//

import Foundation
import Alamofire

class WeatherManager {
    static let shared = WeatherManager()
    
    private init() {}
    
    private let apiKey = "e8aeafe9abc4ec56d53a28782b1991f8"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather" // HTTPS 사용
    
    func fetchWeather(for city: String, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let parameters: [String: Any] = [
            "q": city,
            "APPID": apiKey
        ]
        
        // Alamofire를 사용하여 GET 요청을 보냅니다.
        AF.request(baseUrl, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let weatherResponse = WeatherResponse(json: value) {
                        // 이미지 데이터 가져오기
                        self.fetchWeatherIcon(for: weatherResponse.iconUrl) { imageData in
                            var weatherResponseWithIcon = weatherResponse
                            weatherResponseWithIcon.iconImageData = imageData
                            completion(.success(weatherResponseWithIcon))
                        }
                    } else {
                        print("###날씨 데이터 파싱 실패ㅜㅜ")
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    private func fetchWeatherIcon(for iconUrl: String, completion: @escaping (Data?) -> Void) {
        if let url = URL(string: iconUrl) {
            AF.request(url).responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(_):
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }
}

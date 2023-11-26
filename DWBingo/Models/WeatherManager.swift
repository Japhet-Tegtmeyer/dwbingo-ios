//
//  WeatherManager.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/20/23.
//

import Foundation
import WeatherKit

// MARK: - WeatherManager Class

@MainActor class WeatherManager: ObservableObject {
    @Published var weather: Weather?
    
    // MARK: - Get Weather Function
    
    public func getWeather() async {
        do {
            weather = try await Task.detached(priority: .userInitiated) {
                // Fetch weather data asynchronously using WeatherService
                return try await WeatherService.shared.weather(for: .init(latitude: 28.3772,
                                                                          longitude: -81.5707))
            }.value
            
            // Print the symbol name of the current weather (for debugging)
            print(weather?.currentWeather.symbolName)
        } catch {
            // Handle errors by logging a fatal error
            fatalError("\(error)")
        }
    }
    
    // MARK: - Symbol Property
    
    var symbol: String {
        // Return the symbol name of the current weather or a default value
        weather?.currentWeather.symbolName ?? "xmark.icloud.fill"
    }
    
    // MARK: - Temperature Property
    
    var temp: String {
        let temp = weather?.currentWeather.temperature
        
        // Convert temperature to Fahrenheit and return as a string
        let convert = temp?.converted(to: .fahrenheit).description
        return convert ?? ""
    }
    
    // MARK: Cloud Cover
    var cloudCover: Double {
        let cloudCover = weather?.currentWeather.cloudCover
        
        return cloudCover ?? 0.0
    }
    
    // MARK: Formatted Cloud Cover
    var formattedCloudCover: String {
        guard let cloudCover = weather?.currentWeather.cloudCover else {
            return "N/A"
        }

        return String(format: "%.2f", cloudCover)
    }
    
    // MARK: Weather Condition
    var condition: WeatherCondition {
        let condition = weather?.currentWeather.condition
        
        return condition ?? .haze
    }
    
    // MARK: Humidity
    var humidity: Double {
        let humidity = weather?.currentWeather.humidity
        
        return humidity ?? 0.0
    }
    
    // MARK: Daylight
    var isDaylight: Bool {
        let isDaylight = weather?.currentWeather.isDaylight
        
        return isDaylight ?? true
    }
    
    // MARK: UV Index
    var uvIndex: UVIndex? {
        let uvIndex = weather?.currentWeather.uvIndex
        
        return uvIndex
    }
    
    // MARK: Wind
    var wind: Wind? {
        let wind = weather?.currentWeather.wind
        
        return wind
    }
    
    // MARK: Visibillity
    var visibillity: Measurement<UnitLength>? {
        let visibillity = weather?.currentWeather.visibility
        
        return visibillity
    }
    
    // MARK: Feels Like
    var apparentTemp: String {
        let apparentTemp = weather?.currentWeather.apparentTemperature
        
        let convertt = apparentTemp?.converted(to: .fahrenheit).description
        return convertt ?? ""
    }
    
    // MARK: Formatted Pressure
    var formattedPressure: String {
        guard let pressure = weather?.currentWeather.pressure else {
            return "N/A"
        }

        let pressureFormatter = MeasurementFormatter()
        pressureFormatter.numberFormatter.maximumFractionDigits = 2

        return pressureFormatter.string(from: pressure)
    }
    
    // MARK: Formatted Temp
    var formattedTemp: String {
        guard let temperature = weather?.currentWeather.temperature else {
            return "N/A"
        }

        let fahrenheitTemp = temperature.converted(to: .fahrenheit).value
        let formattedTemp = String(format: "%.0f",
                                   fahrenheitTemp)

        return formattedTemp
    }
    
    // MARK: Formatted Feels Like
    var formattedApparentTemp: String {
        guard let temperaturefl = weather?.currentWeather.apparentTemperature else {
            return "N/A"
        }

        let fahrenheitTempfl = temperaturefl.converted(to: .fahrenheit).value
        let formattedTempfl = String(format: "%.0f",
                                     fahrenheitTempfl)

        return formattedTempfl
    }
}

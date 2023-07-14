//
//  LuchVC.swift
//  Smart Farmer
//
//  Created by ahmed sherif on 04/04/2023.
//

import UIKit
import CoreLocation

class LunchVC: UIViewController {
    
//MARK: IBOutlets
    @IBOutlet weak var SloganLabel: UILabel!
    
    @IBAction func LunchVCsignUpButton(_ sender: UIButton) {
        let sign = SignUpVC.instatiate()
        navigationController?.pushViewController(sign, animated: true)
    }
    
    @IBAction func LunchVCLogInButton(_ sender: UIButton) {
        let login = LogInVC.instatiate()
        navigationController?.pushViewController(login, animated: true)
    }
    
//MARK: Variables
    //object of Cllocation
    var locationManager = CLLocationManager()
    let notify = NotificationManager.shared
    
//MARK: Life Cycles
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set delegates of cllocation
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        sloganConfiguration()
    }
    
//MARK: Functions
    
    func sloganConfiguration() {
        SloganLabel.text = ""
        var charIndex = 0.0
        let slogan = Constants.slogan
        
        for character in slogan {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false){ (timer) in
                self.SloganLabel.text?.append(character)
            }
            charIndex += 1
        }
    }
    
    func getNotification(_ t: Double) {
        //set notifications from notification manger
        notify.requestAuthorization()
        notify.scheduleNotification(title: "Smart Farmer", body: "The temperature is high today at: \(t) consider more watering for your crop", interval: 6)
    }
}


//MARK: - location & weather section

extension LunchVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude


            // Call getWeatherData
            getWeatherData(latitude: latitude, longitude: longitude) { result in
                switch result {
                case .success(let weatherInfo):
                    // Handle the weather info
                    let weatherTemperature = weatherInfo.main.temp
                    print("location Temperature: \(weatherTemperature)°C")
                    //check if temperature is high then send notification
                    if weatherTemperature > 26.0 {
                        self.getNotification(weatherTemperature)
                    }
                case .failure(let error):
                    // Handle the error
                    print("Error fetching weather info: \(error.localizedDescription)")
                }
            }
        }
    }
    
    //if there is any error with location
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error.localizedDescription)
        // Show a success message or navigate to a password reset confirmation screen
        let locationError = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        self.present(locationError, animated: true, completion: nil)
        
        // Dismiss the alert after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UIView.animate(withDuration: 0.5, animations: {
                locationError.view.alpha = 0.0
            }) { _ in
                locationError.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    // Function to get weather info from OpenWeatherMap API
    func getWeatherData(latitude: Double, longitude: Double, completion: @escaping (Result<WeatherInfo, Error>) -> Void) {
        // Construct the API URL
        let apiKey = "febac4bec0f78d6ba9c748f47d0ab732"
        let apiBaseUrl = "https://api.openweathermap.org/data/2.5/weather"
        let urlString = "\(apiBaseUrl)?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        
        if let url = URL(string: urlString) {
            // Create a URLSession task
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    // Handle the network error
                    completion(.failure(error))
                    return
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let weatherInfo = try decoder.decode(WeatherInfo.self, from: data)
                        let APITemperature = weatherInfo.main.temp
                        print("decoded Temperature: \(APITemperature)°C")
                        completion(.success(weatherInfo))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }.resume()
        } else {
            print("invalid url")
        }
    }
}


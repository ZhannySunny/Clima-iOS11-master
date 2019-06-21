//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeACity {
    
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "c9c662545fa447e0b2dd94fccccf14ca"
    

    //TODO: Declare instance variables here
    
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        //TODO:Set up the location manager here.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/

    
    
    //Write the getWeatherData method here:
    
    func getWeatherData (url: String, parameters: [String: String]) { //method to make a HTTP request
        
    Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            
            response in //response from server
            
            if response.result.isSuccess {
             
                print("Success! Got the weather data!")
                
                let weather_data: JSON = JSON(response.result.value!)
                
                print(weather_data)
                
                self.updateWeatherData(json: weather_data)
                
            }
           
            else {
            
                print("Error: \(String(describing: response.result.error))")
                self.cityLabel.text = "Connection issues"
        }
        
        
            
    }
        
    }
    

    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    //grab out some elements from weatherData: i.e temp, etc.
    
    func updateWeatherData(json: JSON) {
        
    //add optional binding to make this piece of code to be a lot safer
        
    if let mytemp = json["main"]["temp"].double { // convert JSON format into Double
     
    weatherDataModel.temperature = Int(mytemp - 273.15)
        
    weatherDataModel.city = json["name"].stringValue
        
    weatherDataModel.condition = json["weather"][0]["id"].intValue
        
    weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        
    updateUI()
        
        }
        
    else {
        
        cityLabel.text = "Weather is unavailable"
        
        }
    }
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    func updateUI() {
     
    cityLabel.text = weatherDataModel.city
    temperatureLabel.text = "\(weatherDataModel.temperature)°"
    weatherIcon.image = UIImage(named:weatherDataModel.weatherIconName)
        
        
    }
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) // Location manager saves the location into array of Core Location objects
    
    
    {
        
        let location = locations[locations.count - 1]// grab the last, the most accurate value from array
        
        if location.horizontalAccuracy > 0 {
            
            locationManager.stopUpdatingLocation()
        }
        
        print("longitude:\(location.coordinate.longitude)", "latitude:\(location.coordinate.latitude)", "speed:\(location.speed)") //print some weather parameters
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        
        let params: [String:String] = ["lat":latitude, "lon": longitude, "appid": APP_ID]//add all parameters into dictionary
        
        getWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    
    
    //Write the didFailWithError method here:
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print(error)
        
        cityLabel.text = "Location is unavailable"
    }
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    
    func userEntersCity(city: String) {
        
        let params: [String : String] = ["q" : city, "appid": APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
        
        
    }
    
    
    //Write the PrepareForSegue Method here
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.mydeleg = self
            
        }
        
    }
    
}




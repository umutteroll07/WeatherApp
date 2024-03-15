//
//  ShowWeatherViewController.swift
//  WeatherApp
//
//  Created by Umut Erol on 21.10.2023.
//

import UIKit

class ShowWeatherViewController: UIViewController {

    
    @IBOutlet weak var lbl_city: UILabel!
    @IBOutlet weak var lbl_degree: UILabel!
    @IBOutlet weak var lbl_weatherType: UILabel!
    @IBOutlet weak var lbl_feelTemp: UILabel!
    @IBOutlet weak var lbl_min_max_temp: UILabel!
    
    
    
    var city = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "weatherAppBackground2")!)
        
        self.lbl_city.text = self.city
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.city.isEmpty == false {
            
            // 1) Request & Session
            // 2) Responde & Data
            // 3) Parsing & JSON Serialization
            
            let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(self.city)&appid=81553a114bc16e43e474d44f39fe09b3")
    
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: url!) { data, response, error in
               
                if error != nil {
                   
                    self.makeAlert()
                    self.navigationController?.popViewController(animated: true)
                }
                else {
                    
                    if data != nil {
                        
                                                
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: data! ,options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String , Any>
                            
                            DispatchQueue.main.async {
                                
                                if let weather = jsonResult!["weather"] as? [Dictionary<String , Any>] {
                                    if let weatherType = (weather[0]["main"]) as? String {
                                        if weatherType == "Clouds" {
                                            self.lbl_weatherType.text = "Bulutlu"
                                        }
                                    }
                                }
                                
                                
                                
                                if let main = jsonResult!["main"] as? Dictionary<String , Any> {
                                    if let celvin = main["temp"] as? Double {
                                        let degree = celvin - 273.15
                                        let degreeString = String(format: "%1.f", degree)
                                        self.lbl_degree.text = "\(degreeString)°"
                                    }
                                    if let feelCelvin = main["feels_like"] as? Double {
                                        let feelDegree = feelCelvin - 273.15
                                        let feelDegreeString = String(format: "%1.f", feelDegree)
                                        self.lbl_feelTemp.text = "Hissedilen Sıcaklık:\(feelDegreeString)°"
                                    }
                                    if let minCelvin = main["temp_min"] as? Double{
                                        let  minDegree = minCelvin - 273.15
                                        let minDegreeString = String(format: "%1.f", minDegree)
                                        if let maxCelvin = main["temp_max"] as? Double {
                                            let maxDegree = maxCelvin - 273.15
                                            let maxDegreeString = String(format: "%1.f", maxDegree)
                                            self.lbl_min_max_temp.text = "Min:\(minDegreeString)°  Max:\(maxDegreeString)° "                                        }
                                        
                                    }
                                    
                                    
                                    
                                }
                            }
                        }catch {
                            self.makeAlert()
                        }
                                            }

                }
                
            }
            
            
            task.resume()
            
        }
    }
    
    
    func makeAlert() {
        
        let alert = UIAlertController(title: "Bir sorun oluştu.", message: "Şehir ismini doğru girdiğinizden emin olunuz!", preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default)
        
        alert.addAction(alertAction)
        self.present(alert, animated: true)
    }


}

//
//  ViewController.swift
//  WeatherApp
//
//  Created by Umut Erol on 21.10.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txt_city: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "weatherAppBackground2")!)
    }

    @IBAction func btnClicked_weather(_ sender: Any) {
        performSegue(withIdentifier: "toWeather", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toWeather" {
            
            if let showWeatherVC = segue.destination as? ShowWeatherViewController {
                showWeatherVC.city = txt_city.text!
            }
            
        }
    }
    
}


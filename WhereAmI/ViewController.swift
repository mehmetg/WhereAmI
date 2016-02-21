//
//  ViewController.swift
//  WhereAmI
//
//  Created by Mehmet Gerceker on 2/12/16.
//  Copyright © 2016 Awesome Company. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var findMeButton: UIButton!
    @IBOutlet weak var location: UITextView!
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var updates = 0
    var locationOn = true
    override func viewDidLoad() {
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        self.location.text = newLocation.description
        
        geoCoder.reverseGeocodeLocation(newLocation, completionHandler: { (placemarks, error) -> Void in
            
            // Place details
            var placeMark: CLPlacemark!
            placeMark = placemarks?[0]
            
            // Location name
            if let locationName = placeMark.addressDictionary!["Name"] as? NSString {
                self.location.text = self.location.text + "\n" + (locationName as String)
            }
            
            // Street address
            if let street = placeMark.addressDictionary!["Thoroughfare"] as? NSString {
                self.location.text = self.location.text + "\n" + (street as String)
            }
            
            // City
            if let city = placeMark.addressDictionary!["City"] as? NSString {
                self.location.text = self.location.text + "\n" + (city as String)
            }
            
            // Zip code
            if let zip = placeMark.addressDictionary!["ZIP"] as? NSString {
                self.location.text = self.location.text + "\n" + (zip as String)
            }
            
            // Country
            if let country = placeMark.addressDictionary!["Country"] as? NSString {
                self.location.text = self.location.text + "\n" + (country as String)
            }
            
        })
    }
    @IBAction func findMeClick(sender: AnyObject) {
        if self.locationOn {
            self.locationManager.stopUpdatingLocation()
            self.locationOn = false
        } else {
            self.locationManager.startUpdatingLocation()
            self.locationOn = true
        }
        
    }
    
}


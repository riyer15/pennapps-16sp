//
//  ViewController.swift
//  pennapps-16sp
//
//  Created by Veronica Wharton on 1/22/16.
//  Copyright © 2016 hack4impact. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: GMSMapView!
    
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    
    // Array to hold Google Maps markers.
    var markers: Array<GMSMarker> = Array<GMSMarker>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        // Default location is Philadelphia, PA.
        let lat = 40.0049314
        let long = -75.2581173
        
        let camera = GMSCameraPosition.cameraWithLatitude(lat, longitude: long,
            zoom: 6)
        self.mapView.camera = camera
        mapView.myLocationEnabled = true
        
        mapView.addObserver(self, forKeyPath: "myLocation",
            options: NSKeyValueObservingOptions.New, context: nil)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.mapView
        
        markers.append(marker)
    }
    
    override func observeValueForKeyPath(keyPath: String?,
        ofObject object: AnyObject?, change: [String : AnyObject]?,
        context: UnsafeMutablePointer<Void>) {
        if !didFindMyLocation {
            if let change = change {
                let myLocation: CLLocation = change[NSKeyValueChangeNewKey]
                    as! CLLocation
                mapView.camera = GMSCameraPosition.cameraWithTarget(
                    myLocation.coordinate, zoom: 10.0)
                mapView.settings.myLocationButton = true
                
                didFindMyLocation = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let text = searchBar.text
        if let number = Int(text!) {
            showBinaryAlert(number)
        }
        else {
            print("value: \(text) is not a valid  number.")
        }
    }
    
    func showBinaryAlert(number: Int) {
        let alert = UIAlertController(title: "LOL", message: String(number, radix: 2).stringByReplacingOccurrencesOfString("1", withString:"L").stringByReplacingOccurrencesOfString("0", withString:"O") , preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Exit", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(manager: CLLocationManager,
        didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.mapView.myLocationEnabled = true
        }
    }
}


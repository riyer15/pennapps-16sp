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
    
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    
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
        
        // Center the camera in Philadelphia.
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
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
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
    
    func searchBar(searchBar: UISearchBar,
        textDidChange searchText: String){
            
            let placesClient = GMSPlacesClient()
            placesClient.autocompleteQuery(searchText, bounds: nil, filter: nil) { (results, error:NSError?) -> Void in
                self.resultsArray.removeAll()
                if results == nil {
                    return
                }
                for result in results!{
                    if let result = result as? GMSAutocompletePrediction{
                        self.resultsArray.append(result.attributedFullText.string)
                    }
                }
                self.searchResultController.reloadDataWithArray(self.resultsArray)
            }
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        let text = searchBar.text
        
        // Easter egg: Convert base-10 numbers to LOL.
        if let number = Int(text!) {
            showBinaryAlert(number)
        }
    }
    
    /**
        Helper method to diplay the LOL equivalent of a base-10 number.
     
        @param number The base-10 number to convert to LOL.
    */
    func showBinaryAlert(number: Int) {
        let message = String(number, radix: 2)
            .stringByReplacingOccurrencesOfString("1", withString:"L")
            .stringByReplacingOccurrencesOfString("0", withString:"O")
        let alert = UIAlertController(title: "LOL", message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Exit",
            style: UIAlertActionStyle.Default, handler: nil))
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

extension ViewController: LocateOnTheMap {
    func locateWithLongitude(lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            
            let camera  = GMSCameraPosition.cameraWithLatitude(lat, longitude: lon, zoom: 10)
            self.mapView.camera = camera
            
            marker.title = title
            marker.map = self.mapView
        }
    }
}


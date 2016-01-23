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
    
    // Array to hold Google Maps markers.
    var markers: Array<GMSMarker> = Array<GMSMarker>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let camera = GMSCameraPosition.cameraWithLatitude(-33.86,
            longitude: 151.20, zoom: 6)
        self.mapView.camera = camera
        mapView.myLocationEnabled = true
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(-33.86, 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = self.mapView
        
        markers.append(marker)
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


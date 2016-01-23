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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


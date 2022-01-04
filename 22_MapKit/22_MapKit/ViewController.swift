//
//  ViewController.swift
//  22_MapKit
//
//  Created by rae on 2022/01/03.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.register(ArtworkMarkerView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        return mapView
    }()
    
    private let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    
    private var artworks: [Artwork] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        addViews()
        autoLayout()
        
        mapView.centerToLocation(initialLocation)
        
        constrainCamera()
        
        loadInitialData()
        
        mapView.addAnnotations(artworks)
    }
    
    private func addViews() {
        view.addSubview(mapView)
    }

    private func autoLayout() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func constrainCamera() {
        let oahuCenter = CLLocation(latitude: 21.4765, longitude: -157.9647)
        let region = MKCoordinateRegion(
            center: oahuCenter.coordinate,
            latitudinalMeters: 50000,
            longitudinalMeters: 60000
        )
        
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 200000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
    
    private func loadInitialData() {
        guard let fileName = Bundle.main.url(forResource: "PublicArt", withExtension: "geojson"),
              let artworkData = try? Data(contentsOf: fileName) else {
            return
        }
        
        do {
            let features = try MKGeoJSONDecoder()
                .decode(artworkData)
                .compactMap {$0 as? MKGeoJSONFeature}
            let validWorks = features.compactMap(Artwork.init)
            artworks.append(contentsOf: validWorks)
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius
        )
        setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let artwork = view.annotation as? Artwork else { return }
        
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        artwork.mapItem?.openInMaps(launchOptions: launchOptions)
    }
}

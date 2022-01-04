//
//  ArtworkMarkerView.swift
//  22_MapKit
//
//  Created by rae on 2022/01/04.
//

import MapKit

class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            guard let artwork = newValue as? Artwork else {
                return
            }
            
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            markerTintColor = artwork.markerTintColor
            if let letter = artwork.discipline?.first {
                glyphText = String(letter)
            }
        }
    }
}

# 스크린샷
![21](https://github.com/hhhan0315/Swift-30-Projects/blob/main/22_MapKit/22.gif)

# MapView

> 참고 : https://www.raywenderlich.com/7738344-mapkit-tutorial-getting-started

```swift
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
```

- 초기 `CLLocation`을 지정 후 이동
- 동서남북 거리 1000으로 지정 후 해당 위치 지도 표시

# CameraBoundary, CameraZoomRange

```swift
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
```

- `CameraBoundary` : 스크롤 범위를 지정
- `CameraZoomRange` : 축소할 때 범위 지정

# MKAnnotation

- 따로 `Artwork` 클래스로 만들었다.
- `MKAnnotation`은 `NSObjectProtocol`이기 때문에 `NSObject` 상속 필요
- `coordinate`, `title`, `subtitle` 필요

# MKAnnotation View

- `optional func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?` 활용해서 테이블 뷰 추가하는 것처럼 추가

```swift
func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard let annotation = annotation as? Artwork else {
        return nil
    }
    
    let identifier = "artwork"
    var view: MKMarkerAnnotationView
    
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
        dequeuedView.annotation = annotation
        view = dequeuedView
    } else {
        view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        view.canShowCallout = true
        view.calloutOffset = CGPoint(x: -5, y: 5)
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    }
    
    return view
}
```

- 따로 `ArtworkMarkerView` 를 만들면 해당 메소드 대체 가능

|view1|view2|
|--|--|
|![view1](https://github.com/hhhan0315/Swift-30-Projects/blob/main/22_MapKit/view1.png)|![view2](https://github.com/hhhan0315/Swift-30-Projects/blob/main/22_MapKit/view2.png)|

# MKMapItem 사용해 길 찾기

- 마커 클릭 -> 정보 클릭
- `Artwork` 개체를 이용해 `mapItem`에서 `openInMaps()` 실행
- 여기서는 운전 경로를 표시

|||
|--|--|
|![view22](https://github.com/hhhan0315/Swift-30-Projects/blob/main/22_MapKit/view2.png)|![route](https://github.com/hhhan0315/Swift-30-Projects/blob/main/22_MapKit/route.png)|

# MKGeoJSONDecoder

- `GeoJSON` 디코딩
- `MKGeoJSONFeature` -> `MKPointAnnotation` -> `CLLocationCoordinate2D`

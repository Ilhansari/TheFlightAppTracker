//
//  AirportsView.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import UIKit
import MapKit
import CoreLocation

final class AirportsView: UIView {

    private enum Constants {
        static let userDistance: Double = 500000
        static let identifier = "AirportAnnotation"
    }

    // MARK: - Properties
    private(set) lazy var mapView = MKMapView()

    private let locationManager = CLLocationManager()

    private var annotationView: MKAnnotationView?

    private lazy var detailDisclosureButton: UIButton = {
        let button = UIButton(type: .detailDisclosure)
        button.tintColor = .blue
        return button
    }()

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)

        arrangeViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startMapping() {
        setupLocationManager()
        setupMapView()
    }

    private func setupMapView() {
        mapView.delegate = self
        mapView.showsUserLocation = true
    }

    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = false
    }
}

// MARK: Arrange Views
private extension AirportsView {

    func arrangeViews() {
        addSubview(mapView)
        mapView.fillSuperview()
    }
}

// MARK: CLLocationManagerDelegate
extension AirportsView: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {

        switch status {
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {

        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                            longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center,
                                             latitudinalMeters: Constants.userDistance,
                                             longitudinalMeters: Constants.userDistance)
        mapView.setRegion(region, animated: true)
    }

    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: - MKMapViewDelegate
extension AirportsView: MKMapViewDelegate {

    func mapView(_ mapView: MKMapView,
                 viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }

        setAnnotation(annotation, on: mapView)
        setAnnotationImage(for: annotation)
        return annotationView
    }
}

// MARK: - Set Annotation
extension AirportsView {

    func populateAnnotations(_ airports: [AirportsModel]) {
        for airport in airports {
            let annotation = MKPointAnnotation()
            annotation.title = airport.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: airport.latitude,
                                                           longitude: airport.longitude)
            mapView.addAnnotation(annotation)
        }
    }

    private func setAnnotation(_ annotation: MKAnnotation, on mapView: MKMapView) {
        annotationView = mapView
            .dequeueReusableAnnotationView(withIdentifier: Constants.identifier)
        if let annotationView = annotationView {
            annotationView.annotation = annotation
        }
        annotationView = MKAnnotationView(annotation: annotation,
                                          reuseIdentifier: Constants.identifier)
        annotationView?.rightCalloutAccessoryView = detailDisclosureButton
        annotationView?.canShowCallout = true

    }

    private func setAnnotationImage(for annotation: MKAnnotation) {
        annotationView?.image = .flightAnnotation
    }
}

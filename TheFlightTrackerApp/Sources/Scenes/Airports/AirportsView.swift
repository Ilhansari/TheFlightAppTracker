//
//  AirportsView.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import UIKit
import MapKit
import CoreLocation

protocol AirportsViewDelegate: AnyObject {
    func didTapDisclosureButton(model: AirportDetailsModel)
}

final class AirportsView: UIView {

    private enum Constants {
        static let userDistance: Double = 500000
        static let identifier = "AirportAnnotation"
    }

    // MARK: - Properties
    private(set) lazy var mapView = MKMapView()

    private let locationManager = CLLocationManager()

    private var annotationView: MKAnnotationView?

    var airportModels = [AirportsModel]()
    private var furthestAirports = [AirportsModel]()

    weak var delegate: AirportsViewDelegate?

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

    func mapView(_ mapView: MKMapView,
                 annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {

        guard let airportDetails = detailDisclosureTapped(on: view) else { return }
        self.delegate?.didTapDisclosureButton(model: airportDetails)
    }
}

// MARK: - Set Annotation
extension AirportsView {

    func populateAnnotations() {
        for airport in airportModels {
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
        if furthestAirports[0].name == annotation.title
            || furthestAirports[1].name == annotation.title {
            annotationView?.image = .goldFlightAnnotation
        } else {
            annotationView?.image = .flightAnnotation
        }
    }
}

extension AirportsView {

    func detailDisclosureTapped(on view: MKAnnotationView) -> AirportDetailsModel? {
        var airportsDistance: Double = 100000
        var nearestAirport: AirportsModel?

        for firstAirport in airportModels {
            if firstAirport.name == view.annotation?.title {

                for secondAirport in airportModels {
                    let distance = firstAirport.distance(true, to: secondAirport.location)

                    if distance < airportsDistance && firstAirport.id != secondAirport.id {
                        airportsDistance = distance
                        nearestAirport = secondAirport
                    }
                }

                let airportDetails = AirportDetailsModel(airport: firstAirport,
                                                         nearestAirport: nearestAirport?.name ?? "",
                                                         airportsDistance: airportsDistance)

                return airportDetails
            }
        }
        return nil
    }

    func foundAirportsFurthestApart() {
      var distance: CLLocationDistance = .zero
      let x = airportModels.reversed()
      var y = airportModels

      for a in x {
        for b in y {

          let d = a.distance(true, to: b.location)

          if d > distance {
            distance = d
            furthestAirports = []
            furthestAirports.append(a)
            furthestAirports.append(b)

            if let index = y.firstIndex(of: b) {
              y.remove(at: index)
            }
          }
        }
      }
    }
}
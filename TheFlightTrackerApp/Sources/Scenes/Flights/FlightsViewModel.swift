//
//  FlightsViewModel.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import CoreLocation

protocol FlightsViewModelDelegate: AnyObject {
    func didLoadData()
    func handleLoading(isLoading: Bool)
    func handleShowAlert(message: String)
}

final class FlightsViewModel {
    
    private enum Constants {
        static let distanceFormatString = "%.2f %@"
        static let schipholAirportID = "AMS"
        static let kmValue = "km"
        static let milesValue = "mi"
        
        static let schipholLocation: CLLocation = CLLocation(latitude: 52.30907, longitude: 4.763385)
    }
    
    // MARK: - Properties
    var flightsModel = [FlightModel]()
    var flightsConnectedModel =  [FlightModel]()
    var airportsModel = [AirportsModel]()
    var airportsConnectedModel =  [AirportsModel]()
    
    var isKm = UserDefaultsService.shared.isKm
    var trackIsKm = !UserDefaultsService.shared.isKm
    
    weak var delegate: FlightsViewModelDelegate?
    
    var airportsConnectedCount: Int {
        return airportsConnectedModel.count
    }
    
    // MARK: - Initialization
    init() {
        getFlightsData()
    }
    
    private func populateAirports() {
        filterFlightsFromSchiphol()
        filterAirportsConnectedToSchiphol()
        sortConnectedAirports()
    }
    
    func checkDistanceUnitSettings() {
        isKm = UserDefaultsService.shared.isKm
        if trackIsKm == isKm {
            getFlightsData()
            trackIsKm = !UserDefaultsService.shared.isKm
        }
    }
    
    func distanceFromSchiphol(to airport: AirportsModel) -> String {
        let distance = airport.distance(isKm, to: Constants.schipholLocation)
        let unit = isKm ? Constants.kmValue : Constants.milesValue
        let airportDistance = String(format: Constants.distanceFormatString, distance, unit)
        return airportDistance
    }
    
}

// MARK: - Networking
private extension FlightsViewModel {
    
    func getFlightsData() {
        let flightService = NetworkService<FlightModel>(.flights)
        flightService.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.flightsModel = response
                self.getAirportsData()
            case .failure(let error):
                self.delegate?.handleShowAlert(message: error.localizedDescription)
            }
        }
    }
    
    func getAirportsData() {
        let airportsService = NetworkService<AirportsModel>(.airports)
        self.delegate?.handleLoading(isLoading: true)
        airportsService.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.airportsModel = response
                self.populateAirports()
                self.delegate?.didLoadData()
                self.delegate?.handleLoading(isLoading: false)
            case .failure(let error):
                self.delegate?.handleShowAlert(message: error.localizedDescription)
                self.delegate?.handleLoading(isLoading: false)
            }
        }
    }
}

// MARK: - Filter Airports/Flights Distance From Schiphol Location
extension FlightsViewModel {
    
    func filterFlightsFromSchiphol() {
        _ = flightsModel
            .filter { $0.departureAirportId == Constants.schipholAirportID }
            .map { flightsFilterConnected($0) }
    }
    
    func filterAirportsConnectedToSchiphol() {
        _ = airportsModel.compactMap { airportsFilterConnected($0) }
    }
    
    func sortConnectedAirports() {
        airportsConnectedModel
            .sort {
                $0.distance(isKm, to: Constants.schipholLocation)
                    < $1.distance(isKm, to: Constants.schipholLocation)
            }
    }
    
    func flightsFilterConnected(_ flight: FlightModel) {
        if !flightsConnectedModel.contains(
            where: { $0.arrivalAirportId == flight.arrivalAirportId }) {
            flightsConnectedModel.append(flight)
        }
    }
    
    func airportsFilterConnected(_ airport: AirportsModel) {
        for flight in flightsConnectedModel where flight.arrivalAirportId == airport.id {
            if !airportsConnectedModel.contains(where: { $0.id == airport.id }) {
                airportsConnectedModel.append(airport)
            }
        }
    }
}

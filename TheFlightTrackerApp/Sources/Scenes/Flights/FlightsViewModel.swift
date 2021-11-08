//
//  FlightsViewModel.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import Foundation
import CoreLocation

protocol FlightsViewModelDelegate: AnyObject {
    func didLoadData()
}

final class FlightsViewModel {

    private enum Constants {
        static let distanceFormatString = "%.2f %@"
        static let schipholAirportID = "AMS"

        static let schipholLocation: CLLocation = CLLocation(latitude: 52.30907, longitude: 4.763385)
    }
    
    var flightsModel = [FlightModel]()
    var flightsConnectedModel =  [FlightModel]()
    var airportsModel = [AirportsModel]()
    var airportsConnectedModel =  [AirportsModel]()

    var isInKm = UserDefaultsService.shared.isInKm
    var trackIsInKm = !UserDefaultsService.shared.isInKm
    
    weak var delegate: FlightsViewModelDelegate?
    
    
    init() {
        getFlightsData()
    }
    
    private func getFlightsData() {
        let flightService = NetworkService<FlightModel>(.flights)
        flightService.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.flightsModel = response
                self.getAirportsData()
            case .failure:
                break
            }
        }
    }
    
    private func getAirportsData() {
        let airportsService = NetworkService<AirportsModel>(.airports)
        airportsService.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.airportsModel = response
                self.populateAirports()
                self.delegate?.didLoadData()
            case .failure:
                break
            }
        }
    }
    
    func countAirports() -> Int {
        return airportsConnectedModel.count
    }
    
    func checkDistanceUnitSettings() {
        isInKm = UserDefaultsService.shared.isInKm
        if trackIsInKm == isInKm {
            getFlightsData()
            trackIsInKm = !UserDefaultsService.shared.isInKm
        }
    }
    
    private func populateAirports() {
        filterFlightsFromSchiphol()
        filterAirportsConnectedToSchiphol()
        sortConnectedAirports()
    }
    
    func distanceFromSchiphol(to airport: AirportsModel) -> String {
        let distance = airport.distance(isInKm, to: Constants.schipholLocation)
        let unit = isInKm ? "km" : "mi"
        let airportDistance = String(format: Constants.distanceFormatString, distance, unit)
        return airportDistance
    }
    
    private func filterFlightsFromSchiphol() {
        let _ = flightsModel
            .filter { $0.departureAirportId == Constants.schipholAirportID }
            .map { flightsFilterConnected($0) }
    }
    
    private func filterAirportsConnectedToSchiphol() {
        let _ = airportsModel.compactMap { airportsFilterConnected($0) }
    }
    
    private func sortConnectedAirports() {
        airportsConnectedModel
            .sort {
                $0.distance(isInKm, to: Constants.schipholLocation)
                    < $1.distance(isInKm, to: Constants.schipholLocation)
            }
    }
    
    private func flightsFilterConnected(_ flight: FlightModel) {
        if !flightsConnectedModel.contains(
            where: { $0.arrivalAirportId == flight.arrivalAirportId }) {
            flightsConnectedModel.append(flight)
        }
    }
    
    private func airportsFilterConnected(_ airport: AirportsModel) {
        for flight in flightsConnectedModel {
            if flight.arrivalAirportId == airport.id {
                if !airportsConnectedModel.contains(where: { $0.id == airport.id }) {
                    airportsConnectedModel.append(airport)
                }
            }
        }
    }
}

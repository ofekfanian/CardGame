import Foundation
import CoreLocation

// MARK: LocationManager
class LocationManager: NSObject {

    private var clManager = CLLocationManager()
    var callBackLM: LocationCallBack?

    func start() {
        clManager.delegate = self
        clManager.requestWhenInUseAuthorization()
        clManager.startUpdatingLocation()
    }

    func stop() {
        clManager.stopUpdatingLocation()
    }
}

// MARK: CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        callBackLM?.locationUpdated(longitude: location.coordinate.longitude)
    }
}

// MARK: LocationCallBack
protocol LocationCallBack {
    func locationUpdated(longitude: Double)
}

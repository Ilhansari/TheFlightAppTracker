//
//  TabbarController.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import UIKit

private enum TabBarItemType: Int {
    case airports = 0, flights = 1, settings = 2
}

final class TabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabbarItems()
    }

    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        configureTabbar()
    }
}

// MARK: - Configure Tabbar
private extension TabbarController {

    private func configureTabbarItems() {
        let controllers = configureTabbarController()
        setViewControllers(controllers, animated: false)
    }

    func configureTabbar() {
        tabBar.isTranslucent = false
        view.backgroundColor = .black
        UITabBar.appearance().tintColor = .gray
    }

    private func configureTabbarController() -> [UIViewController] {

        let airportsNavigationViewController = createTabbarItem(for: AirportsViewController(),
                                                                title: "Airports",
                                                                image: .airportsIcon,
                                                                tag: .airports)

        let flightsNavigationViewController = createTabbarItem(for: FlightsViewController(),
                                                               title: "Flights",
                                                               image: .flightsIcon,
                                                               tag: .flights)

        let settingsNavigationViewController = createTabbarItem(for: SettingsViewController(),
                                                                title: "Settings",
                                                                image: .settingsIcon,
                                                                tag: .settings)

        return [airportsNavigationViewController,
                flightsNavigationViewController,
                settingsNavigationViewController]
    }

    private func createTabbarItem(for viewController: UIViewController,
                                  title: String,
                                  image: UIImage?,
                                  tag: TabBarItemType) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.tintColor = .blue
        navigationController.tabBarItem = UITabBarItem(title: title, image: image, tag: tag.rawValue)
        return navigationController
    }
}

class FlightsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}

class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
    }
}

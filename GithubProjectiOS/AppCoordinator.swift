import UIKit
import github_core
import WebKit

//MARK: Class

class AppCoordinator: Coordinator {
    
    //MARK: Public variables
    
    public var children = [Coordinator]()
    public var navigationController: UINavigationController
    weak public var parent: Coordinator?
    
    //MARK: Public functions
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    //MARK: Internal functions
    
    func start() {
        let vm = GithubListUserViewModel(coordinator: self)
        let vc = GithubListUserViewController(viewModel: vm)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func routeToDetails(user: UserData) {
        let vm = GithubDetailUserViewModel(user: user, coordinator: self)
        let vc = GithubDetailUserViewController(viewModel: vm)
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func routeToWebView(with route: String) {
        let vc = WebViewController(with: route)
        self.navigationController.pushViewController(vc, animated: true)
    }
}
    

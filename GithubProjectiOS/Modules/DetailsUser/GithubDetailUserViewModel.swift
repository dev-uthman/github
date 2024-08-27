import Foundation
import RxRelay
import RxSwift

class GithubDetailUserViewModel {
    
    private let coordinator: AppCoordinator
    private let user: UserData
    private let disposeBag = DisposeBag()
    
    let service = GithubService()
    var repository = BehaviorRelay<[RepositoryData]?>(value: nil)
    var data = BehaviorRelay<DetailsUserData?>(value: nil)
    var errorMessage = BehaviorRelay<String?>(value: nil)
    
    init(user: UserData, coordinator: AppCoordinator) {
        self.user = user
        self.coordinator = coordinator
        fetchData()
    }
    private func fetchData() {
        let details =  service.getDetailsUser(user: user)
        let repos = service.getRepositorysUser(user: user)
        
        Observable.zip(details, repos).subscribe(onNext: {[weak self] (details, repos) in
            guard let self = self else { return }
            self.data.accept(details)
            self.repository.accept(repos)
        }).disposed(by: disposeBag)
    }
    
    public func routeToWebView(htmlUrl: String) {
        coordinator.routeToWebView(with: htmlUrl)
    }
}

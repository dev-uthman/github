import Foundation
import RxSwift
import RxRelay

//MARK: Class

class GithubListUserViewModel {
    
    //MARK: Private variable
    
    private var disposeBag = DisposeBag()
    private var page: Int = 0
    
    //MARK: Internal variable
    
    let service = GithubService()
    let coordinator: AppCoordinator
    var userData = BehaviorRelay<[GistsData]>(value: [])
    var errorMessage = BehaviorRelay<String?>(value: nil)
    var isFetchingData = BehaviorRelay<Bool>(value: false)
    
    //MARK: Initializer
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    //MARK: Internal functions
    
    func getUsers() {
        service
            .getUser(page: page)
            .subscribe(onNext: { [weak self] gistData in
                guard let self = self else { return }
                self.isFetchingData.accept(false)
                var currentItens = self.userData.value
                currentItens.append(contentsOf: gistData)
                self.userData.accept(currentItens)
            }, onError: { [weak self] error in
                guard let self = self else { return }
                self.isFetchingData.accept(false)
                errorMessage.accept(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
    
    func didRouteDetails(user: UserData) {
        self.coordinator.routeToDetails(user: user)
    }
    
    func loadMoreData() {
        guard !isFetchingData.value else {
               return
           }
           
        isFetchingData.accept(true)
        page += 1
        getUsers()
    }
}

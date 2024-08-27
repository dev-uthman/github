import RxSwift
import github_core

//MARK: Class

public class GithubService {
    
    //MARK: Private variables
    
    private var disposeBag = DisposeBag()
    
    //MARK: Internal functions
    
    func getUser(page: Int) -> Observable<[GistsData]> {
        return APIService.shared
            .fetchData(
                from: "gists/public",
                type: [GistsData].self,
                page: page
            )
    }
    
    func getDetailsUser(user: UserData) -> Observable<DetailsUserData> {
        return APIService
            .shared
            .fetchData(
                from: "users/\(user.login)",
                type: DetailsUserData.self
            )
    }
    
    func getRepositorysUser(user: UserData ) -> Observable<[RepositoryData]> {
        return APIService.shared
            .fetchData(
                from: "users/\(user.login)/repos",
                type: [RepositoryData].self
            )
    }
}





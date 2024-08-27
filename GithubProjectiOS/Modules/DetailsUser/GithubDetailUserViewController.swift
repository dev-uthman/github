import UIKit
import RxSwift
import github_core

//MARK: Class

class GithubDetailUserViewController: BaseViewController<GithubDetailView> {
    
    //MARK: Private variables
    
    private let disposeBag = DisposeBag()
    private let viewModel: GithubDetailUserViewModel
    
    //MARK: Initializers
    
    init(viewModel: GithubDetailUserViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBind()
    }
    
    private func setupUI() {
        title = Strings.Details.title
        customView.backgroundColor = .black
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
    }
    
    //MARK: Private functions
    
    private func setupBind() {
        showLoading()
        viewModel
            .data
            .flatMap({[weak self] data -> Observable<DetailsUserData?> in
                guard let self = self else { return .empty() }
                self.hideLoading()
                return .just(data)
            })
            .bind(to: customView.data)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] errorMessage in
                guard let self = self else { return }
                self.hideLoading()
                self.customView.showToast(message: errorMessage ?? "")
            }).disposed(by: disposeBag)
    }
}

//MARK: Extension TableView

extension GithubDetailUserViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repository.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GithubRepositoryCell.identifier, for: indexPath)  as? GithubRepositoryCell

        if let data = viewModel.repository.value?[indexPath.row] {
            cell?.nameRepo.text = data.name
            cell?.urlRepo.text = data.html_url
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = viewModel.repository.value?[indexPath.row] {
            viewModel.routeToWebView(htmlUrl: data.html_url ?? "")
        }
    }
}

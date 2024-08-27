import UIKit
import Foundation
import RxSwift
import github_core

//MARK: Class

class GithubListUserViewController: BaseViewController<GithubListView> {
    
    //MARK: Private variables
    
    private let disposeBag = DisposeBag()
    private let viewModel: GithubListUserViewModel
    
    
    //MARK: Initializer

    init(viewModel: GithubListUserViewModel) {
        self.viewModel = viewModel
        super.init()
        self.customView.backgroundColor = .black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK: Private functions

    private func setupUI() {
        self.title = Strings.List.title
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        
        setupBind()
    }
    
    private func setupBind() {
        showLoading()
        viewModel.getUsers()
        
        viewModel
            .userData
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.hideLoading()
                self.customView.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel
            .errorMessage
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] errorMessage in
                guard let self = self else { return }
                self.hideLoading()
                self.customView.showToast(message: errorMessage ?? "")
            }).disposed(by: disposeBag)
        
        viewModel
            .isFetchingData
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: { [customView] isFeching in
                guard isFeching else {
                    customView.footerStopLoading()
                    return
                }
                customView.footerStartLoading()
            }).disposed(by: disposeBag)
    }
}

//MARK: Extension TableView

extension GithubListUserViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userData.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GithubListUserCell.identifier, for: indexPath)  as? GithubListUserCell
        cell?.accessoryType = .disclosureIndicator
        let user = self.viewModel.userData.value[indexPath.row]
        cell?.userName.text = user.owner.login.prefix(1).capitalized + user.owner.login.dropFirst()
        let txtFile = user.files.count > 1 ? Strings.List.filesDesc : Strings.List.fileDesc
        cell?.userFile.text = "\(user.files.count) \(txtFile)"
        cell?.avatarUserImage.roundedLoadImage(from: user.owner.avatar_url)
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let owner = viewModel.userData.value[indexPath.row].owner
        viewModel.didRouteDetails(user: owner)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.userData.value.count - 1 {
            viewModel.loadMoreData()
        }
    }
}

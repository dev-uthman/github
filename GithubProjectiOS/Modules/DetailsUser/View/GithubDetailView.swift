import UIKit
import RxSwift
import RxCocoa

//MARK: Class

class GithubDetailView: UIView {
    
    //MARK: Initializers
    
    init() {
        super.init(frame: .zero)
        addSubViews()
        setupConstraints()
        setupRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Internal variables
    
    var data = BehaviorRelay<DetailsUserData?>(value: nil)
    
    var tableView: UITableView = {
        var view = UITableView()
        view.backgroundColor = .black
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(GithubRepositoryCell.self, forCellReuseIdentifier: GithubRepositoryCell.identifier)
        return view
    }()
    
    //MARK: Private variables
    
    private var disposeBag = DisposeBag()
    
    private var userName: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var nickName: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    private var avatarUserImage: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var company: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var location: UILabel = {
        var label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var repositorys: UILabel = {
        var label = UILabel()
        label.text = Strings.Details.repos
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var lineView: UIView = {
        var line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    private func addSubViews() {
        addSubview(userName)
        addSubview(nickName)
        addSubview(avatarUserImage)
        addSubview(location)
        addSubview(company)
        addSubview(repositorys)
        addSubview(lineView)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarUserImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarUserImage.topAnchor.constraint(equalTo:safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarUserImage.widthAnchor.constraint(equalToConstant: 70.0),
            avatarUserImage.heightAnchor.constraint(equalToConstant: 70.0)
            
        ])
        
        NSLayoutConstraint.activate([
            userName.topAnchor.constraint(equalTo: avatarUserImage.bottomAnchor, constant: 16),
            userName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            userName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            nickName.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 4),
            nickName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nickName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            company.topAnchor.constraint(equalTo: nickName.bottomAnchor, constant: 16),
            company.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            company.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(equalTo: company.bottomAnchor, constant: 4),
            location.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            location.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            repositorys.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 24),
            repositorys.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            repositorys.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: repositorys.bottomAnchor, constant: 12),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    private func setupRx() {
        data
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(onNext: {[weak self] data in
                guard let self = self else { return }
                self.userName.text = data?.name
                self.nickName.text = data?.login
                self.company.text = data?.company
                self.location.text = data?.location
                self.avatarUserImage.roundedLoadImage(from: data?.avatar_url ?? "")
                self.tableView.reloadData()
                
            }).disposed(by: disposeBag)
    }
}

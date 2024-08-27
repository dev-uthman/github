import UIKit

//MARK: Class View

class GithubListView: UIView {
    
    //MARK: Initializer
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Internal variables
    
    var tableView: UITableView = {
        var view = UITableView()
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(GithubListUserCell.self, forCellReuseIdentifier: GithubListUserCell.identifier)
        view.tableFooterView = UIView()
        return view
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        $0.color = .red
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))
    
    //MARK: Private functions
    
    private func setup() {
        addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
        
    }
    
    //MARK: Internal functions
    
    func footerStartLoading() {
        DispatchQueue.main.async {
            self.tableView.tableFooterView = self.loadingIndicator
            self.loadingIndicator.startAnimating()
        }
    }

    func footerStopLoading() {
        DispatchQueue.main.async {
            self.loadingIndicator.stopAnimating()
            self.tableView.tableFooterView = nil
        }
    }
}

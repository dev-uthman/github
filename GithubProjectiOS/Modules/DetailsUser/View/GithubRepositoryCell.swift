import UIKit

class GithubRepositoryCell: UITableViewCell {
    
    static let identifier = String(describing: GithubRepositoryCell.self)
    
    var nameRepo: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var urlRepo: UILabel = {
        var label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    var lineView: UIView = {
        var line = UIView()
        line.backgroundColor = .lightGray
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()
    
    override init(style _: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupAddViews()
        setupConstraints()
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAddViews() {
        addSubview(nameRepo)
        addSubview(urlRepo)
        addSubview(lineView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            nameRepo.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            nameRepo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameRepo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            urlRepo.topAnchor.constraint(equalTo: nameRepo.bottomAnchor, constant: 4),
            urlRepo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            urlRepo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            urlRepo.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
        ])
        
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}

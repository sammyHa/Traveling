//
//  ListTableViewCell.swift
//  Traveler
//
//  Created by Samim Hakimi on 4/10/22.
//

import UIKit
protocol ListTableViewCellDelagate: AnyObject {
    func checkBoxtoggle(sender: ListTableViewCell)
}
class ListTableViewCell: UITableViewCell {

    var observer: NSObjectProtocol?
    static let identifier = "ListTableViewCell"
    weak var delegate: ListTableViewCellDelagate?
    
    public let itemsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "T-Shirts"
        label.textColor = UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1.0)
        return label
    }()
    
    public let itemsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "4"
    
        label.textColor = UIColor(red: 75/255, green: 75/255, blue: 75/255, alpha: 1.0)
        return label
    }()
    
    public let checkBox: UIButton = {
        let button = UIButton()
        button.layer.backgroundColor = UIColor.white.cgColor
        button.setImage(UIImage(named: "check_circle"), for: .selected)
        button.setImage(UIImage(named: "uncheck_circle"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        contentView.addSubview(itemsLabel)
        contentView.addSubview(itemsCountLabel)
        
        contentView.addSubview(checkBox)
        itemsLabel.translatesAutoresizingMaskIntoConstraints = false
        itemsCountLabel.translatesAutoresizingMaskIntoConstraints = false
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        
        
         
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
        contentView.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: itemsLabel.leadingAnchor, constant: -25).isActive = true
        itemsLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        
        itemsCountLabel.leadingAnchor.constraint(equalTo: checkBox.leadingAnchor, constant: -55).isActive = true
        itemsCountLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
        contentView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 25).isActive = true
        checkBox.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        checkBox.addTarget(self, action: #selector(checkToggle(sender:)), for: .touchUpInside)
        

    }
    
    public func configure(with viewModel: ItemViewModel){
        itemsLabel.text = viewModel.name
        itemsCountLabel.text = String(viewModel.quantity)
        if viewModel.isComplete {
            checkBox.setImage(UIImage(named: "check_circle"), for: .selected)
        }else {
            checkBox.setImage(UIImage(named: "uncheck_circle"), for: .normal)
            
        }
    }
    
    @objc func checkToggle(sender: UIButton){
        delegate?.checkBoxtoggle(sender: self)
      
    }
}


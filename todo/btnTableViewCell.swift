//
//  btnTableViewCell.swift
//  todo
//
//  Created by Jerry on 2021-11-27.
//

import UIKit

class btnTableViewCell: UITableViewCell {
    
    var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // name
        let nameRect = CGRect(
            x: 20,
            y: 0,
            width: 200,
            height: 60
        )
        nameLabel = UILabel(frame: nameRect)
        nameLabel.text = "New"
        nameLabel.textAlignment = NSTextAlignment.left
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        
        
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

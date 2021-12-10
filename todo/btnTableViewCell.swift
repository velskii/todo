/**
 * Assignment 5
 * File Name:       RootController.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         3.0
 * Date Created:    December 10  2021
 */

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
            x: 170,
            y: 10,
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

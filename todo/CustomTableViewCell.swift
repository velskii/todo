
/**
 * Assignment 5
 * File Name:       RootController.swift
 * Author:          FeiliangZhou
 * Student ID:      301216989
 * Version:         3.0
 * Date Created:    December 10  2021
 */
import UIKit
import Foundation

class CustomTableViewCell: UITableViewCell
{
    weak var editButton: UIButton!
    var name:String = ""
    {
        didSet
        {
            if(name != oldValue)
            {
                nameLabel.text = name
            }
        }
    }
    
    var state: String = ""
    {
        didSet
        {
            if(state != oldValue)
            {
                stateLabel.text = state
            }
        }
    }
    
    var nameLabel: UILabel!
    var stateLabel: UILabel!
    
    var height: Int = 30
    var titleFontSize: CGFloat = 25
    var stateFontSize: CGFloat = 15
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // name
        let nameRect = CGRect(
            x: 20,
            y: 10,
            width: 200,
            height: self.height
        )
        nameLabel = UILabel(frame: nameRect)
        nameLabel.textAlignment = NSTextAlignment.left
        nameLabel.font = UIFont.boldSystemFont(ofSize: self.titleFontSize)
        
        // state
        let stateRect = CGRect(
            x: 30,
            y: 36,
            width: 200,
            height: self.height
        )
        stateLabel = UILabel(frame: stateRect)
        stateLabel.textAlignment = NSTextAlignment.left
        stateLabel.font = UIFont.boldSystemFont(ofSize: self.stateFontSize)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(stateLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }

}

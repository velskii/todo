
/**
 * Assignment 4
 * File Name:    CustomViewController.swift
 * Author:         FeiliangZhou
 * Student ID:   301216989
 * Version:        1.0
 * Date Created:   November 13  2021
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
                if (state == "completed")
                {
                    nameLabel.textColor = UIColor.gray
                    stateLabel.textColor = UIColor.gray
                    switchUI.isOn = false
                    switchUI.isEnabled = false
                }else {
                    switchUI.isOn = true
                }
                if (state == "Overdue!")
                {
                    switchUI.isEnabled = false
                    switchUI.isOn = false
                    nameLabel.textColor = UIColor.red
                    stateLabel.textColor = UIColor.red
                }
                
            }
        }
    }
    
    var nameLabel: UILabel!
    var stateLabel: UILabel!
    var switchUI: UISwitch!
    var height: Int = 30
    var titleFontSize: CGFloat = 25
    var stateFontSize: CGFloat = 15
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // name
        let nameRect = CGRect(
            x: 20,
            y: 0,
            width: 200,
            height: self.height
        )
        nameLabel = UILabel(frame: nameRect)
        nameLabel.textAlignment = NSTextAlignment.left
        nameLabel.font = UIFont.boldSystemFont(ofSize: self.titleFontSize)
        
        // state
        let stateRect = CGRect(
            x: 30,
            y: 16,
            width: 200,
            height: self.height
        )
        stateLabel = UILabel(frame: stateRect)
        stateLabel.textAlignment = NSTextAlignment.left
        stateLabel.font = UIFont.boldSystemFont(ofSize: self.stateFontSize)
        
        //switch
        switchUI = UISwitch(frame: CGRect(
            x: 250,
            y: 5,
            width: 30,
            height: self.height
        ))
        switchUI.isEnabled = true
        switchUI.isOn = true
        switchUI.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
        
        //edit button
        let editButton = UIButton(frame: CGRect(
            x: 320,
            y: 5,
            width: 80,
            height: self.height
        ))
        let editImage = UIImage(systemName: "square.and.pencil")
        editButton.setImage(editImage, for: UIControl.State.normal)
        editButton.setTitleColor(.blue, for: .normal)
        self.editButton = editButton
        
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(stateLabel)
        contentView.addSubview(switchUI)
        contentView.addSubview(editButton)
    }
    
    
    @objc func switchStateDidChange(_ sender:UISwitch!)
    {
        if (sender.isOn == true){
            print("UISwitch state is now ON")
            stateLabel.text = state
            nameLabel.textColor = UIColor.black
            stateLabel.textColor = UIColor.black
        }
        else{
            print("UISwitch state is now Off")
            stateLabel.text = "completed"
            nameLabel.textColor = UIColor.gray
            stateLabel.textColor = UIColor.gray
        }
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

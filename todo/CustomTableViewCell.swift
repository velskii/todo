
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //name Label
        let nameLabelRect = CGRect(x: 0, y: 5, width: 70, height: 15)
        let nameMarker = UILabel(frame: nameLabelRect)
        nameMarker.textAlignment = NSTextAlignment.right
        nameMarker.text = "Name:"
        nameMarker.font = UIFont.boldSystemFont(ofSize: 12)
        // name value
        let nameValueRect = CGRect(x: 0, y: 5, width: 200, height: 15)
        nameLabel = UILabel(frame: nameValueRect)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        // state Label
        let stateLabelRect = CGRect(x: 0, y: 26, width: 70, height: 15)
        let stateMarker = UILabel(frame: stateLabelRect)
        stateMarker.textAlignment = NSTextAlignment.right
        stateMarker.text = "State:"
        stateMarker.font = UIFont.boldSystemFont(ofSize: 12)
        // state value
        let stateValueRect = CGRect(x: 0, y: 26, width: 200, height: 15)
        stateLabel = UILabel(frame: stateValueRect)
        stateLabel.font = UIFont.boldSystemFont(ofSize: 12)
        
        //switch view
        switchUI = UISwitch(frame: CGRect(x: 250, y: 5, width: 30, height: 15))
        switchUI.isEnabled = true
        switchUI.isOn = true
        switchUI.addTarget(self, action: #selector(self.switchStateDidChange(_:)), for: .valueChanged)
//        switchUI.setOn(true, animated: false)
        //button
        let editButton = UIButton(frame: CGRect(x: 300, y: 15, width: 80, height: 15))
        let editImage = UIImage(systemName: "square.and.pencil")
        editButton.setImage(editImage, for: UIControl.State.normal)
//        editButton.setTitle("edit", for: .normal)
        editButton.setTitleColor(.blue, for: .normal)
        editButton.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        
        contentView.addSubview(switchUI)
        contentView.addSubview(editButton)
        //render the view
//        contentView.addSubview(nameMarker)
        contentView.addSubview(nameLabel)
//        contentView.addSubview(stateMarker)
        contentView.addSubview(stateLabel)
        
       
    }
    @objc func pressed ()
    {
        print("pressed for this one")
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

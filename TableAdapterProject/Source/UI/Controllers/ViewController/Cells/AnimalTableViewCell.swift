//
//  AnimalTableViewCell.swift
//  TableAdapter
//
//  Created by IDAP Developer on 8/7/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

import TableAdapter

enum AnimalTableViewCellEvents {
    
    case buttonDidTapped
}

class AnimalTableViewCell: BaseCell<Animal, AnimalTableViewCellEvents> {
    
    override func fill(with model: Animal) {
        self.textLabel?.text = model.name
    }
    
    @IBAction func didTap(_ sender: Any) {
        self.eventHandler?(.buttonDidTapped)
    }
}

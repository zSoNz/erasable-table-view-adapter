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
    
    @IBOutlet var animalName: UILabel?
    
    override func fill(with model: Animal) {
        self.animalName?.text = model.name
    }
    
    @IBAction func didTap(_ sender: Any) {
        self.eventHandler?(.buttonDidTapped)
    }
}

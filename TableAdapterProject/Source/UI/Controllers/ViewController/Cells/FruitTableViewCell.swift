//
//  FruitTableViewCell.swift
//  TableAdapter
//
//  Created by IDAP Developer on 8/7/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

import TableAdapter

enum FruitTableViewCellEvents {
    
}

class FruitTableViewCell: BaseCell<Fruit, FruitTableViewCellEvents> {

    override func fill(with model: Fruit) {
        self.textLabel?.text = model.name
    }
}


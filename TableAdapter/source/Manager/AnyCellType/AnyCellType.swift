//
//  AnyCellType.swift
//  TableAdapter
//
//  Created by Bogdan Kikacheishvili on 8/11/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

protocol AnyCellType: UITableViewCell {
    
    func fill(with model: Any, eventHandler: @escaping F.Handler<Any>)
}

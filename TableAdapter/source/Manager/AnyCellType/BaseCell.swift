//
//  BaseCell.swift
//  TableAdapter
//
//  Created by Bogdan Kikacheishvili on 8/11/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

open class BaseCell<Model, Events>: UITableViewCell, AnyCellType {
    
    //MARK: -
    //MARK: Accesors
    
    public var eventHandler: F.Handler<Events>?
    
    // MARK: -
    // MARK: Cell Life Cycle

    open override func prepareForReuse() {
        self.eventHandler = nil
        super.prepareForReuse()
    }
    
    //MARK: -
    //MARK: AnyCellType
    
    func fill(with model: Any, eventHandler: @escaping F.Handler<Any>) {
        if let value = model as? Model {
            self.fill(with: value)
            self.eventHandler = {
                eventHandler($0)
            }
        }
    }
    
    open func fill(with model: Model) {
        fatalError("Abstract method used for child classes")
    }
}

//
//  EmptyBaseCell.swift
//  TableAdapter
//
//  Created by Bogdan Kikacheishvili on 8/11/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

/**
 EmptyBaseCell is a open class for cells witout model whats be applied in section initialization.
 */
open class EmptyBaseCell<Events>: UITableViewCell, AnyCellType {
    
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
        self.eventHandler = {
            eventHandler($0)
        }
    }
}

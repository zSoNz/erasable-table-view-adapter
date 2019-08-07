//
//  Section.swift
//  TableAdapter
//
//  Created by IDAP Developer on 8/7/19.
//  Copyright © 2019 Bendis. All rights reserved.
//

import UIKit

public struct Section {
    
    //MARK: -
    //MARK: Accesors
    
    let cell: AnyCellType.Type
    var models: [Any]
    let eventHandler: (Any) -> ()
    
    //MARK: -
    //MARK: Initializations
    
    //TO-DO: Wrap event handler into WeakBox
    public init<Cell, Model, EventsType>(cell: Cell.Type, models: [Model], eventHandler: @escaping F.Handler<EventsType>)
        where Cell: BaseCell<Model, EventsType>
    {
        self.cell = cell
        self.models = models
        self.eventHandler = {
            if let event = $0 as? EventsType {
                eventHandler(event)
            }
        }
    }
}

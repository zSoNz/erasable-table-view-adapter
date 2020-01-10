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
    let isEditing: Bool
    let sectionDelimetrs: SectionDelimetrs
    
    //MARK: -
    //MARK: Initializations
        
    public init<Cell, Model, EventsType>(
        cell: Cell.Type,
        models: [Model],
        isEditing: Bool = false,
        sectionsImages: SectionDelimetrs = SectionDelimetrs(),
        eventHandler: @escaping F.Handler<EventsType> = { _ in }
    )
        where Cell: BaseCell<Model, EventsType>
    {
        self.cell = cell
        self.models = models
        self.isEditing = isEditing
        self.sectionDelimetrs = sectionsImages
        self.eventHandler = {
            if let event = $0 as? EventsType {
                eventHandler(event)
            }
        }
    }
    
    public init<Cell, EventsType>(
        cell: Cell.Type,
        count: Int,
        isEditing: Bool = false,
        sectionDelimetrs: SectionDelimetrs = SectionDelimetrs(),
        eventHandler: @escaping F.Handler<EventsType> = { _ in }
    )
        where Cell: EmptyBaseCell<EventsType>
    {
        self.cell = cell
        self.models = .init(repeating: count, count: count)
        self.isEditing = isEditing
        self.sectionDelimetrs = sectionDelimetrs
        self.eventHandler = {
            if let event = $0 as? EventsType {
                eventHandler(event)
            }
        }
    }
}

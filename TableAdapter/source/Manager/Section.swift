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
    
    /*
     Initializator for section what contains cells with models.
     
     @param cell Type of cell what be displayed in this section
     @param models Array of models for section
     @param isEditing If this param setted to true, this section will be editable for user. Default 'false'
     @param sectionsImages Define this field for dispalay header or footer of section. Default value with nilled values.
     @param eventHandler Closure for handling of custom UITableViewCell events
     */
    public init<Cell, Model, EventsType>(
        cell: Cell.Type,
        models: [Model],
        isEditing: Bool = false,
        sectionDelimetrs: SectionDelimetrs = SectionDelimetrs(),
        eventHandler: @escaping F.Handler<EventsType> = { _ in }
    )
        where Cell: BaseCell<Model, EventsType>
    {
        self.cell = cell
        self.models = models
        self.isEditing = isEditing
        self.sectionDelimetrs = sectionDelimetrs
        self.eventHandler = {
            if let event = $0 as? EventsType {
                eventHandler(event)
            }
        }
    }
    
    /*
     Initializator for section what contains cells without models.
     
     @param cell Type of cell what be displayed in this section
     @param count Count of cells should be displayed.
     @param isEditing If this param setted to true, this section will be editable for user. Default 'false'
     @param sectionDelimetrs Define this field for dispalay header or footer of section. Default value with nilled values.
     @param eventHandler Closure for handling of custom UITableViewCell events
     */
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

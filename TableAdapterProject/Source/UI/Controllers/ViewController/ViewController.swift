//
//  ViewController.swift
//  TableAdapter
//
//  Created by IDAP Developer on 8/7/19.
//  Copyright © 2019 Bendis. All rights reserved.
//
//

import UIKit

import TableAdapter

class ViewController: UIViewController {
    
    @IBOutlet var table: UITableView?
    
    var adapter: TableAdapter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.adapter = TableAdapter(table: self.table, cells: [AnimalTableViewCell.self, FruitTableViewCell.self])
        
        self.adapter?.eventHandler = { [weak self] in
            self?.handle(tableEvents: $0)
        }
        
        self.adapter?.sections = self.sections()
    }
    
    //MARK: -
    //MARK: Private
    
    private func sections() -> [Section] {
        let firstSection = Section(
            cell: AnimalTableViewCell.self,
            models: [Animal(name: "Cow"), Animal(name: "Horse")],
            eventHandler: { [weak self] in self?.handle(animalEvents: $0) }
        )
        
        let secondSection = Section(
            cell: FruitTableViewCell.self,
            models: [Fruit(name: "Apple"), Fruit(name: "Peach")],
            eventHandler: { [weak self] in self?.handle(fruitEvents: $0) }
        )
        
        return [firstSection, secondSection]
    }
    
    //MARK: -
    //MARK: Handlers
    
    private func handle(tableEvents: TableViewEvents) {
        switch tableEvents {
        case let .didSelect(indexPath):
            print(indexPath)
        case .didRemove(_):
            break
        case .loadNext:
            break
        }
    }
    
    private func handle(fruitEvents: FruitTableViewCellEvents) {
        
    }
    
    private func handle(animalEvents: AnimalTableViewCellEvents) {
        switch animalEvents {
        case .buttonDidTapped:
            break
        }
    }
}

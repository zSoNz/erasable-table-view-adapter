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
        
        self.adapter = TableAdapter(
            table: self.table,
            cells: [AnimalTableViewCell.self, FruitTableViewCell.self, EmptyTableViewCell.self]
        )
        
        self.adapter?.eventHandler = { [weak self] in
            self?.handle(tableEvents: $0)
        }
        
        self.adapter?.sections = self.sections()
    }
    
    //MARK: -
    //MARK: Private
    
    private func sections() -> [Section] {
        let yellowView = UIView()
        yellowView.backgroundColor = .yellow
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let firstSection = Section(
            cell: AnimalTableViewCell.self,
            models: [Animal(name: "Cow"), Animal(name: "Horse")],
            sectionsImages: SectionImages(footer: .init(view: blueView, height: 20)),
            eventHandler: { [weak self] in self?.handle(animalEvents: $0) }
        )
        
        let secondSection = Section(
            cell: FruitTableViewCell.self,
            models: [Fruit(name: "Apple"), Fruit(name: "Peach")],
            isEditing: true,
            sectionsImages: SectionImages(header: .init(view: yellowView, height: 20)),
            eventHandler: { [weak self] in self?.handle(fruitEvents: $0) }
        )
        
        let thirdSection = Section(
            cell: EmptyTableViewCell.self,
            count: 3,
            eventHandler: { [weak self] in self?.handle(emptyEvents: $0) }
        )
        
        return [firstSection, secondSection, thirdSection]
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
    
    private func handle(emptyEvents: EmptyBaseCellEvents) {
        
    }
    
    private func handle(animalEvents: AnimalTableViewCellEvents) {
        switch animalEvents {
        case .buttonDidTapped:
            print("buttonDidTapped")
        }
    }
}

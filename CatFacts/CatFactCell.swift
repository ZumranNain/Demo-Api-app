//
//  CatFactCell.swift
//  CatFacts
//
//  Created by Zumran Nain on 2022-01-31.
//

import UIKit

class CatFactCell: UICollectionViewCell {

    
    static let identifier = "CatFactCell"
    
     var idLabel: UILabel = {
        
         var label = UILabel()
         label.text = "Custom"
         label.backgroundColor = .systemBlue
         label.textAlignment = .center
         label.textColor = .white
         label.numberOfLines = 0
      
        return label
    }()

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.contentView.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        contentView.addSubview(idLabel)
    
    }
    
    override func layoutSubviews(){
        
        super.layoutSubviews()
        idLabel.frame = CGRect(x:5, y: 10, width: contentView.frame.size.width - 5, height: contentView.frame.size.height)
        
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

//
//  CarModels.swift
//
//  Created by Shubham on 20/11/17.
//  Copyright © 2017 Shubham. All rights reserved.
//

import Foundation
import UIKit

class LeoCarMakeTextField: UITextField, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var pickerView: UIPickerView = UIPickerView()
    
    var carMake : [LeoCarMake.MakeDetail] = []
    
    //var carColors:  [CarColorType] = CarColor.CarColors()
    
    // Use this class to have single image.
    
    public  var closureDidSelectCarMake: ((_ subcategory: LeoCarMake.MakeDetail) -> Void)?
    
    func configure(carMake : [LeoCarMake.MakeDetail]) {
        self.carMake = carMake
        
        if carMake.count <= 0 {
            self.isEnabled = false
        }else {
            self.isEnabled = true
        }
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
        if let index = pickerView.selectedRow(inComponent: 0) as Int? {
            
            if carMake.count > 0 {
                let carMakeType: LeoCarMake.MakeDetail = carMake[index]
                self.text = carMakeType.makeId
            }
            
        }
        
    }
   
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        addInputAccessoryView()
        
        self.inputView = pickerView
        self.textColor = .black
        //self.textColor = AppColor.theme.color
        pickerView.dataSource = self
        
        pickerView.delegate = self
        
        pickerView.selectRow(0, inComponent: 0, animated: true)
        if carMake.count <= 0 {
            self.isEnabled = false
        }else {
            self.isEnabled = true
        }
        
        if let index = pickerView.selectedRow(inComponent: 0) as Int? {
            
            if carMake.count > 0 {
                let carMakeType: LeoCarMake.MakeDetail = carMake[index]
                self.text = carMakeType.makeId
            }
            
        }
        
    }
    
    func addInputAccessoryView() {
        let toolbar = UIToolbar()
        
        toolbar.sizeToFit()
        
        let donebutton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(menuButtonTapped(sender:)))
        
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        var arraybutton: [UIBarButtonItem] = []
        
        // arraybutton.append(donebutton)
        
        arraybutton.append(space)
        
        arraybutton.append(donebutton)
        
        toolbar.setItems(arraybutton, animated: true)
        
        self.inputAccessoryView = toolbar
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        print("\(String(describing: self.inputAccessoryView))")
    }
    deinit {
        
    }
    
    @objc func menuButtonTapped(sender _: UIBarButtonItem) {
        
        if let index = pickerView.selectedRow(inComponent: 0) as Int? {
            
            let carMakeType: LeoCarMake.MakeDetail = carMake[index]
            
            self.text = carMakeType.makeId
            closureDidSelectCarMake?(carMakeType)
            
            
        }
        
        _ = resignFirstResponder()
        
    }
    
    func pickerTextFieldEditingDidEnd(_: UITextField) {
        
    }
    
    // MARK: PickerViewDelegate
    public func numberOfComponents(in _: UIPickerView) -> Int {
        return 1
    }
    public func pickerView(_: UIPickerView, numberOfRowsInComponent _: Int) -> Int {
        return carMake.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let carMakeType: LeoCarMake.MakeDetail = carMake[row]
        return carMakeType.makeId
    }
    
    func pickerView(_: UIPickerView, didSelectRow row: Int, inComponent _: Int) {
        let carMakeType: LeoCarMake.MakeDetail = carMake[row]
        self.text = carMakeType.makeId
        closureDidSelectCarMake?(carMakeType)
        
    }
    
    
}



/*
Use this functions to fetch details in the ViewController


    func getCarMake(){
        
//        let  urlString : String  = "https://www.carqueryapi.com/api/0.3/?=?&cmd=getMakes"
           let fileUrl = URL(string: "https://www.carqueryapi.com/api/0.3/?=?&cmd=getMakes")
         print("💇🏼‍♀️",fileUrl)
        
        
        WebServices.get(url: fileUrl! as URL, completionHandler: { (response, _) in
           
            print("",response)
            
           
            
            self.apiCarMake = LeoCarMake(response: response)
            
            // self.txtSelectMake.carMake = self.apiCarMakes?.carMakes ?? []
            
            self.txtCarMake.configure(carMake: self.apiCarMake?.carMakes ?? [])
            
            
        }) { (response, _) in
            
        }
    }

*/



/*
write this code in ViewDidload 
so that the textfield(txtSelectModel) should fetch and show the details from the Api


        txtCarMake.closureDidSelectCarMake = { carMake in
           
         self.carMake = carMake
            self.getCarModel(makeId: carMake.makeId!)
            self.txtSelectModel.closureDidSelectCarModel = { carModel in
                self.carModel = carModel
                print("🚘 Make Selected",carModel.modelMakeId!)
                self.make = carModel.modelMakeId!
                print("🚗 Model Selected",carModel.modelName!)
                self.model = carModel.modelName!
            }
            
        }

*/

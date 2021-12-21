//
//  ConfigScreenViewController.swift
//  Desafio 3(CII-3)
//
//  Created by Guilherme - ília on 21/12/21.
//

import UIKit

class ConfigScreenViewController: UIViewController {
    
    let colorsData = Colors()
    var viewModel = ConfigViewModel()
    var delegate: ChangeCollectionColor?
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var backgroundLabel: UILabel!
    @IBOutlet weak var BackgroundPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.BackgroundPicker.delegate = self
        self.BackgroundPicker.dataSource = self
        let defaultRow = defaults.object(forKey: "UserRow") as? Int ?? 0
        BackgroundPicker.selectRow(defaultRow, inComponent:0, animated:true)
        let defaultColor = defaults.object(forKey: "UserColor") as? String ?? "White"
        view.backgroundColor = Colors.colors[defaultColor]
        backgroundLabel.text = NSLocalizedString(AtributtesIDs.colorName, comment: "Movie Label")
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ConfigScreenViewController: UIPickerViewDelegate {
    
}

extension ConfigScreenViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colorsData.colorsName.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colorsData.colorsName[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        delegate?.changeColor(color: colorsData.colorsName[row])
        defaults.set(row, forKey: "UserRow")
        view.backgroundColor = Colors.colors[colorsData.colorsName[row]]
    }
}

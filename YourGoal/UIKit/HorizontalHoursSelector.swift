//
//  HorizontalScrollView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 02/10/2020.
//

import SwiftUI

class PickerRowView: UIView {

    var label: UILabel

    init(frame: CGRect, control: HorizontalPickerView, row: Int, isSelected: Bool) {
        label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: control.size.width - 0.1, height: control.size.height)
        label.textAlignment = .center
        label.textColor = .white

        super.init(frame: frame)

        updateLabelFont(isSelected: isSelected, text: "\(control.hours[row])")
        self.addSubview(label)
    }

    func updateLabelFont(isSelected: Bool, text: String) {
        var font: UIFont
        if isSelected {
            font = UIFont.systemFont(ofSize: 18, weight: .bold)
        } else {
            font = UIFont.systemFont(ofSize: 18, weight: .regular)
        }

        let attributes: [NSAttributedString.Key: Any] = [
            .font: font
        ]

        label.attributedText = NSAttributedString(string: text, attributes: attributes)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

struct HorizontalPickerView: UIViewRepresentable {

    @Binding var selectedValue: String

    let hours = Array(0...23)
    let size: CGSize

    func makeUIView(context: Context) -> UIPickerView {
        let pickerView = UIPickerView()
        pickerView.delegate = context.coordinator
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.transform = CGAffineTransform(rotationAngle: -90 * (.pi / 180))
        return pickerView
    }

    func updateUIView(_ uiView: UIPickerView,
                      context: UIViewRepresentableContext<HorizontalPickerView>) {
        // Perform any update tasks if necessary
    }
    
    func makeCoordinator() -> Coordinator {
         Coordinator(self)
    }

    class Coordinator: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {

        var control: HorizontalPickerView

        init(_ control: HorizontalPickerView) {
            self.control = control
        }

        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return control.hours.count
        }

        func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return control.size.height
        }

        func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            return control.size.width - 10
        }

        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int,
                        forComponent component: Int, reusing view: UIView?) -> UIView {

            let view = PickerRowView(frame: CGRect(x: 0, y: 0, width: control.size.width, height: control.size.height),
                                     control: control, row: row, isSelected: false)
            view.transform = CGAffineTransform(rotationAngle: 90 * (.pi/180))

            return view
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            control.selectedValue = "\(control.hours[row])"

            if let rowView = pickerView.view(forRow: row, forComponent: component) as? PickerRowView {
                rowView.updateLabelFont(isSelected: pickerView.selectedRow(inComponent: component) == row,
                                        text: "\(control.hours[row])")
            }
        }

    }

}

//
//  MultipleTextFields.swift
//  textfield
//
//  Created by Inti Albuquerque on 29/05/21.
//

import SwiftUI

struct MultipleTextFieldsView: View {
    @ObservedObject var viewModel = MultipleTextFieldsViewModel()
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                UnderLineTextField(text: $viewModel.text1, isFoused: viewModel.text1IsFocused, placeholder: "First name", returnKeyType: .next, id: .one, didTapReturn: viewModel.didTapReturn(_:), wasTapped: viewModel.textFieldWasTapped(_:))
               
                UnderLineTextField(text: $viewModel.text2, isFoused: viewModel.text2IsFocused, placeholder: "Last name", returnKeyType: .next, id: .two, didTapReturn: viewModel.didTapReturn(_:), wasTapped: viewModel.textFieldWasTapped(_:))
                    
                UnderLineTextField(text: $viewModel.text3, isFoused: viewModel.text3IsFocused, placeholder: "Favorite food", returnKeyType: .next, id: .three, didTapReturn: viewModel.didTapReturn(_:), wasTapped: viewModel.textFieldWasTapped(_:))
                    
                UnderLineTextField(text: $viewModel.text4, isFoused: viewModel.text4IsFocused, placeholder: "Favorite animal", returnKeyType: .done, id: .four, didTapReturn: viewModel.didTapReturn(_:), wasTapped: viewModel.textFieldWasTapped(_:))
                    
            }
            .padding()
        }
        .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Done"), message: Text("You tapped done"), dismissButton: .default(Text("Ok")))
                }
    }
}

struct MultipleTextFields_Previews: PreviewProvider {
    static var previews: some View {
        MultipleTextFieldsView()
    }
}

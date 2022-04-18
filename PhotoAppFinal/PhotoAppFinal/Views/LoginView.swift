//
//  LoginView.swift
//  PhotoAppFinal
//
//  Created by A on 4/18/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var loginVM = LoginViewModel()
    @EnvironmentObject var authentication: Authentication
    var body: some View {
        VStack{
            Image("img")
            Text("Sign In")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding([.top,.bottom], 20)
        
//            Text("Email Address")
//                        .font(.headline)
//                        .fontWeight(.light)
//                        .foregroundColor(Color.black.opacity(0.75))
            TextField("Email Address", text: $loginVM.credentials.email)
                .keyboardType(.emailAddress)
//            Text("Password")
//                        .font(.headline)
//                        .fontWeight(.light)
//                        .foregroundColor(Color.black.opacity(0.75))
            SecureField("Password", text: $loginVM.credentials.password)
                    if loginVM.showProgressView {
                        ProgressView()
                    }
            Button("Log in") {
                    loginVM.login { success in
                        authentication.updateValidation(success: success)
                    }
                }
                .disabled(loginVM.loginDisabled)
                .padding(.bottom,20)
//                Button(action: {
//                }) {
//                    loginVM.login { succes in }
//                    Text("Sign In")
//                        .foregroundColor(.white)
//                        .frame(width: UIScreen.main.bounds.width - 120)
//                        .padding()
//                }.background(Color.green)
//                    .clipShape(Capsule())
//                    .padding(.top, 90)
                .onTapGesture {
                        UIApplication.shared.endEditing()
                    
        }
            Spacer()
        }
            .padding()
            .autocapitalization(.none)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disabled(loginVM.showProgressView)
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

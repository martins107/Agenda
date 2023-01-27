//
//  RegistersView.swift
//  Agenda
//
//  Created by Apps2T on 10/1/23.
//

import SwiftUI

struct RegisterView: View {
    
    @State var email: String = ""
    @State var pass: String = ""
    @State var shouldShowRegister: Bool = false
    
    @State private var shouldShowAlert: Bool = false
    
    @State var alertMsg: String = ""
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("Second-Bg")
                    .resizable()
                    .overlay(
                        Rectangle()
                            .foregroundColor(.black.opacity(0.65))
                    )
                    .ignoresSafeArea(.all)
                
                VStack{
                    Image("Second-logo")
                        .resizable()
                        .frame(width: 90, height: 90)
                        .padding(.top,45)
                        .padding(.bottom,40)
                    Text("REGISTER")
                        .foregroundColor(.white)
                        .frame(height: 80)
                        .font(.system(size: 30 ,weight: .heavy))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 100)
                    
                    
                    VStack(spacing: 15){
                        TextField("Email", text: $email)
                            .foregroundColor(.black)
                            .frame(height: 30)
                            .padding()
                            .background(.white)
                            .cornerRadius(5)
                            .font(.system(size: 30 ,weight: .medium))
                        SecureField("Password", text: $pass)
                            .foregroundColor(.black)
                            .frame(height: 30)
                            .padding()
                            .background(.white)
                            .cornerRadius(5)
                            .font(.system(size: 30 ,weight: .medium))
                    }
                    .padding(.horizontal,35)
                    
                    signUpButton
                    
                    Spacer()
                    
                        .padding(.horizontal,35)
                        .padding(.bottom, 200)
                    
                }
            }
        }
    }
    
    // MARK: - ACCESSORY VIEWS
    
    var signUpButton: some View {
        Button {
            if email.isEmpty || pass.isEmpty {
                shouldShowAlert = true
                alertMsg = "Field all the fields, please"
            }else{
                if pass.count < 8 {
                    shouldShowAlert = true
                    alertMsg = "Password is too short"
                }else {
                    register(email: email, pass: pass)
                }
            }
            
            
        } label: {
            Text("Sign Up")
                .foregroundColor(.white)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(5)
                .padding(.vertical, 50)
            
        }
        .padding(.horizontal,35)
        .alert("Register Error", isPresented: $shouldShowAlert, actions: {
            Button {
                
            } label: {
                Text("Ok")
            }
        }) {
            Text(alertMsg)
        }
    }
    // MARK: - Private Methods
    
    private func register(email: String, pass: String) {
        
        let url = "https://superapi.netlify.app/api/register"
    
        let dictionary: [String: Any] = [
            "user" : email,
            "pass" : pass
        ]
        
        NetworkHelper.shared.requestProvider(url: url, params: dictionary) { data, response, error in
            if let error = error {
                onError(error: error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse {
                
                if response.statusCode == 200 {                    
                    onSuccess()
                } else{
                    
                    onError(error: error?.localizedDescription ?? "Request Error")
                }
            }
        }
    }
    func onSuccess(){
        mode.wrappedValue.dismiss()
    }
    func onError(error : String){
        
    }
    
}

struct RegistersView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

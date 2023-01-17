//
//  LoginView.swift
//  Agenda
//
//  Created by Apps2T on 10/1/23.
//
import SwiftUI

struct LoginView: View {
    
    @State var email: String = ""
    @State var pass: String = ""
    @State var shouldShowRegister: Bool = false
    
    
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
                    Text("LOGIN")
                        .foregroundColor(.white)
                        .frame(height: 80)
                        .font(.system(size: 30 ,weight: .heavy))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 50)
                    
                    
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
                    
                    signInButton
                    
                    Spacer()
                    
                    VStack(spacing: 1){
                        Text("Need an account")
                            .foregroundColor(.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                        Button {
                            shouldShowRegister = true
                        } label: {
                            Text("Sign Up")
                                .foregroundColor(.white)
                                .frame(width:100, height: 60)
                                .frame(maxWidth: .infinity)
                                .background(Color.gray)
                                .cornerRadius(5)
                                .padding(.all, 10)
            
                        }.background(
                            NavigationLink(destination: RegisterView(), isActive: $shouldShowRegister) {
                                EmptyView()
                            }
                        )
                    }
                    .padding(.horizontal,35)
                    .padding(.bottom, 100)
                    
                }
            }
        }
    }
    
    // MARK: - ACCESSORY VIEWS
    
    var signInButton: some View {
        Button {
            if email.isEmpty || pass.isEmpty {
                print("Rellena los campos")
            }else{
                //Peticion y navegar
            }
        } label: {
            Text("Sign In")
                .foregroundColor(.white)
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(5)
                .padding(.vertical, 50)

        }
        .padding(.horizontal,35)
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

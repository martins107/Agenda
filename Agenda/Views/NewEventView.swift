//
//  NewEventView.swift
//  Agenda
//
//  Created by Apps2T on 20/1/23.
//

import SwiftUI

struct NewEventView: View {
    
    @State var name: String = ""
    @State var date = Date()
    @Binding var shouldShowNewEvent : Bool
    var completion: () -> () = {}
    
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
                    Text("NEW EVENT")
                        .foregroundColor(.white)
                        .frame(height: 80)
                        .font(.system(size: 30 ,weight: .heavy))
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 50)
                    
                    
                    VStack(spacing: 15){
                        TextField("Event name", text: $name)
                            .foregroundColor(.black)
                            .frame(height: 30)
                            .padding()
                            .background(.white)
                            .cornerRadius(5)
                            .font(.system(size: 30 ,weight: .medium))
                        DatePicker("Pick Event Date", selection: $date)
                                        .datePickerStyle(.automatic)
                                        .padding()
                                        .background(Color.white)
                                
                    }
                    .padding(.horizontal,15)
                                        
                    Spacer()
                                    
                    Button {
                        newEvent(name: name, date: date)
                    } label: {
                        Text("Create Event")
                            .foregroundColor(.white)
                            .frame(width:100, height: 60)
                            .frame(maxWidth: .infinity)
                            .background(Color.gray)
                            .cornerRadius(5)
                            .padding(.all, 10)
        
                    }
                    .padding(.bottom,50)
                    .padding(.horizontal,15)
                   
                    
                }
            }
        }
    }
    func newEvent(name: String, date: Date) {
        
        let dateConverted = Int(date.timeIntervalSince1970)
        
        //baseUrl + endpoint
        let url = "https://superapi.netlify.app/api/db/eventos"
        
        //params
        let dictionary: [String: Any] = [
            "name" : name,
            "date" : dateConverted
        ]
        
        // petición
        NetworkHelper.shared.requestProvider(url: url, params: dictionary) { data, response, error in
            if let error = error {
                onError(error: error.localizedDescription)
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 { // esto daria ok
                    onSuccess()
                } else { // esto daria error
                    onError(error: error?.localizedDescription ?? "Request Error")
                }
            }
        }
    }
    func onSuccess() {
        completion()
        shouldShowNewEvent = false
    }
    
    func onError(error: String) {
        print(error)
    }
    
}


struct NewEventView_Previews: PreviewProvider {
    static var previews: some View {
        NewEventView(shouldShowNewEvent: .constant(true))
    }
}

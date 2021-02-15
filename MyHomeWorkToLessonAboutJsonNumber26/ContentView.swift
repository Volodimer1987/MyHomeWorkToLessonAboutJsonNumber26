//
//  ContentView.swift
//  MyHomeWorkToLessonAboutJsonNumber26
//
//  Created by vladimir gennadievich on 15.02.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State var listOfHumansInfo:[JsonData] = []
    
    var body: some View {
        NavigationView {
            List(listOfHumansInfo) { human in
                NavigationLink(destination: MoreInfoAboutHuman(JsonHuman: human) ,label: {
                    UserCell(human: human)
                        
                })
                
            }
            .onAppear() {
                Api().getPost{ humans in
                    self.listOfHumansInfo = humans
                }
            }
            .navigationBarTitle("JsonHumans")
            
        }
    }
    
}

struct UserCell:View {
    
    var human:JsonData
    
    var body: some View {
        VStack(alignment:.leading) {
            Text("\(human.name)")
            Text("\(human.email)")
        }
    }
}


struct MoreInfoAboutHuman:View {
    var JsonHuman:JsonData
    var body: some View {
        VStack(spacing:20) {
            Text("\(JsonHuman.name)")
            Text("\(JsonHuman.username)")
            Text("\(JsonHuman.phone)")
            Text("\(JsonHuman.address.city)")
            Text("\(JsonHuman.address.street)")
            Text("\(JsonHuman.address.zipcode)")
        }
    }
}

struct JsonData:Codable,Identifiable {
    var id  = UUID()

    var idd:Int
    var name:String
    var username:String
    var email:String
    var address:Address
    var phone:String
    var website:String
    var company:Company
    
    enum CodingKeys: String, CodingKey {
        case idd = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
     }
}

struct Address:Codable {
    var street:String
    var suite:String
    var city:String
    var zipcode:String
    var geo:Geo
    
}
struct  Geo:Codable {
    var lat:String
    var lng:String
}

struct Company:Codable {
    var name:String
    var catchPhrase:String
    var bs:String
}


class Api {
    func getPost(complition: @escaping ([JsonData]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {print("No have this adrees");return}
        
        URLSession.shared.dataTask(with: url) { data,_,_ in
            guard let data = data else {print("Empty data");return}
            
            let humans = try!JSONDecoder().decode([JsonData].self, from: data)
            DispatchQueue.main.async {
                complition(humans)
            }
        }.resume()
    }
}















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

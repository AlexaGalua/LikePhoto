//
//  ContentView.swift
//  PhotoAppFinal
//
//  Created by A on 4/18/22.
//

import SwiftUI
import CoreData
import SDWebImageSwiftUI

struct ContentView: View {
    
    @State var selectedIndex = 0
    let tabBarImageNames = ["photo", "folder"]

    @State var expand = false
    @State var search = ""
    @ObservedObject var RandomImages = getData()
    @State var page = 1
    @State var isSearching = false
    
    var body: some View {
        VStack{
        ZStack {
            switch selectedIndex {
            case 0:
                VStack(spacing: 0){
                    HStack{
                        if !self.expand{
                        VStack(alignment: .leading) {
                            Text("Photos")
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                       .foregroundColor(.black)
                    }
                        Spacer(minLength: 0)
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .onTapGesture {
                                withAnimation{
                                    self.expand = true
                                }
                            }
                        if self.expand{
                            TextField("Search", text: self.$search)
                        if self.search != ""{
                        Button(action:{
                            self.RandomImages.Images.removeAll()
                            self.isSearching = true
                            self.page = 1
                            self.SearchData()
                        }) {
                            Text("Find")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                        Button(action: {
                            withAnimation{
                            self.expand = false
                            }
                            self.search = ""
                            if self.isSearching{
                                self.isSearching = false
                                self.RandomImages.Images.removeAll()
                                self.RandomImages.updateData()
                            }
                        }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 15, weight: .bold))
                                .foregroundColor(.black)
                        }
                        .padding(.leading,10)
                        }
                    }
                    .padding(.top,UIApplication.shared.windows.first?.safeAreaInsets.top)
                    .padding()
                    .background(Color.white)
                if self.RandomImages.Images.isEmpty{
                    Spacer()
                    if self.RandomImages.noresults{
                        Text("No Results Found")
                    }
                    else {
                        Indicator()
                    }
                    Spacer()
                }
                else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(spacing: 5){
                            ForEach(self.RandomImages.Images,id: \.self) { i in
                                HStack(spacing: 5) {
                                    ForEach(i) { j in
                                        AnimatedImage(url: URL(string: j.urls["thumb"]!))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: (UIScreen.main.bounds.width - 10) / 2, height: 200)
                                            .cornerRadius(5)
                                            .contextMenu {
                                                Button(action: {
                                                    SDWebImageDownloader()
                                                        .downloadImage(with: URL(string: j.urls["small"]!)) { (image, _, _, _) in
                                                           UIImageWriteToSavedPhotosAlbum (image!, nil, nil, nil)
                                                        }
                                                }) {
                                                    HStack{
                                                        Text("Save")
                                                        Spacer()
                                                        Image(systemName: "square.and.arrow.down.fill")
                                                    }
                                                    .foregroundColor(.black)
                                                }
                                            }
                                        }
                                    }
                                }
                                if !self.RandomImages.Images.isEmpty{
                                    if self.isSearching && self.search != " " {
                                        HStack{
                                            Text("Page \(self.page)")
                                        Spacer()
                                        Button(action: {
                                            self.RandomImages.Images.removeAll()
                                            self.page += 1
                                            self.SearchData()
                                        }) {
                                            Text("Next")
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                        }
                                    }
                                        .padding(.horizontal,25)
                                    }
                                    else{
                                        HStack{
                                        Spacer()
                                        Button(action: {
                                            self.RandomImages.Images.removeAll()
                                            self.RandomImages.updateData()
                                        }) {
                                            Text("Next")
                                                .fontWeight(.bold)
                                                .foregroundColor(.black)
                                        }
                                    }
                                        .padding(.horizontal,25)
                                    }
                                }
                                }.padding(.top)
                            }
                        }
                    }
                .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(.all))
                .edgesIgnoringSafeArea(.top)
                
            default:
                    Text("Galery")
                        .font(.title2)
                        .fontWeight(.bold)
                ImagePicker(sourceType: .photoLibrary)
                }
            }
        }
            Spacer()
            HStack{
            ForEach(0..<2) { num in
                Button(action: {
                    selectedIndex = num
                }, label: {
             
                Spacer()
                Image(systemName: tabBarImageNames[num])
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(selectedIndex == num ? Color(.label) :
                            .init(white: 0.8))
                Spacer()
                })
                }
            }
    }
    func SearchData(){
        let key = "bOQoPoZ9vJvmi4O80O1HzegbK0y00NGm0bPxjP0e4Kk"
        let query = self.search.replacingOccurrences(of: " ", with: "%20")
        let url = "https://api.unsplash.com/search/photos/?page=\(self.page)&query=\(query)&client_id=\(key)"

        self.RandomImages.SearchData(url: url)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
class getData : ObservableObject{
    @Published var Images : [[Photo]] = []
    @Published var noresults = false
   init() {
       updateData()
    }
   func updateData(){
        self.noresults = false
        let key = "bOQoPoZ9vJvmi4O80O1HzegbK0y00NGm0bPxjP0e4Kk"
        let url = "https://api.unsplash.com/photos/random/?count=30&client_id=\(key)"
        let session = URLSession(configuration: .default)
       session.dataTask(with: URL(string: url)!)  {  (data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            do {
                let json = try JSONDecoder().decode([Photo].self, from: data!)
                for i in stride(from: 0, to: json.count, by: 2){
                var ArrayData : [Photo] = []
                for j in i..<i+2{
                    if j < json.count{
                        
                        ArrayData.append(json[j])
                    }
                }
                DispatchQueue.main.async {
                    self.Images.append(ArrayData)
                    
                }
            }
            }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()

        }
    
    func SearchData(url: String){
        let session = URLSession(configuration: .default)
        session.dataTask(with: URL(string: url)!)  {  (data, _, err) in
            if err != nil{
                print((err?.localizedDescription)!)
                return
            }
            do {
                let json = try JSONDecoder().decode(SearchPhoto.self, from: data!)
                if json.results.isEmpty{
                    self.noresults = true
                }
                else{
                    self.noresults = false
                }
                for i in stride(from: 0, to: json.results.count, by: 2){
                var ArrayData : [Photo] = []
                for j in i..<i+2{
                    if j < json.results.count{
                        ArrayData.append(json.results[j])
                    }
                }
                DispatchQueue.main.async {
                    self.Images.append(ArrayData)
                    
                }
            }
        }
            catch{
                print(error.localizedDescription)
            }
        }
        .resume()
        }
    }

struct Photo : Identifiable, Decodable, Hashable {
    var id : String
    var urls : [String : String]
}

struct Indicator : UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: .large)
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    
    }
}

struct SearchPhoto : Decodable{
    var results : [Photo]
    
}

//
//  MainScreenView.swift
//  WeatherApp
//
//  Created by Carroll Katherine on 6/27/23.
//

import SwiftUI
import Foundation

// this is the main screen view that displays the search bar, pushes the search execution to the VM, and displays the navigation list 
struct MainScreenView: View {
    
    @State private var viewDidLoad = false
    @StateObject var viewModel = WeatherViewModel()
    @State private var didGetData = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            HStack{
                Image(systemName: "cloud.sun.bolt")
                    .font(.title)
                Text("Weather")
                    .font(.title)
            }
            TextField("Enter a City", text: $viewModel.textFieldValue)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 80, height: 30)
                    .foregroundColor(.blue)
                    .opacity(0.25)
                Button("Search") {
                    DispatchQueue.main.async {
                        viewModel.searchButtonSend {
                            viewModel.clearTextField()
                        }
                    }
                }
                .foregroundColor(.black)
            }
        }
        .onAppear {
            if viewDidLoad == false {
                viewDidLoad = true
                print("View Did Load")
            }
            viewModel.refreshAllWrapper()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        if !viewModel.locationSet.isEmpty {
            NavigationStack {
                List {
                    ForEach(Array(viewModel.locationSet), id: \.name) { location in
                        NavigationLink(destination: LocationDescriptionView(location: location)) {
                            LocationBlockView(location: location)
                        }
                        .frame(width: UIScreen.main.bounds.size.width, height: 75)
                    }
                    .onDelete { indexSet in
                        viewModel.removeLocations(atOffsets: indexSet)
                    }
                }
            }
            .refreshable {
                viewModel.refreshAllWrapper()
            }
            .onReceive(viewModel.$errorMessage) { message in
                if let message = message {
                    showAlert = true
                    alertMessage = message
                }
            }
        }
    }
}


// ASYNC CODE

//import SwiftUI
//import Foundation
//
//struct MainScreenView: View {
//
//    @State private var viewDidLoad = false
//    @StateObject var viewModel = WeatherViewModel()
//    @State private var didGetData = false
//
//    var body: some View {
//        VStack {
//            HStack{
//                Image(systemName: "cloud.sun.bolt")
//                    .font(.title)
//                Text("Weather")
//                    .font(.title)
//            }
//            TextField("Enter a City", text: $viewModel.textFieldValue)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//
//            ZStack {
//                RoundedRectangle(cornerRadius: 10)
//                    .frame(width: 80, height: 30)
//                    .foregroundColor(.blue)
//                    .opacity(0.25)
//                Button("Search") {
//                    Task{
//                        try await viewModel.send()
//                        viewModel.clearTextField()
//                    }
//                }
//                .foregroundColor(.black)
//            }
//        }
//        .onAppear {
//            if viewDidLoad == false {
//                viewDidLoad = true
//                print("View Did Load")
//            }
//            for location in viewModel.locationSet {
//                viewModel.refreshWrapper(locale: location.name)
//                viewModel.clearTextField()
//            }
//        }
//        if !viewModel.locationSet.isEmpty {
//            NavigationStack {
//                List {
//                    ForEach(viewModel.locationSet, id: \.name) { location in
//                        NavigationLink(destination: LocationDescriptionView(location: location)) {
//                            LocationBlockView(location: location)
//                        }
//                        .frame(width: UIScreen.main.bounds.size.width, height: 75)
//                    }
//                    .onDelete {
//                        indexSet in viewModel.locationSet.remove(atOffsets: indexSet)
//                    }
//                }
//            }
//            .refreshable { // less business logic in view, put as much in VM and then we can test it
//                Task { // do i need the task?
//                    for location in viewModel.locationSet { // move the for loop into the VM, make this a one line
//                        viewModel.refreshWrapper(locale: location.name)
//                        viewModel.clearTextField()
//                    }
//                }
//            }
//        }
//    }
//}


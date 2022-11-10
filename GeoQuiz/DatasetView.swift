//
//  DatasetView.swift
//  GeoQuiz
//
//  Created by Dennis Concepción Martín on 10/11/22.
//

import SwiftUI

struct DatasetView: View {
    let viewModel = ViewModel()
    
    var body: some View {
        List {
            Section {
                Text("Countries: \(viewModel.countries.count.formattedWithSeparator)")
                Text("Cities: \(viewModel.cities.count.formattedWithSeparator)")
            }
        }
        .navigationTitle("Dataset")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DatasetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            DatasetView()
        }
    }
}

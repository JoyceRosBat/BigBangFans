//
//  DetailsView.swift
//  BigBangFans
//
//  Created by Joyce Rosario Batista on 9/12/22.
//

import SwiftUI

struct DetailsView: View {
    enum FocusedField: Hashable {
        case notes
    }
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: DetailsViewModel
    @FocusState private var focusedField: FocusedField?
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack {
                    Spacer(minLength: 16)
                    
                    Image(viewModel.episode.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                    
                    Spacer(minLength: 32)
                    
                    VStack(alignment: .leading) {
                        
                        HStack {
                            Text("Season:")
                            Text("\(viewModel.episode.season)")
                        }
                        
                        Spacer(minLength: 16)
                        
                        Text("Title:")
                            .font(.headline)
                        Text("\(viewModel.episode.number) - \(viewModel.episode.name)")
                        
                        Spacer(minLength: 16)
                        Text("Summary:")
                            .font(.headline)
                        Text("\(viewModel.episode.summary)")
                    }
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rating:")
                        .font(.headline)
                    RatingView(rating: $viewModel.rating)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background {
                    Rectangle()
                        .fill(.black.opacity(0.1))
                        .cornerRadius(10)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notes:")
                        .font(.headline)
                    HStack(alignment: .top) {
                        Image(systemName: "book")
                        
                        TextField("Notes", text: $viewModel.notes, axis: .vertical)
                            .lineLimit(8, reservesSpace: true)
                            .textFieldStyle(.roundedBorder)
                            .focused($focusedField, equals: .notes)
                            .ignoresSafeArea(.keyboard)
                    }
                }
                .padding()
                .background {
                    Rectangle()
                        .fill(.black.opacity(0.1))
                        .cornerRadius(10)
                }
                .onChange(of: focusedField) { newValue in
                    proxy.scrollTo(newValue)
                }
                
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Episode \(viewModel.episode.number) - \(viewModel.episode.name)")
        .navigationBarTitleDisplayMode(.inline)
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    viewModel.save()
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(viewModel: DetailsViewModel(episode: .test))
    }
}

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var network: Network
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search by country name", text: $searchText)
                    .padding(.all, 20.0)
                
                List {
                    ForEach(searchResults) { country in
                        NavigationLink(destination: DetailsContentView(country: country, routeData: country.capitalInfo)) {
                            HStack {
                                AsyncImage(url: URL(string: country.flags.png)) { image in
                                    image
                                        .resizable()
                                        .scaledToFit()  // Ensures the full image fits within the frame
                                        .frame(width: 40, height: 40)  // Adjust the size to be smaller, if needed
                                        .cornerRadius(4)
                                } placeholder: {
                                    ProgressView()
                                        .frame(width: 40, height: 40)
                                }

                                VStack(alignment: .leading) {
                                    Text(country.name.official)
                                        .font(.headline)
                                        .lineLimit(1)  // Restrict to a single line with ellipsis if it’s too long
                                    Text(country.capital.first ?? "No Capital")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    Text("\(country.population)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(.leading, 8)

                                Spacer()  // Push the content to the left and fill the remaining space
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }
            }
        }
        .onAppear {
            network.getCountries()
        }
    }
    
    var searchResults: [Country] {
        if searchText.isEmpty {
            return network.countries
        } else {
            return network.countries.filter { country in
                country.name.official.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Network())
    }
}

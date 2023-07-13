# WeatherApp
This WeatherApp was my first app project that I primarily used to learn Swift, MVVM structure, and API calls.

The files are divided into the following: 
  A. Three views:
       1. MainScreenView: this is the starting screen as well as the navigation list display screen. It holds the text field and search button for the API call.
       2. LocationBlockView: this is the rectangle block that is created once a location is searched. The navigation list becomes a stack of LocationBlockViews, one for each searched and saved location's weather. These blocks also serve as a navigation link to the LocationDescriptionView for that location.
       3. LocationDescriptionView: this is a full screen view that presents a chunk of the weather data for the particular location of interest. 

 B. Two models (objects):
       1. Coordinates: this object stores the decoded json output from the Geocoder API. This API turns a location name into coordinates that are stored in a Coordinates object and these results then are used for the open weather API.
       2. Location: this object stores all the decoded json output data from the OpenWeather API.

 C. One ViewModel: my ViewModel handles all of the logic, adding Locations, removing Locations, doing API calls, etc. The code currently uses completion blocks and a dispatch queue, but there is commented code underneath that shows the process using async/await instead.

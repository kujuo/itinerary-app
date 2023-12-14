
# Journi

Journi is an app that aims to simplify the vacation planning process, from the moment someone thinks that they need a break to the moment they step foot on a sandy beach. 

## Sections
**Home View**


Home View can navigate to the "Current" itinerary as well as link to the quiz to make a new itinerary. This view is meant to be pretty minimal and act as a gateway to the other features.

**History View**


This view lets you navigate between the saved itineraries. At the top is the "Current" itinerary,followed by other saved itineraries, listed in order of last edit. Each itinerary links to the separate itinerary detail view, with events listed in order of days. From there, you can navigate to an event detail view where you can see information about the event as well as edit information about the event, or delete it. You can also add your personal notes to any event. Meal and travel events have a unique behavior on tapping into them - they have a popup menu where someone can either go into the detail view or go into the associated link in order to quickly access things like an associated Google maps link. 


**Itinerary Generation**
To create personalized itineraries, our process begins by identifying the ideal destination from our extensive database, tailored to your quiz results. Once a destination is selected, we curate a diverse array of events comprising three main categories: attractions, geographical highlights (referred to as 'geos'), and restaurants. The 'geos' category is particularly significant, as it includes nearby cities that serve as hubs for additional attractions and dining options.

Our algorithm will then thoughtfully selects two attractions and two restaurants each day, aligning them with your expressed preferences from the quiz. To ensure a seamless experience, we meticulously calculate the distances between events, utilizing the latitude and longitude coordinates of each location.

For a more in-depth interaction with your itinerary (like editing), you are encouraged to explore the 'History View' section. Here, you can not only view but also modify the details of each event. Furthermore, for detailed insights about any specific event, convenient links are provided beside the name of event, directing you to comprehensive information sourced from TripAdvisor.  

It's important to highlight that, currently, the integration of preferences for food and activities into our itinerary planning is not fully operational due to certain API limitations. This aspect represents a key area for potential enhancement. 
# IOSFinalProject

PageTurner is an IOS e-reader app that gives users access to public domain books using Project Gutenberg.
Users can search the catalog be either title or author, and download those books to read offline.
The app supports chapter navigation, bookmarking, and some customization including font, font size, line spacing
and themes. Reading is automatically saved so users will be able to continue reading where they left off.

Additional Features:
An API was integrated connecting to the Gutenberg REST API to fetch book metadata, cover images, and the plain texts. I used URLSession with async/await to handle search queries and book text downloads. Also implemented a chapter parser that uses regex to split the raw plain text into chapters.

I built a PersistenceService using UserDefaults and JSON encoder and decoder to persist the user's library, bookmakrs, settings, search history, and reading progress. The reading position is saved by using the chapter index whenever the user leaves the app.

I Implemented a search bar using .searchable() to query the Gutenberg API by title or author. Recent searches are saved and displayed when the search bar is active

I added a few animations throughout the app. A progress ring that fills in the library, a sliding controls bar, and a reading progress bar at the top of the reader.

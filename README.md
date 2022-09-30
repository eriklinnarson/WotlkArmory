<p align="center">
  <a><img align="right" src="https://user-images.githubusercontent.com/47529938/193354016-7ed0fbcd-88d1-4edf-a563-69bf429a993f.mp4" width="300"></a>
</p>

# World of Warcraft Classic - Character Search App for iOS in SwiftUI
This is a simple app I put together to become more familiar with API calls in SwiftUI. The user can search for in-game player-made characters, and then inspect the character's equipped items.

## API
There is no official API to fetch player characters from the classic version of World of Warcraft. Therefore I reverse engineered some API calls from the website <a href="https://ironforge.pro">Ironforge.pro</a>. The app uses three API calls from this website:

* Fetching a list of characters based on a search string
* Fetching more detailed information about a character
* Fetching item icons, which is simply done using ```AsyncImage```


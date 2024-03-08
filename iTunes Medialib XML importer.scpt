-- Selecting a plist or xml file
-- Выбор файла plist или xml1234
set xmlFilePath to (choose file with prompt "Select the XML file exported from the old Music library (usually Library.xml)" of type {"plist", "xml"})
-- set xmlFilePath to (choose file with prompt "Выберите XML файл экспортированный из старой медиатеки Music (обычно Медиатека.xml)" of type {"plist", "xml"})

set xmlTracksList to {}
set xmlTracksListRef to a reference to xmlTracksList


tell application "System Events"
	tell property list file (POSIX path of xmlFilePath)
		tell contents
			set xmlTracks to value of property list item "Tracks"
			set xmlTracksRef to a reference to xmlTracks
		end tell
	end tell
end tell

tell application "Music"
	-- Separate counter for the number of processed tracks
	-- Отдельный счетчик количества обработанных треков
	set processedTracksCounter to 0
	
	-- Setting progressbar parameters for reading data from XML
	-- Установка параметров прогрессбара для считывания данных из XML
	set theXMLitemCount to length of xmlTracks
	tell me
		set progress total steps to theXMLitemCount
		set progress completed steps to 0
		set progress description to "Analysing XML items..."
		set progress additional description to "Preparing to analyse."
		set xmlTracksIter to 1
	end tell
	
	repeat with t in items of xmlTracksRef
		tell me
			set progress additional description to "Processing xml items " & xmlTracksIter & " of " & theXMLitemCount
		end tell
		set xmlTrackInfo to {name:(|Name| of t), album:(|Album| of t), artist:(|Artist| of t), trackNumber:("" as integer), playCount:(missing value), playDate:(missing value), skipCount:(missing value), skipDate:(missing value), lovedStatus:(missing value)}
		
		try
			if class of (|Track Number| of t) is integer then set trackNumber of xmlTrackInfo to (|Track Number| of t)
		end try
		try
			if class of (|Play Count| of t) is integer then set playCount of xmlTrackInfo to (|Play Count| of t)
		end try
		try
			if class of (|Play Date UTC| of t) is date then set playDate of xmlTrackInfo to |Play Date UTC| of t
		end try
		try
			if class of (|Skip Count| of t) is integer then set skipCount of xmlTrackInfo to |Skip Count| of t
		end try
		try
			if class of (|Skip Date| of t) is date then set skipDate of xmlTrackInfo to |Skip Date| of t
		end try
		try
			if class of (|Loved| of t) is boolean then set lovedStatus of xmlTrackInfo to |Loved| of t
			
		end try
		set end of xmlTracksListRef to xmlTrackInfo
		tell me
			set progress completed steps to xmlTracksIter
			set xmlTracksIter to xmlTracksIter + 1
		end tell
	end repeat
	
	-- Finding and setting values for each track in the array
	-- Поиск и установка значений для каждого трека в массиве
	set libraryTracks to tracks
	set libraryTracksRef to a reference to libraryTracks
	
	-- Setting progressbar parameters to display the number of processed tracks
	-- Установка параметров прогрессбара для отображения количества обработанных треков
	set theTracksCount to length of libraryTracks
	tell me
		set progress total steps to theTracksCount
		set progress completed steps to 0
		set progress description to "Updating tracks info..."
		set progress additional description to "Preparing to process."
		set libraryTracksIter to 1
	end tell
	
	
	repeat with iTracks in libraryTracksRef
		tell me
			set progress additional description to "Processing track " & libraryTracksIter & " of " & theTracksCount
		end tell
		set libTrack to track number of iTracks
		set libName to name of iTracks
		set libAlbum to album of iTracks
		set libArtist to artist of iTracks
		
		repeat with t in xmlTracksListRef
			set xmlTrackNumber to the trackNumber of t
			set xmlTrackName to the name of t
			set xmlAlbumName to the album of t
			set xmlArtistName to the artist of t
			
			set xmlPlayCount to playCount of t
			set xmlPlayDate to playDate of t
			set xmlSkipCount to skipCount of t
			set xmlSkipDate to skipDate of t
			set xmlLoved to lovedStatus of t
			
			if xmlTrackNumber is equal to libTrack and ¬
				xmlTrackName is equal to libName and ¬
				xmlAlbumName is equal to libAlbum and ¬
				xmlArtistName is equal to libArtist then
				if xmlPlayCount is not missing value then set played count of iTracks to xmlPlayCount
				if xmlPlayDate is not missing value then set played date of iTracks to xmlPlayDate
				if xmlSkipCount is not missing value then set skipped count of iTracks to xmlSkipCount
				if xmlSkipDate is not missing value then set skipped date of iTracks to xmlSkipDate
				if xmlLoved is not missing value then
					if xmlLoved is true then
						set loved of iTracks to xmlLoved
					else if xmlLoved is false then
						set disliked of iTracks to true
					end if
				end if
				set processedTracksCounter to processedTracksCounter + 1
				exit repeat
			end if
		end repeat
		tell me
			set progress completed steps to libraryTracksIter
			set libraryTracksIter to libraryTracksIter + 1
		end tell
	end repeat
	
	-- Output of results (just for information)
	-- Вывод результатов (просто для информации)
	display dialog "Moved information for " & processedTracksCounter & " matched tracks"
	-- display dialog "Перенесена информация для " & processedTracksCounter & " совпавших треков"
	
end tell

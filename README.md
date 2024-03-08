# iTunes-Medialib-XML-importer

EN

A script written in AppleScript that allows you to transfer some parameters (likes/dislikes, play count, date of last play, skip count, date of last skip) from an xml file imported from the old library to a new one created from the same tracks. The script compares tracks using 4 fields: <key>Track Number</key>, <key>Name</key>, <key>Artist</key>, <key>Album</key>. If there are tracks in your library that have all of these 4 fields matching (including the absence of any of these fields), the transfer may not be completed correctly, be careful!

It is useful for cases when the old media library has accumulated a lot of errors, and it makes sense to recreate it, but it is a pity to lose information about the number of plays of different tracks.

The script uses only built-in tools in macOS.

To start, just open the file in the Script Editor application, click Play (▶️), and select the xml file exported from the old media library. The Music application must be open before starting the process. It should already have a new media library loaded.

To more clearly see the progress before running the script, click “Show log” at the bottom left of the window (⌘ 3). The process will take a few minutes depending on the number of tracks.

The script searches for track files that match by Track Number, Title, Album and Artist, and if all four fields match, it transfers likes, play count, date of last play, skip count, date of last skip to the tracks in the new library.

The script can be easily modified to suit your needs, for example, to transfer other values. Keep in mind that some values (such as date added, date modified, etc.) are read-only, and there is no standard ability to change this without changing the system time. You can find out more by opening the dictionary in the Script Editor (Shift ⌘ O), selecting the Music application, and in the opened directory go to the Music Suite → file track section. Read-only values are marked as r/o.


RU

Скрипт написаный на AppleScript позволяющий перенести некоторые параметры (лайки/дизлайки, количество воспроизведений, дату последнего воспроизведения, количество пропусков, дату последнего пропуска) из xml файла импортированного из старой медиатеки, в новую, созданную из тех же треков. Скрипт сравнивает треки по 4-м полям: <key>Track Number</key>, <key>Name</key>, <key>Artist</key>, <key>Album</key>. Если в вашей медиатеке есть треки у которых совпадают все эти 4 поля (в т.ч. и отсутствие любого из этих полей) - перенос может быть выполнен некорректно, будьте внимательны!

Пригодится для случаев, когда старая медиатека накопила много ошибок, и есть смысл ее пересоздать, но жаль терять информацию о количестве воспроизведения разных треков.

Для работы скрипта используются только встроенные средства в macOS. 

Для запуска достаточно открыть файл в приложении Редактор скриптов, нажать Play (▶️), и выбрать xml файл экспортированный из старой медиатеки. Приложение Музыка должно быть открыто перед началом процесса. В нем уже должна быть загружена новая медиатека.

Чтобы нагляднее видеть прогресс до запуска скрипта нажмите "Показать журнал" слева внизу окна (⌘ 3). Процесс займет несколько минут в зависимости от количества треков.

Скрипт ищет файлы треки совпадающие по Номеру Трека, Названию, Альбому и Исполнителю, и при совпадении всех четырех полей переносит лайки, количество воспроизведений, дату последнего воспроизведения, количество пропусков, дату последнего пропуска в треки уже в новой медиатеке.

Скрипт можно без особых усилий доработать под свои нужды, например, для перенесения других значений. Имейте ввиду, что некоторые значения (как дата добавления, дата изменения и др.) доступны только для чтения, и штатной возможности это изменить, без изменения системного времени не предусмотрено. Подробнее можно узнать открыв словарь в Редакторе скриптов (Shift ⌘ O), выбрав приложение Музыка, а в открывшемся справочнике перейдя в раздел Music Suite → file track. Значения доступные только для чтения помечены там как r/o.


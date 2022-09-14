if GetLocale() ~= "ruRU" then return end

DBM_CORE_NEED_SUPPORT				= "Вы - программист или хороший переводчик? Если да, то нам нужна ваша помощь в локализации DBM на другие языки. Помогите нам, посетив |HDBM:forums|h|cff3588ffhttps://forum.uwow.biz/threads/aktualnyj-dbm-pod-uwow-biz.303812/|r.\nНашли баг или неправильный таймер? Вы считаете что какому-то модулю требуется дополнительное предупреждение, таймер или особенность?\nПосетите новые форумы DBM для обсуждений, сообщений об ошибках и запроса новых возможностей на " .. DBM_CORE_UPDATEREMINDER_URL .. "."
DBM_HOW_TO_USE_MOD					= "Добро пожаловать в DBM. Для доступа к настройкам наберите /dbm в чате. При желании, загрузите определенные зоны вручную для изменений специфических настроек для каждого босса. DBM пытается подстраиваться под вас на основе вашей специализации на момент первого запуска, но некоторые могут захотеть включить дополнительные опции."
--DBM_FORUMS_MESSAGE					= "Нашли баг или неправильный таймер? Вы считаете что какому-то модулю требуется дополнительное предупреждение, таймер или особенность?\nПосетите новые форумы DBM для обсуждений, сообщений об ошибках и запроса новых возможностей на |HDBM:forums|h|cff3588ffhttps://github.com/Aleksart163/DBM-for-Legion|r (вы можете нажать на ссылку, чтобы скопировать URL)"
DBM_SILENT_REMINDER					= "Напоминание: DBM все еще находится в беззвучном режиме."

DBM_CORE_LOAD_MOD_ERROR				= "Ошибка при загрузке босс модуля для %s: %s"
DBM_CORE_LOAD_MOD_SUCCESS			= "Загружен модуль для '%s'. Для дополнительных настроек введите /dbm или /dbm help в чате."
DBM_CORE_LOAD_MOD_COMBAT			= "Загрузка '%s' отложена до выхода из боя"
DBM_CORE_LOAD_GUI_ERROR				= "Не удалось загрузить GUI: %s"
DBM_CORE_LOAD_GUI_COMBAT			= "GUI не может быть изначально загружено в бою. GUI будет загружено после боя. После загрузки GUI вы сможете загружать его в бою."
DBM_CORE_BAD_LOAD					= "DBM не удалось полностью загрузить модуль для этого подземелья, т.к. вы находитесь в режиме боя. Как только вы выйдите из боя, пожалуйста сделайте /console reloadui как можно скорее."
DBM_CORE_LOAD_MOD_VER_MISMATCH		= "%s не может быть загружен потому что ваш DBM-Core не соответствует требованиям. Требуется обновленная версия."
DBM_CORE_LOAD_MOD_EXP_MISMATCH		= "%s не может быть загружен, потому что он предназначен для расширения WoW, которое в настоящее время недоступно. Когда новое расширение станет доступным, этот мод будет работать автоматически."
DBM_CORE_LOAD_MOD_DISABLED			= "%s установлен, но в настоящее время отключен. Этот мод не будет загружен, пока вы не включите его."
DBM_CORE_LOAD_MOD_DISABLED_PLURAL	= "%s установлены, но в настоящее время отключены. Эти моды не будут загружаться, пока вы не включите их."

DBM_CORE_UPDATEREMINDER_URL			= "https://github.com/Aleksart163/DBM-for-Uwow"

DBM_COPY_URL_DIALOG					= "Посетите наш сайт для обновления на последнюю версию\r\n(привет прошляпанному очку администрации Pandawow, а так же Kondibober, Jenrys и pelia, что предложили проект получше своего, для раскрытия моего таланта в области разработки аддонов)"

--Pre Patch 7.1 Notice
DBM_CORE_NO_RANGE_SOON				= "Внимание: радар будет недоступен в подземельях в патче 7.1"
--Post Patch 7.1
DBM_CORE_NO_RANGE					= "Радар не может быть использован в подземельях. Будет использоваться текстовое окно проверки дистанции"
DBM_CORE_NO_ARROW					= "Стрелка не можеть быть использована в подземельях"
DBM_CORE_ARROW_SUMMONED				= "Стрелка была активирована. Если вы не сделали это вручную, то для активации стрелки у вас настроен аддон стороннего производителя"
DBM_CORE_NO_HUD						= "HUDMap не можеть быть использована в подземельях"

DBM_CORE_DYNAMIC_DIFFICULTY_CLUMP	= "DBM отключил динамическое окно проверки дистанции на этом боссе, т.к. нет точной информации о необходимом количестве игроков в одном скоплении для рейда вашего размера."
DBM_CORE_DYNAMIC_ADD_COUNT			= "DBM отключил предупреждения о появлении помощников на этом боссе, т.к. нет точной информации о количестве помощников, которые появляются в рейде вашего размера."
DBM_CORE_DYNAMIC_MULTIPLE			= "DBM отключил несколько таймеров и предупреждений на этом боссе, т.к. нет точной информации о том, как работают механики энкаунтера для рейда вашего размера."

DBM_CORE_LOOT_SPEC_REMINDER			= "Ваша текущая специализация %s. Вы выбрали добычу для специализации %s."

DBM_CORE_BIGWIGS_ICON_CONFLICT		= "DBM обнаружил, что у вас включена установка меток в Bigwigs и DBM одновременно. Пожалуйста отключите метки в одном из них, чтобы избежать конфликта с лидером вашей группы"

DBM_CORE_MOD_AVAILABLE				= "Для этого контента доступен дополнительный модуль %s. Вы можете скачать его с |HDBM:forums|h|cff3588ffhttps://github.com/Aleksart163/DBM-for-Uwow|r. Это сообщение отображается один раз."

DBM_CORE_COMBAT_STARTED				= "%s вступает в бой. Удачи! :)"
DBM_CORE_COMBAT_STARTED_IN_PROGRESS	= "%s вступает в бой (в процессе). Удачи! :)"
DBM_CORE_GUILD_COMBAT_STARTED		= "Гильдия вступает в бой с %s"
DBM_CORE_SCENARIO_STARTED			= "%s начат. Удачи! :)"
DBM_CORE_SCENARIO_STARTED_IN_PROGRESS	= "Вы зашли в сценарий %s (в процессе). Удачи! :)"
DBM_CORE_BOSS_DOWN					= "%s погибает спустя %s!"
DBM_CORE_BOSS_DOWN_I				= "%s погибает! Общее количество побед у Вас %d."
DBM_CORE_BOSS_DOWN_L				= "%s погибает спустя %s! Ваш последний бой длился %s, а лучший бой длился %s. Общее количество побед у Вас %d."
DBM_CORE_BOSS_DOWN_NR				= "%s погибает спустя %s! Это новый рекорд! (Предыдущий рекорд был %s). Общее количество побед у Вас %d."
DBM_CORE_GUILD_BOSS_DOWN			= "Гильдия победила %s спустя %s!"
DBM_CORE_SCENARIO_COMPLETE			= "%s завершен спустя %s!"
DBM_CORE_SCENARIO_COMPLETE_I		= "%s завершен! Общее количество прохождений у Вас %d."
DBM_CORE_SCENARIO_COMPLETE_L		= "%s завершен спустя %s! Ваше последнее прохождение заняло %s, а лучшее прохождение заняло %s. Общее количество прохождений у Вас %d."
DBM_CORE_SCENARIO_COMPLETE_NR		= "%s завершен спустя %s! Это новый рекорд! (Предыдущий рекорд был %s). Общее количество прохождений у Вас %d."
DBM_CORE_COMBAT_ENDED_AT			= "Бой с %s (%s) закончился спустя %s."
DBM_CORE_COMBAT_ENDED_AT_LONG		= "Бой с %s (%s) закончился спустя %s. На этом уровне сложности вы вайпнулись уже %d раз."
DBM_CORE_GUILD_COMBAT_ENDED_AT		= "Гильдия вайпнулась на %s (%s) спустя %s."
DBM_CORE_SCENARIO_ENDED_AT			= "%s закончился спустя %s."
DBM_CORE_SCENARIO_ENDED_AT_LONG		= "%s закончился спустя %s. На этом уровне сложности вы не завершили сценарий уже %d раз."
DBM_CORE_COMBAT_STATE_RECOVERED		= "%s был атакован %s назад, восстанавливаю таймеры..."
DBM_CORE_TRANSCRIPTOR_LOG_START		= "Логирование с помощью Transcriptor начато."
DBM_CORE_TRANSCRIPTOR_LOG_END		= "Логирование с помощью Transcriptor окончено."

DBM_CORE_MOVIE_SKIPPED				= "Ролик был автоматически пропущен."

DBM_CORE_AFK_WARNING				= "Вы АФК и находитесь в бою (осталось %d процентов здоровья), звуковое оповещение о бое. Если вы не АФК, снимите флаг АФК или отключите эту опцию в \"дополнительных возможностях\"."

DBM_CORE_COMBAT_STARTED_AI_TIMER	= "Мой процессор - это процессор нейронной сети; самообучающийся компьютер. (В этом бою будет использоваться новая функция ИИ таймера для генерации приближенных значений таймера)."
--
DBM_CORE_PROFILE_NOT_FOUND			= "<DBM> Ваш текущий профиль поврежден. DBM загрузит профиль 'По умолчанию'."
DBM_CORE_PROFILE_CREATED			= "Профиль '%s' создан."
DBM_CORE_PROFILE_CREATE_ERROR		= "Не удалось создать профиль. Некорректное имя профиля."
DBM_CORE_PROFILE_CREATE_ERROR_D		= "Не удалось создать профиль. Профиль '%s' уже существует."
DBM_CORE_PROFILE_APPLIED			= "Профиль '%s' применен."
DBM_CORE_PROFILE_APPLY_ERROR		= "Не удалось применить профиль. Профиль '%s' не существует."
DBM_CORE_PROFILE_COPIED				= "Профиль '%s' скопирован."
DBM_CORE_PROFILE_COPY_ERROR			= "Не удалось скопировать профиль. Профиль '%s' не существует."
DBM_CORE_PROFILE_COPY_ERROR_SELF	= "Невозможно скопировать профиль сам в себя."
DBM_CORE_PROFILE_DELETED			= "Профиль '%s' удален. Профиль 'По умолчанию' будет применен."
DBM_CORE_PROFILE_DELETE_ERROR		= "Не удалось удалить профиль. Профиль '%s' не существует."
DBM_CORE_PROFILE_CANNOT_DELETE		= "Невозможно удалить профиль 'По умолчанию'."
DBM_CORE_MPROFILE_COPY_SUCCESS		= "Настройки модуля от %s (специализация %d) были скопированы."
DBM_CORE_MPROFILE_COPY_SELF_ERROR	= "Невозможно скопировать настройки персонажа сами в себя."
DBM_CORE_MPROFILE_COPY_S_ERROR		= "Источник поврежден. Настройки не скопированы или скопированы частично. Скопировать не удалось."
DBM_CORE_MPROFILE_COPYS_SUCCESS		= "Звуковые настройки модуля от %s (специализация %d) были скопированы."
DBM_CORE_MPROFILE_COPYS_SELF_ERROR	= "Невозможно скопировать звуковые настройки персонажа сами в себя."
DBM_CORE_MPROFILE_COPYS_S_ERROR		= "Источник поврежден. Звуковые настройки не скопированы или скопированы частично. Скопировать не удалось."
DBM_CORE_MPROFILE_DELETE_SUCCESS	= "Настройки модуля от %s (специализация %d) были удалены."
DBM_CORE_MPROFILE_DELETE_SELF_ERROR	= "Невозможно удалить настройки модуля, используемого в данный момент."
DBM_CORE_MPROFILE_DELETE_S_ERROR	= "Источник поврежден. Настройки не удалены или удалены частично. Удалить не удалось."

DBM_CORE_NOTE_SHARE_SUCCESS			= "%s поделился своей заметкой для %s"
DBM_CORE_NOTE_SHARE_FAIL			= "%s попытался поделиться с вами заметкой для %s. Однако модуль, связанный с этой способностью не установлен или не загружен. Если вам нужна эта заметка, убедитесь что модуль, для которого они делятся заметкой загружен и попросите поделиться снова"

DBM_CORE_NOTEHEADER					= "Вставьте текст вашей заметки здесь. Поместив имя игрока между >< окрасит его в цвет класса. Для предупреждений с несколькими заметками, разделите заметки с помощью '/'"
DBM_CORE_NOTEFOOTER					= "Когда заметка обновлена, просто нажмите 'ОК' чтобы сохранить"
DBM_CORE_NOTESHAREDHEADER			= "%s поделился заметкой для %s. Если вы примите ее, она переопределит вашу текущую заметку"
DBM_CORE_NOTESHARED					= "Ваша заметка была отправлена группе"
DBM_CORE_NOTESHAREERRORSOLO			= "Одиноко? Вы не должны передавать заметки самому себе"
DBM_CORE_NOTESHAREERRORBLANK		= "Нельзя поделиться пустой заметкой"
DBM_CORE_NOTESHAREERRORGROUPFINDER	= "Нельзя поделиться заметкой на БГ, в поиске рейда или подземелья"
DBM_CORE_NOTESHAREERRORALREADYOPEN	= "Нельзя открыть ссылку заметки пока открыт редактор заметок, чтобы предотвратить потерю заметки, которую вы в данный момент редактируете"

DBM_CORE_ALLMOD_DEFAULT_LOADED		= "Настройки по умолчанию были загружены для всех модулей в этом подземелье."
DBM_CORE_ALLMOD_STATS_RESETED		= "Вся статистика модуля была сброшена."
DBM_CORE_MOD_DEFAULT_LOADED			= "Настройки по умолчанию для этого боя были загружены."

DBM_CORE_WORLDBOSS_ENGAGED			= "В вашем игровом мире возможно начался бой с %s (%s процентов здоровья, отправил %s)."
DBM_CORE_WORLDBOSS_DEFEATED			= "%s возможно был побежден в вашем игровом мире (отправил %s)."

DBM_CORE_TIMER_FORMAT_SECS			= "%.2f сек"
DBM_CORE_TIMER_FORMAT_MINS			= "%d мин"
DBM_CORE_TIMER_FORMAT				= "%d мин %.2f сек"

DBM_CORE_MIN						= "мин"
DBM_CORE_MIN_FMT					= "%d мин"
DBM_CORE_SEC						= "сек"
DBM_CORE_SEC_FMT					= "%s сек"

DBM_CORE_GENERIC_WARNING_OTHERS		= "и еще один"
DBM_CORE_GENERIC_WARNING_OTHERS2	= "и %d других"
DBM_CORE_GENERIC_WARNING_BERSERK	= "Берсерк через %s %s"
DBM_CORE_GENERIC_TIMER_BERSERK		= "Берсерк"
DBM_CORE_OPTION_TIMER_BERSERK		= "Отсчет времени до $spell:26662"
DBM_CORE_OPTION_TIMER_COMBAT		= "Отсчет времени до начала боя"
DBM_CORE_GENERIC_TIMER_COMBAT		= "Бой начинается"
DBM_CORE_OPTION_TIMER_DOOR_OPENING	= "Отсчет времени до открытия дверей"
DBM_CORE_GENERIC_TIMER_DOOR_OPENING	= "Открывание двери"
DBM_CORE_GENERIC_TIMER_ROLE_PLAY	= "Активировать ролевые игры или npc в 1 нажатие"
DBM_CORE_BAD						= "Плохой"

DBM_CORE_OPTION_CATEGORY_TIMERS			= "Индикаторы"
DBM_CORE_OPTION_CATEGORY_WARNINGS		= "Общие предупреждения"
DBM_CORE_OPTION_CATEGORY_WARNINGS_YOU	= "Персональные предупреждения"
DBM_CORE_OPTION_CATEGORY_WARNINGS_OTHER	= "Предупреждения для цели"
DBM_CORE_OPTION_CATEGORY_WARNINGS_ROLE	= "Предупреждения для роли"
DBM_CORE_OPTION_CATEGORY_SOUNDS			= "Звуки"
DBM_CORE_OPTION_CATEGORY_DROPDOWNS		= "Выпадающие окна"

DBM_CORE_AUTO_RESPONDED						= "Авто-ответ."
DBM_CORE_STATUS_WHISPER						= "%s: %s, %d/%d человек живые"
--Bosses
DBM_CORE_AUTO_RESPOND_WHISPER				= "%s сейчас занят, в бою против %s (%s, %d/%d человек живые)"
DBM_CORE_WHISPER_COMBAT_END_KILL			= "%s одержал победу над %s!"
DBM_CORE_WHISPER_COMBAT_END_KILL_STATS		= "%s одержал победу над %s! Общее количество побед у них - %d."
DBM_CORE_WHISPER_COMBAT_END_WIPE_AT			= "%s потерпел поражение от %s на %s"
DBM_CORE_WHISPER_COMBAT_END_WIPE_STATS_AT	= "%s потерпел поражение от %s на %s. Общее количество вайпов у них - %d."
--Scenarios (no percents. words like "fighting" or "wipe" changed to better fit scenarios)
DBM_CORE_AUTO_RESPOND_WHISPER_SCENARIO		= "%s сейчас занят в %s (%d/%d человек живые)"
DBM_CORE_WHISPER_SCENARIO_END_KILL			= "%s завершил %s!"
DBM_CORE_WHISPER_SCENARIO_END_KILL_STATS	= "%s завершил %s! Общее количество побед у них - %d."
DBM_CORE_WHISPER_SCENARIO_END_WIPE			= "%s не завершил %s"
DBM_CORE_WHISPER_SCENARIO_END_WIPE_STATS	= "%s не завершил %s. Общее количество незавершенных у них - %d."

DBM_CORE_VERSIONCHECK_HEADER		= "Boss Masters - Версии"
DBM_CORE_VERSIONCHECK_ENTRY			= "%s: %s (%s)"
DBM_CORE_VERSIONCHECK_ENTRY_TWO		= "%s: %s (%s) & %s (%s)"--Two Boss mods
DBM_CORE_VERSIONCHECK_ENTRY_NO_DBM	= "%s: Boss Master не установлен"
DBM_CORE_VERSIONCHECK_FOOTER		= "Найдено %d |4игрок:игрока:игроков; с DBM и %d |4игрок:игрока:игроков; с Bigwigs"
DBM_CORE_VERSIONCHECK_OUTDATED		= "Следующие %d игрок(и) имеют устаревшую версию: %s"
DBM_CORE_YOUR_VERSION_OUTDATED      = "ВНИМАНИЕ! Ваша версия DBM устарела! Пожалуйста, посетите " .. DBM_CORE_UPDATEREMINDER_URL .. " для обновления на последнюю версию (rus and eng)."
DBM_CORE_VOICE_PACK_OUTDATED		= "В вашем голосовом пакете DBM отсутствуют звуки, поддерживаемые этой версией DBM. Фильтр звуков спец-предупреждений был отключен. Пожалуйста скачайте обновленную версию голосового пакета или свяжитесь с автором для обновления, которое содержит отсутствующие звуковые файлы."
DBM_CORE_VOICE_MISSING				= "Выбранный вами голосовой пакет DBM не найден. Ваш выбор был сброшен на 'None'. Если это ошибка, убедитесь что ваш голосовой пакет правильно установлен и включен в модификациях."
DBM_CORE_VOICE_DISABLED				= "У вас установлен по крайней мере один голосовой пакет DBM, но ни один не включен. Если вы собираетесь использовать голосовой пакет, убедитесь что он выбран в 'Звуковые оповещения', иначе удалите неиспользуемые голосовые пакеты чтобы скрыть это сообщение"
DBM_CORE_VOICE_COUNT_MISSING		= "Голос обратного отсчета %d настроен на голосовой пакет, который не может быть найден. Он должен быть сброшен до настроек по умолчанию."
DBM_BIG_WIGS						= "BigWigs"

DBM_CORE_UPDATEREMINDER_HEADER			= "Ваша версия Dungeon Boss Master устарела.\n Версия %s (r%d) доступна для загрузки здесь: " .. DBM_CORE_UPDATEREMINDER_URL .. "."
DBM_CORE_UPDATEREMINDER_HEADER_ALPHA	= "Ваша альфа версия Dungeon Boss Master устарела.\n Вы по крайней мере %d тестовых версий позади. Пользователям DBM рекомендуется использовать последнюю альфа или последнюю стабильную версию. Устаревшие альфы могут привести к плохой или неполной функциональности."
DBM_CORE_UPDATEREMINDER_FOOTER			= "Нажмите " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  ", чтобы скопировать ссылку загрузки в буфер обмена."
DBM_CORE_UPDATEREMINDER_FOOTER_GENERIC	= "Нажмите " .. (IsMacClient() and "Cmd-C" or "Ctrl-C")  ..  ", чтобы скопировать ссылку в буфер обмена."
DBM_CORE_UPDATEREMINDER_DISABLE			= "ПРЕДУПРЕЖДЕНИЕ: В связи с тем, что Ваш Dungeon Boss Master сильно устарел (%d ревизий), он был отключен до обновления. Это сделано для того, чтобы старый и несовместимый код не вызывал плохой игровой опыт для Вас и других членов рейда."
DBM_CORE_UPDATEREMINDER_DISABLE2		= "ПРЕДУПРЕЖДЕНИЕ: В связи с тем, что кто-то из рейда использует палёную версию аддона - ваша считается устаревшей и должна быть отключена насовсем. Но не беспокойтесь, т.к. эта версия является работой игрока Aleksart163 - аддон и дальше продолжит работу, но всё равно рекомендуется посетить " .. DBM_CORE_UPDATEREMINDER_URL .. " для обновления."
DBM_CORE_UPDATEREMINDER_HOTFIX			= "Ваша версия DBM будет иметь некорректные таймеры или предупреждения во время этого энкаунтера. Это исправлено в новой версии (или альфа-версии, если новая версия не доступна)"
DBM_CORE_UPDATEREMINDER_HOTFIX_ALPHA	= DBM_CORE_UPDATEREMINDER_HOTFIX--TEMP, FIX ME!
DBM_CORE_UPDATEREMINDER_MAJORPATCH		= "ПРЕДУПРЕЖДЕНИЕ: Из-за того, что ваш Dungeon Boss Master устарел, он был отключен до обновления, т.к. это большой игровой патч. Это необходимо для того, чтобы старый и несовместимый код не приводил к ухудшению игрового опыта для вас и членов вашего рейда. Убедитесь что вы скачали новую версию с " .. DBM_CORE_UPDATEREMINDER_URL .. " как только она станет доступна."
DBM_CORE_UPDATEREMINDER_TESTVERSION		= "ПРЕДУПРЕЖДЕНИЕ: Вы используете версию Dungeon Boss Master, не предназначенную для использования с данной версией игры. Пожалуйста, убедитесь, что вы загрузили подходящую версию для вашего игрового клиента с сайта " .. DBM_CORE_UPDATEREMINDER_URL .. "."
DBM_CORE_VEM							= "ПРЕДУПРЕЖДЕНИЕ: Вы используете Dungeon Boss Master и Voice Encounter Mods одновременно. DBM не был загружен, т.к. эти два аддона не могут работать вместе."
DBM_CORE_3RDPROFILES					= "ПРЕДУПРЕЖДЕНИЕ: DBM-Profiles не совместим с этой версией DBM. Он должен быть удален прежде чем DBM сможет продолжить, чтобы избежать конфликтов."
DBM_CORE_DPMCORE						= "ПРЕДУПРЕЖДЕНИЕ: Deadly PvP mods не совместимы с этой версией DBM. Чтобы продолжить, удалите их, чтобы избежать конфликтов."
DBM_CORE_UPDATE_REQUIRES_RELAUNCH		= "ПРЕДУПРЕЖДЕНИЕ: Это обновление DBM не будет работать корректно если вы не перезапустите игровой клиент. Это обновление содержит новые файлы или изменения в .toc файле, которые не могут быть загружены через ReloadUI. Вы можете столкнуться со сломанной функциональностью или ошибками если продолжите без перезапуска клиента."
DBM_CORE_OUT_OF_DATE_NAG				= "Ваша версия Dungeon Boss Master устарела и Вы выбрали опцию игнорировать всплывающее уведомление. Рекомендуется обновиться, чтобы не было отсутствующих важных предупреждений или таймеров, или крика от Вас, на который рассчитывает остальной рейд."

DBM_CORE_MOVABLE_BAR				= "Перетащите!"

DBM_PIZZA_SYNC_INFO					= "|Hplayer:%1$s|h[%1$s]|h транслирует DBM Timer: '%2$s'\n|HDBM:cancel:%2$s:nil|h|cff3588ff[Отменить этот DBM Timer]|r|h  |HDBM:ignore:%2$s:%1$s|h|cff3588ff[Игнорировать DBM Timer от %1$s]|r|h"
DBM_PIZZA_CONFIRM_IGNORE			= "Игнорировать DBM таймеры от %s на время текущего сеанса?"
DBM_PIZZA_ERROR_USAGE				= "Использование: /dbm [broadcast] timer <time> <text>. <time> должно быть больше 1."

DBM_CORE_MINIMAP_TOOLTIP_HEADER		= "Dungeon Boss Master" --"Deadly Boss Mods"
DBM_CORE_MINIMAP_TOOLTIP_FOOTER		= "Shift+щелчок или щелкните правой кнопкой мыши, чтобы переместить\nAlt+shift+щелчок для свободного перетаскивания"

DBM_CORE_RANGECHECK_HEADER			= "Проверка дистанции (%d м)"
DBM_CORE_RANGECHECK_SETRANGE		= "Настройка дистанции"
DBM_CORE_RANGECHECK_SETTHRESHOLD	= "Настройка порога игроков"
DBM_CORE_RANGECHECK_SOUNDS			= "Звуковой сигнал"
DBM_CORE_RANGECHECK_SOUND_OPTION_1	= "Один из игроков подошел к вам слишком близко"
DBM_CORE_RANGECHECK_SOUND_OPTION_2	= "Несколько человек находятся около вас"
DBM_CORE_RANGECHECK_SOUND_0			= "Без звука"
DBM_CORE_RANGECHECK_SOUND_1			= "По умолчанию"
DBM_CORE_RANGECHECK_SOUND_2			= "Раздражающий звуковой сигнал"
DBM_CORE_RANGECHECK_SETRANGE_TO		= "%d м"
DBM_CORE_RANGECHECK_OPTION_FRAMES	= "Фреймы"
DBM_CORE_RANGECHECK_OPTION_RADAR	= "Показывать радар"
DBM_CORE_RANGECHECK_OPTION_TEXT		= "Показывать текстовый фрейм"
DBM_CORE_RANGECHECK_OPTION_BOTH		= "Показывать оба фрейма"
DBM_CORE_RANGERADAR_HEADER			= "Радар (%d ярдов)"
DBM_CORE_RANGERADAR_IN_RANGE_TEXT	= "%d игроков в радиусе"
DBM_CORE_RANGERADAR_IN_RANGE_TEXTONE= "%s (%0.1fм)"--One target

DBM_CORE_INFOFRAME_SHOW_SELF		= "Всегда показывать вашу энергию" -- Always show your own power value even if you are below the threshold
DBM_CORE_INFOFRAME_SETLINES			= "Установите максимальное количество строк"
DBM_CORE_INFOFRAME_LINESDEFAULT		= "Установлено модом"
DBM_CORE_INFOFRAME_LINES_TO			= "%d строк"
DBM_CORE_INFOFRAME_POWER			= "Мощность"
DBM_CORE_INFOFRAME_MAIN				= "Основная:" --Main power
DBM_CORE_INFOFRAME_ALT				= "Альтер.:" --Alternate Power

DBM_LFG_INVITE						= "Приглашение в подземелье"
DBM_PHASE							= "%d-й этап"


DBM_CORE_SLASHCMD_HELP				= {
	"Доступные слэш команды:",
	"-----------------",
	"/dbm unlock: Отображает перемещаемый индикатор таймера (псевдоним: move).",
	"/range <число> or /distance <число>: Показать окно проверки дистанции. /rrange или /rdistance для обратных цветов.",
	"/hudar <число>: Проверка дистанции, использующая HUD.",
	"/dbm timer: Запускает пользовательский отсчет времени, для доп. информации введите '/dbm timer'.",
	"/dbm arrow: Показывает стрелку DBM, для доп. информации введите '/dbm arrow help'.",
	"/dbm hud: Показывает DBM HUD, для доп. информации введите '/dbm hud'.",
	"/dbm help2: Показывает команды управления рейдом"
}
DBM_CORE_SLASHCMD_HELP2				= {
	"Доступные слэш команды:",
	"-----------------",
	"/dbm pull <сек>: Транслирует отсчет времени до атаки всем членам рейда (требуются права лидера или помощника).",
	"/dbm break <мин>: Транслирует отсчет времени отдыха всем членам рейда (требуются права лидера или помощника).",
	"/dbm version: Выполняет проверку используемой рейдом версии (псевдоним: ver).",
	"/dbm version2: Выполняет проверку используемой рейдом версии и отправляет сообщение шепотом членам рейда с устаревшей версией (псевдоним: ver2).",
	"/dbm lockout: Получить список текущих сохранений подземелий у членов рейда (псведонимы: lockouts, ids) (требуются права лидера или помощника).",
	"/dbm lag: Выполняет проверку задержки у всего рейда.",
	"/dbm durability: Выполняет проверку прочности вещей всего рейда."
}
DBM_CORE_TIMER_USAGE	= {
	"Команды таймеров DBM:",
	"-----------------",
	"/dbm timer <сек> <текст>: Запускает таймер с указанным текстом.",
	"/dbm ctimer <сек> <текст>: Запускает таймер с текстом обратного отсчета.",
	"/dbm ltimer <сек> <текст>: Запускает таймер, который автоматически повторяется до отмены.",
	"/dbm cltimer <сек> <текст>: Запускает таймер с текстом обратного отсчета, который автоматически повторяется до отмены.",
	"Добавьте 'broadcast' перед типом таймера, чтобы поделиться им с рейдом (требуются права лидера или помощника).",
	"/dbm timer endloop: Останавливает любой повторяющийся ltimer или cltimer."
}

DBM_ERROR_NO_PERMISSION				= "У вас недостаточно прав для выполнения этой операции."

--Common Locals
DBM_NEXT							= "След. %s"
DBM_COOLDOWN						= "Восст. %s"
DBM_CORE_UNKNOWN					= "неизвестно"
DBM_CORE_LEFT						= "Налево"
DBM_CORE_RIGHT						= "Направо"
DBM_CORE_BACK						= "Назад"
DBM_CORE_SIDE						= "Сторона"
DBM_CORE_TOP						= "Сверху"
DBM_CORE_BOTTOM						= "Внизу"
DBM_CORE_MIDDLE						= "Центр"
DBM_CORE_FRONT						= "Вперед"
DBM_CORE_EAST						= "Восток"
DBM_CORE_WEST						= "Запад"
DBM_CORE_NORTH						= "Север"
DBM_CORE_SOUTH						= "Юг"
DBM_CORE_INTERMISSION				= "Переходная фаза"--No blizz global for this, and will probably be used in most end tier fights with intermission stages
DBM_CORE_ORB						= "Сфера"--FIXME
DBM_CHEST							= "сундука"--As in Treasure 'Chest'. Not Chest as in body part.
DBM_NO_DEBUFF						= "Нет %s"--For use in places like info frame where you put "Not Spellname"
DBM_ALLY							= "Союзник"--Such as "Move to Ally"
DBM_ADD								= "Треш"--A fight Add as in "boss spawned extra adds"
DBM_ADDS							= "Треш"
DBM_CORE_ROOM_EDGE					= "краю комнаты"
DBM_CORE_FAR_AWAY					= "Вдалеке"
DBM_CORE_BREAK_LOS					= "Перерыв LOS"
DBM_CORE_SAFE						= "Безопасность"
DBM_CORE_SHIELD						= "Щит"
DBM_CORE_SPHERE						= "Сферу"
DBM_CORE_TOTHEBOSS					= "Боссу"
DBM_INCOMING						= "%s прибывают"
--Common Locals end

DBM_CORE_BREAK_USAGE				= "Перерыв не может быть дольше 60 минут. Убедитесь что вы вводите время в минутах, а не секундах."
DBM_CORE_BREAK_START				= "Перерыв начинается -- у вас есть %s! (отправил %s)"
DBM_CORE_BREAK_MIN					= "Перерыв заканчивается через %s мин.!"
DBM_CORE_BREAK_SEC					= "Перерыв заканчивается через %s сек.!"
DBM_CORE_TIMER_BREAK				= "Перерыв!"
DBM_CORE_ANNOUNCE_BREAK_OVER		= "Перерыв закончился"

DBM_CORE_TIMER_PULL					= "Атака"
DBM_CORE_ANNOUNCE_PULL				= "Атака через %d сек. (отправил %s)"
DBM_CORE_ANNOUNCE_PULL_NOW			= "Атака!"
DBM_CORE_ANNOUNCE_PULL_TARGET		= "Атакуем %s через %d сек. (отправил %s)"
DBM_CORE_ANNOUNCE_PULL_NOW_TARGET	= "Атакуем %s!"
DBM_CORE_GEAR_WARNING				= "Внимание: Проверка экипировки. Уровень надетых предметов на %d ниже чем максимальный"
DBM_CORE_GEAR_WARNING_WEAPON		= "Внимание: Проверьте надето ли у вас корректное оружие."
DBM_CORE_GEAR_FISHING_POLE			= "Удочка"

DBM_CORE_ACHIEVEMENT_TIMER_SPEED_KILL = "Достижение"

-- Auto-generated Warning Localizations
DBM_CORE_AUTO_ANNOUNCE_TEXTS.you 			= "%s на тебе"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.target 		= "%s на |3-5(>%%s<)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetsource  	= ">%%s< применяет заклинание %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.targetcount	= "%s (%%s) на |3-5(>%%s<)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.spell 			= "%s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.ends			= "%s заканчивается"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.endtarget		= "%s заканчивается: >%%s<"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.fades			= "%s спадает"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.adds			= "Осталось %s: %%d"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.cast 			= "Применение заклинания %s: %.1f сек"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.soon 			= "Скоро %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prewarn 		= "%s через %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stage 			= "Фаза %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.prestage 		= "Скоро фаза %s"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.count 			= "%s (%%s)"
DBM_CORE_AUTO_ANNOUNCE_TEXTS.stack 			= "%s на |3-5(>%%s<) (%%d)"

local prewarnOption = "Предупреждать заранее о $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.you 			= "Объявлять когда $spell:%s на тебе"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.target 		= "Объявлять цели заклинания $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetsource	= "Объявлять источник использования заклинания $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.targetcount	= "Объявлять цели заклинания $spell:%s (со счетчиком)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.spell 		= "Предупреждение для $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.ends			= "Предупреждать об окончании $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.endtarget	= "Предупреждать об окончании $spell:%s (цель)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.fades		= "Предупреждать о спадении $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.adds			= "Объявлять сколько осталось $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.cast 		= "Предупреждать о применении заклинания $spell:%s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.soon 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prewarn 		= prewarnOption
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stage 		= "Объявлять фазу %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stagechange	= "Объявлять смены фаз"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.prestage 	= "Предупреждать заранее о фазе %s"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.count 		= "Предупреждение для $spell:%s (со счетчиком)"
DBM_CORE_AUTO_ANNOUNCE_OPTIONS.stack 		= "Объявлять количество стаков $spell:%s"

DBM_CORE_AUTO_SPEC_WARN_TEXTS.spell				= "%s!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ends				= "%s заканчивается"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.ready				= "%s готово"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.fades				= "%s спадает"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youfades			= "%s спадает c вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soon				= "Скоро %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.prewarn			= "%s через %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dispel 			= "%s на |3-5(>%%s<) - рассейте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt			= "%s - прервите каст!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interrupt2		= "%s - прервите каст контролем!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount	= "%s - прервите каст! (%%d)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.interruptcount2	= "%s! (%%s) - прервите каст"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.you 				= "%s на вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youcount			= "%s (%%s) на вас!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youpos			= "%s (%%s) на вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soak				= "%s! - перекройте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soakcount			= "%s (%%s) - перекройте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.soakpos			= "%s (Позиция погл.: %%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.target 			= "%s на |3-5(>%%s<)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targethelp 		= "%s на |3-5(>%%s<) - помогите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetdodge 		= "%s на |3-5(>%%s<) - избегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetsoak 		= "%s на |3-5(>%%s<) - перекройте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetrun 		= "%s на |3-5(>%%s<) - бегите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetint 		= "%s на |3-5(>%%s<) - прервите каст!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.targetcount		= "%s (%%s) на >%%s< "
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youdefensive 		= "%s на вас! - защититесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.defensive			= "%s! - защититесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.defensivecount 	= "%s! (%%s) - защититесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.taunt				= "%s на >%%s< - затаунти"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youclose			= "%s на >%%s< - поделите с ним урон"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.close 			= "%s на |3-5(>%%s<) около вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.closemoveaway		= "%s на >%%s< - отбегите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.move 				= "%s - отбегите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youmove 			= "%s под вами - отбегите"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dontmove 			= "%s! - не двигайтесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youdontmove 		= "%s под вами! - не двигайтесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dontstand 		= "%s! - не стойте на месте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youdontstand 		= "%s на вас! - не стойте на месте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodge				= "%s - избегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodgecount		= "%s (%%s) - избегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.dodgeloc			= "%s - уклоняйтесь от %%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youmoveaway 		= "%s на вас! - отбегите от других"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youmoveawaypos	= "%s (%%s) на вас"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveaway			= "%s - отбегите от других"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveboss			= "%s - бегите к боссу"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moveto			= "%s - бегите к >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youmovetopos		= "%s (%%s) на вас! - бегите к метке"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youshare			= "%s на вас! - поделите урон с другими"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.share				= "%s! - поделите урон"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.sharecount		= "%s! (%%s) - поделите урон"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.jump				= "%s - подпрыгните"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.run 				= "%s - убегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.yourun 			= "%s на вас! - убегайте"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.running			= "%s! - сбегитесь вместе"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.yourunning		= "%s на вас! - сбегитесь вместе"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.runningcount		= "%s! (%%s) - сбегитесь вместе"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.cast 				= "%s - прервите свой каст!"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.lookaway			= "%s! - отвернитесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youlookaway2		= "%s на вас! - отвернитесь от других"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youlook			= "%s на вас! - смотри на >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youfind			= "%s на вас! - верните свою душу"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.reflect 			= "%s на |3-5(>%%s<) - прекратите атаку"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.count 			= "%s! (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.stack 			= "На вас %%d стаков от %s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switch 			= "%s - переключитесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.switchcount 		= "%s - переключитесь (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.gtfo				= "%%s под тобой - отойди"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.Adds				= "Прибытие треша - переключитесь"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.Addscustom		= "Прибытие треша - %%s"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.icepud 			= "%s! (%%s) - беги в лужу льда"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.baitcondi			= "забайтить кондибобра прошляпить своё очко на %s (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.baitpel			= "забайтить пелию прошляпить своё очко на %s (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.baitmur			= "забайтить мурчаля прошляпить своё очко на %s (%%s)"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.moredamage		= "%s! - больше урону по боссу"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.youmoredamage		= "%s на вас! - дайте больше урона"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.paraxiscount		= "%s! - очередь (%%s) группы"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.standsand			= "%s - встаньте на песок"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.useitem			= "%s - используйте >%%s<"
DBM_CORE_AUTO_SPEC_WARN_TEXTS.keepdist			= "%s - держите дистанцию (%%s)м"

-- Auto-generated Special Warning Localizations
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.spell 			= "Спец-предупреждение для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ends 			= "Спец-предупреждение об окончании $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.ready 			= "Спец-предупреждение о готовности $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.fades 			= "Спец-предупреждение о спадении $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youfades 		= "Спец-предупреждение, когда с вас спадает $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soon 			= "Спец-предупреждение что скоро $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.prewarn 		= "Спец-предупреждение за %s сек. до $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dispel 			= "Спец-предупреждение для рассеивания/похищения заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt		= "Спец-предупреждение \"прервите каст\" для заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interrupt2		= "Спец-предупреждение \"прервите каст своим контролем\" для заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount	= "Спец-предупреждение (со счетчиком) \"прервите каст\" для заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.interruptcount2	= "Спец-предупреждение (со счетчиком) \"прервите каст\" для заклинания $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.you 			= "Спец-предупреждение, когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youcount		= "Спец-предупреждение (со счетчиком), когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youpos			= "Спец-предупреждение (с позицией) когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soak			= "Спец-предупреждение \"перекройте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soakcount		= "Спец-предупреждение (со счетчиком) \"перекройте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.soakpos			= "Спец-предупреждение (с позицией) для помощи с поглощением $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.target 			= "Спец-предупреждение, когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targethelp 		= "Спец-предупреждение (с именем) \"помогите\", когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetdodge 	= "Спец-предупреждение (с именем) \"избегайте\", когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetsoak	 	= "Спец-предупреждение (с именем) \"перекройте\", когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetrun	 	= "Спец-предупреждение (с именем) \"бегите\", когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetint	 	= "Спец-предупреждение (с именем) \"прервите каст\", когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.targetcount		= "Спец-предупреждение (со счетчиком), когда на ком-то $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youdefensive	= "Спец-предупреждение для использования защитных способностей, когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.defensive 		= "Спец-предупреждение для использования защитных способностей от $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.defensivecount 	= "Спец-предупреждение (со счетчиком) для использования защитных способностей от $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.taunt 			= "Спец-предупреждение \"затаунти\", когда на другом танке $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youclose		= "Спец-предупреждение \"поделите урон между собой\", когда на ком-то рядом с вами $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.close 			= "Спец-предупреждение, когда на ком-то рядом с вами $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.closemoveaway	= "Спец-предупреждение \"отбегите от союзника\", когда на ком-то рядом с вами $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.move 			= "Спец-предупреждение \"отбегите\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youmove			= "Спец-предупреждение \"отбегите\" когда под вами $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dontmove 		= "Спец-предупреждение \"не двигайтесь\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youdontmove 	= "Спец-предупреждение \"не двигайтесь\" когда под вами $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dontstand		= "Спец-предупреждение \"не стойте на месте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youdontstand 	= "Спец-предупреждение \"не стойте на месте\" когда вы цель $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodge 			= "Спец-предупреждение \"избегайте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodgecount		= "Спец-предупреждение (со счетчиком) \"избегайте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.dodgeloc 		= "Спец-предупреждение (с местоположением) \"избегайте\" для уклонения от $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youmoveaway		= "Спец-предупреждение \"отбегите от других\", когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youmoveawaypos	= "Спец-предупреждение \"отбегите от других\" (с позицией), когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveaway		= "Спец-предупреждение \"отбегите от других\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveboss		= "Спец-предупреждение \"бегите к боссу\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moveto			= "Спец-предупреждение \"бегите к кому-то\", на ком $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youmovetopos	= "Спец-предупреждение \"бегите к своей метке\" (с позицией), когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youshare		= "Спец-предупреждение \"поделите урон с другими\", когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.share			= "Спец-предупреждение \"поделите урон с другими\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.sharecount		= "Спец-предупреждение (со счетчиком) \"поделите урон с другими\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.jump			= "Спец-предупреждение \"подпрыгните\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.run 			= "Спец-предупреждение \"убегайте\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.yourun 			= "Спец-предупреждение \"убегайте\" когда вы цель $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.running			= "Спец-предупреждение \"сбегитесь вместе\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.yourunning		= "Спец-предупреждение \"сбегитесь вместе\" когда вы цель $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.runningcount	= "Спец-предупреждение (со счетчиком) \"сбегитесь вместе\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.cast 			= "Спец-предупреждение \"прервите свой каст\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.lookaway 		= "Спец-предупреждение \"отвернитесь\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youlookaway2 	= "Спец-предупреждение \"отвернитесь от других\" когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youlook			= "Спец-предупреждение \"смотрите на ...\" когда вы цель $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youfind			= "Спец-предупреждение \"верните свою духовную энергию\" когда вы цель $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.reflect 		= "Спец-предупреждение \"прекратите атаку\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.count 			= "Спец-предупреждение (со счетчиком) для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.stack 			= "Спец-предупреждение, когда на вас >=%d стаков $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switch			= "Спец-предупреждение о смене цели для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.switchcount 	= "Спец-предупреждение (со счетчиком) о смене цели для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.gtfo			= "Спец-предупреждение когда под вами всякие неприятные лужи"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.Adds			= "Спец-предупреждение о смене цели во время прибытия треша"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.Addscustom		= "Спец-предупреждение во время прибывания треша"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.icepud			= "Спец-предупреждение (со счетчиком) \"беги в лужу льда\" во время действия $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.baitpel			= "Спец-предупреждение \"прошляпай своё очко!\" для байта пелии во время действия $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.baitmur			= "Спец-предупреждение (с количеством раз) \"прошляпай своё очко!\" для того, чтобы узнать сколько Мурчаль прошляпил своё очко во время действия $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.moredamage		= "Спец-предупреждение \"больше урона по боссу\" когда на цели $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.youmoredamage	= "Спец-предупреждение \"дайте больше урона\" когда на вас $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.paraxiscount	= "Спец-предупреждение (со счетчиком) \"очередь ... группы\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.standsand		= "Спец-предупреждение \"встаньте на песок\" для $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.useitem 		= "Спец-предупреждение \"используйте\" на ком $spell:%s"
DBM_CORE_AUTO_SPEC_WARN_OPTIONS.keepdist 		= "Спец-предупреждение \"держите дистанцию N метров\" для $spell:%s"

-- Auto-generated Timer Localizations
DBM_CORE_AUTO_TIMER_TEXTS.target 		= "%s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cast 			= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.castsource	= "%s: %%s"
DBM_CORE_AUTO_TIMER_TEXTS.active		= "%s заканчивается" --Buff/Debuff/event on boss
DBM_CORE_AUTO_TIMER_TEXTS.fades			= "%s спадает" --Buff/Debuff on players
DBM_CORE_AUTO_TIMER_TEXTS.ai			= "%s ИИ"
DBM_CORE_AUTO_TIMER_TEXTS.cd 			= "Восст. %s"
DBM_CORE_AUTO_TIMER_TEXTS.cdcount		= "Восст. %s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.cdsource		= "Восст. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.cdspecial		= "Восст. спец-способности"
DBM_CORE_AUTO_TIMER_TEXTS.next 			= "След. %s"
DBM_CORE_AUTO_TIMER_TEXTS.nextcount		= "След. %s (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.nextsource	= "След. %s: >%%s<"
DBM_CORE_AUTO_TIMER_TEXTS.nextspecial	= "След. спец-способность"
DBM_CORE_AUTO_TIMER_TEXTS.achievement	= "%s"
DBM_CORE_AUTO_TIMER_TEXTS.stage			= "След. фаза"
DBM_CORE_AUTO_TIMER_TEXTS.adds			= "Прибытие аддов"
DBM_CORE_AUTO_TIMER_TEXTS.addscustom	= "Прибытие аддов (%%s)"
DBM_CORE_AUTO_TIMER_TEXTS.roleplay		= GUILD_INTEREST_RP

DBM_CORE_AUTO_TIMER_OPTIONS.target 		= "Отсчет времени действия дебаффа $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cast 		= "Отсчет времени применения заклинания $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.castsource	= "Отсчет времени применения заклинания (с источником) для $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.active 		= "Отсчет времени действия $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.fades		= "Отсчет времени до спадения $spell:%s с цели"
DBM_CORE_AUTO_TIMER_OPTIONS.ai			= "Отсчет времени до восстановления $spell:%s (ИИ)"
DBM_CORE_AUTO_TIMER_OPTIONS.cd 			= "Отсчет времени до восстановления $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdcount 	= "Отсчет времени до восстановления (со счетчиком) $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.cdsource	= "Отсчет времени до восстановления $spell:%s (с источником)"
DBM_CORE_AUTO_TIMER_OPTIONS.cdspecial	= "Отсчет времени до восстановления спец-способности"
DBM_CORE_AUTO_TIMER_OPTIONS.next 		= "Отсчет времени до следующего $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextcount 	= "Отсчет времени до следующего (со счетчиком) $spell:%s"
DBM_CORE_AUTO_TIMER_OPTIONS.nextsource	= "Отсчет времени до следующего $spell:%s (с источником)"
DBM_CORE_AUTO_TIMER_OPTIONS.nextspecial	= "Отсчет времени до следующей спец-способности"
DBM_CORE_AUTO_TIMER_OPTIONS.achievement = "Отсчет времени для %s"
DBM_CORE_AUTO_TIMER_OPTIONS.stage		= "Отсчет времени до следующей фазы"
DBM_CORE_AUTO_TIMER_OPTIONS.adds		= "Отсчет времени до прибытия аддов"
DBM_CORE_AUTO_TIMER_OPTIONS.addscustom	= "Отсчет времени до прибытия аддов"
DBM_CORE_AUTO_TIMER_OPTIONS.roleplay	= "Отсчет времени для ролевой игры"

DBM_CORE_AUTO_ICONS_OPTION_TEXT			= "Устанавливать метки на цели заклинания $spell:%s"
DBM_CORE_AUTO_ICONS_OPTION_TEXT2		= "Устанавливать метки на $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT			= "Показывать стрелку DBM к цели, на которой $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT2		= "Показывать стрелку DBM от цели, на которой $spell:%s"
DBM_CORE_AUTO_ARROW_OPTION_TEXT3		= "Показывать стрелку DBM к определенному месту для $spell:%s"
DBM_CORE_AUTO_VOICE_OPTION_TEXT			= "Звуковое оповещение для $spell:%s"
DBM_CORE_AUTO_VOICE2_OPTION_TEXT		= "Звуковое оповещение о сменах фаз"
DBM_CORE_AUTO_VOICE3_OPTION_TEXT		= "Звуковое оповещение для прибывающих аддов"
DBM_CORE_AUTO_VOICE4_OPTION_TEXT		= "Звуковое оповещение когда под вами всякие лужи"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT		= "Звуковой отсчет до восстановления $spell:%s"
DBM_CORE_AUTO_COUNTDOWN_OPTION_TEXT2	= "Звуковой отсчет до спадения $spell:%s"
DBM_CORE_AUTO_COUNTOUT_OPTION_TEXT		= "Звуковой отсчет во время действия $spell:%s"

DBM_CORE_AUTO_YELL_OPTION_TEXT.shortyell = "Кричать, когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.yell		= "Кричать (с именем игрока), когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.yellhelp	= "Кричать (с именем игрока и просьбой помощи), когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.count	= "Кричать (со счетчиком), когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.fade		= "Кричать (с обратный отсчетом и названием дебаффа), когда $spell:%s с вас спадает"
DBM_CORE_AUTO_YELL_OPTION_TEXT.shortfade = "Кричать (с обратным отсчетом), когда $spell:%s с вас спадает"
DBM_CORE_AUTO_YELL_OPTION_TEXT.iconfade = "Кричать (с обратным отсчетом и меткой), когда $spell:%s с вас спадает"
DBM_CORE_AUTO_YELL_OPTION_TEXT.position	= "Кричать (с меткой), когда на вас $spell:%s"
DBM_CORE_AUTO_YELL_OPTION_TEXT.combo	= "Кричать (с индивидуальным текстом), когда на вас одновременно воздействует $spell:%s и другие заклинания"

DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortyell = "%s"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yell	= "%s на " .. UnitName("player") .. "!"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.yellhelp = "%s на " .. UnitName("player") .. "! Помогите мне!"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.count	= "%s на " .. UnitName("player") .. "! (%%d)"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.fade	= "%s спадает через %%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.shortfade = "%%d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.iconfade = "{rt%%2$d}%%1$d"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.position = "%s %%s на {rt%%d}"..UnitName("player").."{rt%%d}"
DBM_CORE_AUTO_YELL_ANNOUNCE_TEXT.combo = "%s и %%s"--Spell name (from option, plus spellname given in arg)

--DBM_CORE_AUTO_YELL_CUSTOM_POSITION		= "{rt%d}%s{rt%d}"--Doesn't need translating. Has no strings
--DBM_CORE_AUTO_YELL_CUSTOM_POSITION2		= "{rt%d}{rt%d}%s{rt%d}{rt%d}"--Doesn't need translating. Has no strings
DBM_CORE_AUTO_YELL_CUSTOM_FADE			= "%s исчезает"
DBM_CORE_AUTO_HUD_OPTION_TEXT			= "Показывать HudMap для $spell:%s"
DBM_CORE_AUTO_HUD_OPTION_TEXT_MULTI		= "Показывать HudMap для различных механик"
DBM_CORE_AUTO_NAMEPLATE_OPTION_TEXT		= "Показывать таблички с иконками аур для $spell:%s"
DBM_CORE_AUTO_RANGE_OPTION_TEXT			= "Показывать окно проверки дистанции (%s м) для $spell:%s"--string used for range so we can use things like "5/2" as a value for that field
DBM_CORE_AUTO_RANGE_OPTION_TEXT_SHORT	= "Показывать окно проверки дистанции (%s м)"--For when a range frame is just used for more than one thing
DBM_CORE_AUTO_RRANGE_OPTION_TEXT		= "Показывать обратное окно проверки дистанции (%s) для $spell:%s"--Reverse range frame (green when players in range, red when not)
DBM_CORE_AUTO_RRANGE_OPTION_TEXT_SHORT	= "Показывать обратное окно проверки дистанции (%s)"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT	= "Информационное окно для $spell:%s"
DBM_CORE_AUTO_INFO_FRAME_OPTION_TEXT2	= "Показывать информационное окно для обзора боя"
DBM_CORE_AUTO_READY_CHECK_OPTION_TEXT	= "Проигрывать звук проверки готовности когда пулят босса (даже если он не является целью)"

-- New special warnings
DBM_CORE_MOVE_WARNING_BAR			= "Индикатор предупреждения"
DBM_CORE_MOVE_WARNING_MESSAGE		= "Спасибо за использование Dungeon Boss Master"
DBM_CORE_MOVE_SPECIAL_WARNING_BAR	= "Индикатор спец-предупреждения"
DBM_CORE_MOVE_SPECIAL_WARNING_TEXT	= "Специальное предупреждение"

DBM_CORE_HUD_INVALID_TYPE			= "Задан неверный тип HUD"
DBM_CORE_HUD_INVALID_TARGET			= "Не задана корректная цель для HUD"
DBM_CORE_HUD_INVALID_SELF			= "Нельзя использовать себя как цель для HUD"
DBM_CORE_HUD_INVALID_ICON			= "Тип icon не может быть использован на цели без метки"
DBM_CORE_HUD_SUCCESS				= "HUD запущен с вашими параметрами. Он будет отключен через %s, или с помощью '/dbm hud hide'."
DBM_CORE_HUD_USAGE	= {
	"Использование DBM-HudMap:",
	"-----------------",
	"/dbm hud <тип> <цель> <длительность> создает HUD который указывает на игрока в течение желаемой длительности",
	"Возможные типы: red, blue, green, yellow, icon (требуется цель с рейдовой меткой)",
	"Возможные цели: target, focus, <имя игрока>",
	"Длительность: любое число (в секундах). Если не задано, то используется 20 мин.",
	"/dbm hud hide  отключает и скрывает HUD"
}

DBM_ARROW_MOVABLE					= "Индикатор стрелки"
DBM_ARROW_WAY_USAGE					= "/dway <x> <y>: Создает стрелку, указывающую на определенное место (с использованием координат карты местной зоны)"
DBM_ARROW_WAY_SUCCESS				= "Чтобы скрыть стрелку, напишите команду \"dbm arrow hide\" или дотянитесь до неё"
DBM_ARROW_ERROR_USAGE	= {
	"Использование DBM-Arrow:",
	"-----------------",
	"/dbm arrow <x> <y>: создает стрелку, указывающую в определенную точку (используя координаты мира)",
	"/dbm arrow map <x> <y>  создает стрелку, указывающую в определенную точку (используя координаты зоны)",
	"/dbm arrow <player>: создает стрелку, указывающую на определенного игрока в вашей группе или рейде (регистрозависимо!)",
	"/dbm arrow hide: скрывает стрелку",
	"/dbm arrow move: разрешает перемещение стрелки"
}

DBM_SPEED_KILL_TIMER_TEXT	= "Рекордная победа"
DBM_SPEED_CLEAR_TIMER_TEXT	= "Лучшее прохождение"
DBM_COMBAT_RES_TIMER_TEXT	= "След. заряд БР"
DBM_CORE_TIMER_RESPAWN		= "Появление %s"


DBM_REQ_INSTANCE_ID_PERMISSION		= "%s запрашивает разрешение на просмотр ваших текущих сохранений подземелий.\nВы хотите предоставить %s такое право? Этот игрок получит возможность запрашивать эту информацию без уведомления в течение вашей текущей игровой сессии."
DBM_ERROR_NO_RAID					= "Вы должны состоять в рейдовой группе для использования этой функции."
DBM_INSTANCE_INFO_REQUESTED			= "Отослан запрос на просмотр текущих сохранений подземелий у членов рейда.\nОбратите внимание, что игроки будут уведомлены об этом и могут отклонить ваш запрос."
DBM_INSTANCE_INFO_STATUS_UPDATE		= "На запрос ответили %d игроков из %d пользователей DBM: %d послали данные, %d отклонили запрос. Ожидание ответа продлено на %d секунд..."
DBM_INSTANCE_INFO_ALL_RESPONSES		= "Получен ответ ото всех членов рейда"
DBM_INSTANCE_INFO_DETAIL_DEBUG		= "Игрок: %s ТипРезультата: %s Инстанс: %s ID: %s Сложность: %d Размер: %d Прогресс: %s"
DBM_INSTANCE_INFO_DETAIL_HEADER		= "%s, сложность %s:"
DBM_INSTANCE_INFO_DETAIL_INSTANCE	= "    ID %s, прогресс %d: %s"
DBM_INSTANCE_INFO_DETAIL_INSTANCE2	= "    прогресс %d: %s"
DBM_INSTANCE_INFO_NOLOCKOUT			= "Ваша рейдовая группа не имеет сохранений подземелий."
DBM_INSTANCE_INFO_STATS_DENIED		= "Отклонили запрос: %s"
DBM_INSTANCE_INFO_STATS_AWAY		= "Отошли от компьютера: %s"
DBM_INSTANCE_INFO_STATS_NO_RESPONSE	= "Установлена устаревшая версия DBM: %s"
DBM_INSTANCE_INFO_RESULTS			= "Результаты сканирования сохранений. Обратите внимание, что инстансы могут появляться более одного раза, если в вашем рейде есть игроки с локализованными клиентами WoW."
--DBM_INSTANCE_INFO_SHOW_RESULTS		= "Не все игроки ещё ответили: %s\n|HDBM:showRaidIdResults|h|cff3588ff[Показать текущие результаты]|r|h"
DBM_INSTANCE_INFO_SHOW_RESULTS		= "Не все игроки ещё ответили: %s"

DBM_CORE_LAG_CHECKING				= "Проверка задержки у рейда..."
DBM_CORE_LAG_HEADER					= "Dungeon Boss Master - Результаты проверки задержки"
DBM_CORE_LAG_ENTRY					= "%s: глобальная задержка [%d ms] / локальная задержка [%d ms]"
DBM_CORE_LAG_FOOTER					= "Нет ответа: %s"

DBM_CORE_DUR_CHECKING				= "Проверка прочности рейда..."
DBM_CORE_DUR_HEADER					= "Dungeon Boss Master - результаты прочности"
DBM_CORE_DUR_ENTRY					= "%s: прочность [%d процент] / сломано вещей [%s]"
DBM_CORE_LAG_FOOTER					= "Нет ответа: %s"

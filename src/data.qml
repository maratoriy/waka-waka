pragma Singleton
import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import Qt.labs.settings 1.1

Item {
    //глобал
    property string programName: "WakaWaka"
    property string programVersion: "beta 0.8"
    property bool   deckstopMode: platform===1
    //настройки
    property alias settings: _settings
    Settings {
        id: _settings
        fileName: "settings"
        property int theme: themes.lightTheme
        property int fontPointSize: 12
        property int visibility: 4
        property var lang: 'ru'
    }

    //темы
    property alias themes: _themes
    Item {
        id: _themes
        property int lightTheme: Material.Light
        property int darkTheme : Material.Dark
    }

    //стили виджетов
    property var styles: {
        'actions': {
            '0' : '#9C27B0',
            '1' : "#673AB7"
        },
        'toolButtons': {
            '0' : 'black',
            '1' : 'white'
        }
    }

    //список языков
    property var langList: [
        'ru', 'en'
    ]

    //список типовёё
    property var typeList: [
        "TextAnswer",
        "FixedNumber",
//        "FourVariants",
        "MultipleVariants",
        "TableAnswer"
    ]

    property var symbols: ["∞", "=", "≠", "~", "x", "÷", "!", "∝", "", "<", "≪", ">", "≫", "≤", "≥", "∓", "≅", "≈", "≡", "∀", "∁", "∂", "√", "∛", "∜", "∪", "∩", "∅", "%", "℉", "℃", "∆", "∇", "∃", "∄", "∈", "∋", "←", "↑", "→", "↓", "↔", "∴", "+", "-", "¬", "α", "β", "γ", "δ", "ε", "ϵ", "θ", "ϑ", "μ", "π", "ρ", "σ", "τ", "φ", "ω", "*", "∙", "⋮", "⋯", "⋰", "⋱", "ℵ", "ℶ", "∎", "ι", "κ", "ν", "ξ", "ο", "ϖ", "ϱ", "ς", "τ", "υ", "ϕ", "χ", "ψ", "∡", "♮", "⊥", "∥", "∦", "∟", "⇈", "∑", "∫", "∬", "∭", "↺", "↻", "↜", "↝", "⟹"]
    //пути
    property var urls: {
        'fonts': {
            'Roboto': {
                'light'  : "qrc:/fonts/roboto-slab/RobotoSlab-Light.ttf",
                'medium'  : "qrc:/fonts/roboto-slab/RobotoSlab-Medium.ttf"
            },
            'Electronica': {
                'normal': "qrc:/fonts/electronica/electronicaNormal.otf"
            }
        },

        'icons': {
            'add'        : "qrc:/images/icons/add.png",
            'help'       : "qrc:/images/icons/help.svg",
            'more'       : "qrc:/images/icons/more.svg",
            'moreV'      : "qrc:/images/icons/moreV.svg",
            'maxWin'     : "qrc:/images/icons/maxWin.svg",
            'minWin'     : "qrc:/images/icons/minWin.svg",
            'hide'       : "qrc:/images/icons/hide.svg",
            'close'      : "qrc:/images/icons/closeIcon.svg",
            'menu'       : "qrc:/images/icons/menu.svg",
            'backArrow'  : "qrc:/images/icons/backArrow.svg",
            'home'       : "qrc:/images/icons/home.png",
            'open'       : "qrc:/images/icons/open.png",
            'create'     : "qrc:/images/icons/create.png",
            'settings'   : "qrc:/images/icons/settings.png",
            'about'      : "qrc:/images/icons/about.png",
            'rightArrow' : "qrc:/images/icons/rightArrow.svg",
            'leftArrow' : "qrc:/images/icons/leftArrow.svg"
        }
    }

    property var names: {
        'en': {
            'homepage': {
                'title': 'Home',
                'welcome': "Hello, new user. You have just opened this app, and if this is your first time, you can read the instructions below. They will also be in the right menu, which you can open with a swipe or a question mark button at the top of the app window. WakaWaka is still under development, so please: describe all the problems and suggestions for contacts that are on the 'About' page. "
            },
            'createpage': {
                'title': 'Create',
                'main': {
                    'testname': 'Name of the test',
                    'password': 'Password',
                },
                'taskComponent': {
                    'question': 'Question',
                    'basicscore': 'Basic score',
                    'typeList': [ "TextAnswer (russian)", "FixedNumber", "MultipleVariants","TableAnswer"]
                },
                'buttons': {
                    'symbkeyboard': 'Open keyboard',
                    'delete': 'Delete',
                    'reset': 'Reset',
                    'add': 'Add',
                    'create': 'Create code',
                    'copy': 'Copy string'
                }
            },
            'testpage': {
                    'surnameplace': 'Surname',
                    'nameplace': 'Name',
                    'buttons': {
                        'endcreate': 'End test and create code with results',
                        'copy': 'Copy code'
                    }
            },
            'openpage': {
                'title': 'Open',
                'enterkeycomponent': {
                    'codeplace': 'Test\' code',
                    'buttons': {
                        'enter': 'Enter key'
                    }
                },
                'headercomponent': {
                    'infotext': 'Name of the test: %s\nTime to complete: %s\nNumber of questions: %s\nType: %s\n',
                    'buttons': {
                        'result': 'Result',
                        'test': 'Test',
                        'update': 'Update',
                    },
                    'passwordplace': 'Enter the test\'s passwrod',
                    'passworderror': 'Wrong password'
                }
            },
            'resultspage': {
                'headercomponent': {
                    'infotext': 'Name: %s\nPupil: %s\nTime: %s\nScore: %s\nBasicScore: %s\nPercentage: %s%'
                }
            },
            'navmenu': {
                'home': 'Home',
                'open': 'Open',
                'create': 'Create',
                'about': 'About'
            },
            'settings': {
                'fullscreen': 'Fullscreen',
                'darkmode': 'Dark mode',
                'lang': 'Language'
            },
            'tasks': {
                'TextAnswer': {
                    'create': {
                        'answerplace': 'Answer',
                        'prepbut': 'Create keywords',
                        'keyplace': 'Keywords'
                    },
                    'task': {
                        'answerplace': 'Answer'
                    }
                },
                'FixedNumber': {
                    'create': {
                        'decimalsplace': 'Decimals',
                        'inacplace': 'Inaccuracy (in %)',
                        'answerpace': 'Answer'
                    },
                    'task': {
                        'decimalplace': 'Decimals:  ',
                        'answerplace': 'Answer'
                    },
                    'result': {
                        'decimalsplace': 'Decimal place: ',
                        'inacplace': 'Inaccuracy (in %): ',
                        'answerplace': 'Answer: ',
                        'panswerplace': 'Pupil\' answer: '
                    }
                },
                'MultipleVariants': {
                    'create': {
                        'addvar': 'Add variant',
                        'var': 'Variant'
                    }
                },
                'TableAnswer': {
                    'create': {
                        'addnod': 'Add nod',
                        'nod': 'Nod'
                    },
                    'result': {
                        'pupil': 'Pupil',
                        'answer': 'Answer'
                    }
                }
            }
        },
        'ru': {
            'homepage': {
                'title': 'Главная',
                'welcome': "Привет, новый пользователь. Ты только что открыл это приложение, и если это впервые, то можешь ознакомиться с инструкциями ниже. Они также будут в правом меню, которое ты откроешь с помощью свайпа или значка вопроса в правой части шапки приложения. WakaWaka продолжает разрабатываться, поэтому, пожалуйста: опиши все проблемы/баги и предложения в контактах на странице 'О мне'"
            },
            'createpage': {
                'title': 'Создать',
                'main': {
                    'testname': 'Название теста',
                    'password': 'Пароль',
                },
                'taskComponent': {
                    'question': 'Вопрос',
                    'basicscore': 'Максимальный балл',
                    'typeList': [ 'Текст-ответ (русский)', 'Ответ-число с точностью', 'Несколько вариантов', 'Сопоставление (несколько к одному)'],
                },
                'buttons': {
                    'symbkeyboard': 'Открыть символы',
                    'delete': 'Удалить',
                    'reset': 'Очистить',
                    'add': 'Добавить',
                    'create': 'Создать строку-код',
                    'copy': 'Скопировать строку'
                }
            },
            'testpage': {
                    'surnameplace': 'Фамилия',
                    'nameplace': 'Имя',
                    'buttons': {

                        'endcreate': 'Закончить тест и создать код с результами',
                        'copy': 'Копировать код'
                    }
            },
            'resultspage': {
                'headercomponent': {
                    'infotext': 'Название: %s\nУченик: %s\nВремя: %s\nБалл: %s\nМаксимальный балл: %s\nВерно: ~%s%'
                }
            },
            'openpage': {
                'title': 'Open',
                'enterkeycomponent': {
                    'codeplace': 'Код теста',
                    'buttons': {
                        'enter': 'Ввести код'
                    }
                },
                'headercomponent': {
                    'infotext': 'Название теста: %s\nВремя для выполнения: %s\nКоличество вопросов: %s\nТип: %s\n',
                    'buttons': {
                        'result': 'Результат',
                        'test': 'Тест',
                        'update': 'Изменить',
                    },
                    'passwordplace': 'Введите пароль теста',
                    'passworderror': 'Неправильный пароль'
                }
            },
            'navmenu': {
                'home': 'Главная',
                'open': 'Открыть',
                'create': 'Создать',
                'about': 'О мне'
            },
            'settings': {
                'fullscreen': 'На полный экран',
                'darkmode': 'Темная тема',
                'lang': 'Язык'
            },
            'tasks': {
                'TextAnswer': {
                    'create': {
                        'answerplace': 'Ответ',
                        'prepbut': 'Создать маску',
                        'keyplace': 'Ключевые слова'
                    },
                    'task': {
                        'answerplace': 'Ответ'
                    }
                },
                'FixedNumber': {
                    'create': {
                        'decimalsplace': 'Количество знаков после запятой: ',
                        'inacplace': 'Погрешность (в %): ',
                        'answerplace': 'Ответ'
                    },
                    'task': {
                        'decimalplace': 'Количество знаков после запятой: ',
                        'answerplace': 'Ответ'
                    },
                    'result': {
                        'decimalsplace': 'Количество знаков после запятой: ',
                        'inacplace': 'Погрешность (в %): ',
                        'answerplace': 'Ответ: ',
                        'panswerplace': 'Ответ ученика: '
                    }
                },
                'MultipleVariants': {
                    'create': {
                        'addvar': 'Добавить вариант',
                        'var': 'Вариант'
                    }
                },
                'TableAnswer': {
                    'create': {
                        'addnod': 'Добавить узел',
                        'nod': 'Узел'
                    },
                    'result': {
                        'pupil': 'Ученик',
                        'answer': 'Ответ'
                    }
                }
            }
        }
    }

    property var helpModel: [
        {
            en: {
                name: "App's header",
                text: "App's header consists of: \n 1- Navigation menu button \n 2- Title label \n 3- Utility buttons \n   3.1- Hide window to taskbar \n   3.2- Min/max windoow \n   3.3- Close app \n   3.4- Help menu button \n   3.5- Settings menu button",
            },
            ru: {
                name: "Шапка приложения",
                text: "Шапка приложения: \n 1- Кнопка навигационного меню \n 2- Заголовок страницы \n 3- Кнопки изменения окна \n   3.1- Свернуть \n   3.2- Масштабирование \n   3.3- Закрыть \n   3.4- Кнопка меню помощи \n   3.5- Кнопка панели настроек"
            },
            image: {
                source: 'qrc:/images/help/window.png',
                width: 1
            }
        },
        {
            en: {
                name: "Navigation menu",
                text: "Navigation menu consists of: \n 1,2- Close menu elements \n 3- Pages' links \n   3.1- Home page with helping list \n   3.2- Open test to do/update/see results (requires code) \n   3.3- Create test \n   3.4- About app and its developer",
            },
            ru: {
                name: "Навигационное меню",
                text: "Навигационное меню: \n 1,2- Элементы закрытия окна \n 3- Список страниц \n   3.1- Главная страница с разделом помощи \n   3.2- Страница для открытия теста, чтобы выполнить/изменить/увидеть результаты (требуется код) \n   3.3- Создание теста \n   3.4- Об приложении и разработчике",
            },
            image: {
                source: 'qrc:/images/help/navmenu.png',
                width: 0.5
            }
        },
        {
            en: {
                name: "Create page - Main sets and tools",
                text: "Main sets of test constist of: \n 1- Name of the test \n 2- Time to complete test (timer) \n 3- Password for updating test (navigation menu->open->update) \n 4- Arrows to switch between tasks (left/right) \n 5- Page indicator (interactive) \n 6- Delete current task \n 7- Reset data in current element \n 8- Add task to end of the task list \n 9- Open keyboard with symbols (click the symbol=copy it)",
            },
            ru: {
                name: "Страница создания - основные настройки теста и инструменты",
                text: "Основные элементы настройки теста: \n 1- Поле названия теста \n 2- Время для выполнения (таймер) \n 3- Пароль для доступа к изменении теста \n 4- Стрелки для навигации (влево/вправо) \n 5- Счетчик страниц (интерактивный) \n 6- Удалить открытое задание \n 7- Сбросить данные в открытом задании \n 8- Добавить задание в конец \n 9- Открыть клавиатуру с специальными символами (нажать на символ, чтобы скопировать)",
            },
            image: {
                source: 'qrc:/images/help/createmain.png',
                width: 0.8
            }
        },
        {
            en: {
                name: "Create - "+names[settings.lang].createpage.taskComponent.typeList[0],
                text: "This type of task is intended for a text response and works on the principle of matching keywords (masks). The field with a mask was added primarily to remove unnecessary keywords, not to add new ones. Keywords are formed by removing endings from words, which makes it less dependent on strict typing of the word form in the response. The task is currently only available in Russian.\n\n Creation form:\n 1- Expanded response field\n 2- button to create a mask (click required)\n 3 - field with mask",
            },
            ru: {
                name: "Создание - "+names[settings.lang].createpage.taskComponent.typeList[0],
                text: "Этот тип задания предназначен для текстового ответа и работает по принципу совпадения по ключевым словам (маски). Поле с маской добавлено прежде всего для удаления ненужных ключевых слов, а не для добавления новых. Ключевые слова формируются путем удаления окончаний у слов, что позволяет меньше зависеть от строгой типизации формы слов в ответе. Задание работает пока только на русском языке.\n\nБланк создания:\n 1- Поле с ответом в развернутом виде\n 2- Кнопка для создания маски (нажать обязательно)\n 3- Поле с маской",
            },
            image: {
                source: 'qrc:/images/help/TextAnswer/create.png',
                width: 1
            }
        },
        {
            en: {
                name: "Create - "+names[settings.lang].createpage.taskComponent.typeList[1],
                text: "This type of task allows you to enter the answer as a number. There is a limit to the response to a certain decimal place and inaccuracy. Sliders 1 and 2 have a maximum value limit, but the numeric field next to the slider is also editable and without a value limiter.\n\nCreation form: \n 1 - Number of decimal places \n 2- Inaccuracy (in %) \n 3- \n 3.2- Answer \n 3.1, 3.3 - Answer interval with inaccurance",
            },
            ru: {
                name: "Создание - "+names[settings.lang].createpage.taskComponent.typeList[1],
                text: "Этот тип задания позволяет вводить ответ в виде числа. Предусмотрено ограничение ответа до определенного знака после запятой и погрешность. Ползунки 1 и 2 имею лимит максимального значения, но числовое поле рядом с ползунком также редактируемое и без ограничителя по значению.\n\nБланк создания: \n 1- Количество знаков после запятой \n 2- Погрешность (в %) \n 3- \n  3.2- Ответ \n 3.1,3.3- Отрезок ответа с учетом погрешности",
            },
            image: {
                source: 'qrc:/images/help/FixedNumber/create.png',
                width: 1
            }
        },
        {
            en: {
                name: "Create - "+names[settings.lang].createpage.taskComponent.typeList[2],
                text: "This type of task allows you to enter the answer by marking the options (the number of which is unlimited). Add option button 1 and the remove option button 3. \n Form includes: \n 1- Add option\n 2- Field of variant text\n 3- Mark right variant \n 4-Delete variant",
            },
            ru: {
                name: "Создание - "+names[settings.lang].createpage.taskComponent.typeList[2],
                text: "Этот тип задания позволяет вводить ответ, отмечая варианты (количество которых неограниченно). Добавить вариант можно кнопкой 1, а удалить вариант кнопкой 4. Выделить правильный ответ - кнопкой 3. \nФорма создания состоит из: \n 1- Кнопки добавления варианта\n 2- Поля варианта\n 2-Кнопка отметки правильного ответа\n 4- Кнопка удаления варианта",
            },
            image: {
                source: 'qrc:/images/help/MultipleVariants/create.png',
                width: 1
            }
        },

        {
            en: {
                name: "Create - "+names[settings.lang].createpage.taskComponent.typeList[3],
                text: "Этот тип задания позволяет сопоставлять варианты к конкретному узлу (к примеру сопоставить АБВГД с 1234567).\n\nФорма задания состоит из: \n 1-Добавить основной узел.\n 2-Поле основного узла\n 3- Поле субузла.\n 4-Добавить субузел\n 5-Удалить основной узел",
            },
            ru: {
                name: "Создание - "+names[settings.lang].createpage.taskComponent.typeList[3],
                text: "Этот тип задания позволяет сопоставлять варианты к конкретному узлу (к примеру сопоставить АБВГД с 1234567).\n\nФорма задания состоит из: \n 1-Добавить основной узел.\n 2-Поле основного узла\n 3- Поле субузла.\n 4-Добавить субузел\n 5-Удалить основной узел",
            },
            image: {
                source: 'qrc:/images/help/TableAnswer/create.png',
                width: 1
            }
        },


    ]
}

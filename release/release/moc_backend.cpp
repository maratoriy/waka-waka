/****************************************************************************
** Meta object code from reading C++ file 'backend.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.15.2)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include <memory>
#include "../../src/backend.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'backend.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.15.2. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
QT_WARNING_PUSH
QT_WARNING_DISABLE_DEPRECATED
struct qt_meta_stringdata_Backend_t {
    QByteArrayData data[7];
    char stringdata0[78];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Backend_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Backend_t qt_meta_stringdata_Backend = {
    {
QT_MOC_LITERAL(0, 0, 7), // "Backend"
QT_MOC_LITERAL(1, 8, 12), // "jsonToBase64"
QT_MOC_LITERAL(2, 21, 0), // ""
QT_MOC_LITERAL(3, 22, 12), // "base64ToJSON"
QT_MOC_LITERAL(4, 35, 15), // "prepareKeywords"
QT_MOC_LITERAL(5, 51, 14), // "compareStrings"
QT_MOC_LITERAL(6, 66, 11) // "imgToBase64"

    },
    "Backend\0jsonToBase64\0\0base64ToJSON\0"
    "prepareKeywords\0compareStrings\0"
    "imgToBase64"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Backend[] = {

 // content:
       8,       // revision
       0,       // classname
       0,    0, // classinfo
       5,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // methods: name, argc, parameters, tag, flags
       1,    1,   39,    2, 0x02 /* Public */,
       3,    1,   42,    2, 0x02 /* Public */,
       4,    1,   45,    2, 0x02 /* Public */,
       5,    2,   48,    2, 0x02 /* Public */,
       6,    1,   53,    2, 0x02 /* Public */,

 // methods: parameters
    QMetaType::QString, QMetaType::QString,    2,
    QMetaType::QString, QMetaType::QString,    2,
    QMetaType::QString, QMetaType::QString,    2,
    QMetaType::Float, QMetaType::QString, QMetaType::QString,    2,    2,
    QMetaType::QString, QMetaType::QString,    2,

       0        // eod
};

void Backend::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        auto *_t = static_cast<Backend *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: { QString _r = _t->jsonToBase64((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 1: { QString _r = _t->base64ToJSON((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 2: { QString _r = _t->prepareKeywords((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        case 3: { float _r = _t->compareStrings((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])));
            if (_a[0]) *reinterpret_cast< float*>(_a[0]) = std::move(_r); }  break;
        case 4: { QString _r = _t->imgToBase64((*reinterpret_cast< QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = std::move(_r); }  break;
        default: ;
        }
    }
}

QT_INIT_METAOBJECT const QMetaObject Backend::staticMetaObject = { {
    QMetaObject::SuperData::link<QObject::staticMetaObject>(),
    qt_meta_stringdata_Backend.data,
    qt_meta_data_Backend,
    qt_static_metacall,
    nullptr,
    nullptr
} };


const QMetaObject *Backend::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Backend::qt_metacast(const char *_clname)
{
    if (!_clname) return nullptr;
    if (!strcmp(_clname, qt_meta_stringdata_Backend.stringdata0))
        return static_cast<void*>(this);
    return QObject::qt_metacast(_clname);
}

int Backend::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 5)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 5;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 5)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 5;
    }
    return _id;
}
QT_WARNING_POP
QT_END_MOC_NAMESPACE

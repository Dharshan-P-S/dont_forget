// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AlarmsTable extends Alarms with TableInfo<$AlarmsTable, Alarm> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AlarmsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _originalDateMeta =
      const VerificationMeta('originalDate');
  @override
  late final GeneratedColumn<DateTime> originalDate = GeneratedColumn<DateTime>(
      'original_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _scheduledHourMeta =
      const VerificationMeta('scheduledHour');
  @override
  late final GeneratedColumn<int> scheduledHour = GeneratedColumn<int>(
      'scheduled_hour', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _scheduledMinuteMeta =
      const VerificationMeta('scheduledMinute');
  @override
  late final GeneratedColumn<int> scheduledMinute = GeneratedColumn<int>(
      'scheduled_minute', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<RecurrenceType, String>
      recurrenceType = GeneratedColumn<String>(
              'recurrence_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<RecurrenceType>($AlarmsTable.$converterrecurrenceType);
  @override
  late final GeneratedColumnWithTypeConverter<List<int>?, String>
      customWeekdays = GeneratedColumn<String>(
              'custom_weekdays', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<int>?>($AlarmsTable.$convertercustomWeekdaysn);
  @override
  late final GeneratedColumnWithTypeConverter<List<int>, String>
      preAlertOffsets = GeneratedColumn<String>(
              'pre_alert_offsets', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('[]'))
          .withConverter<List<int>>($AlarmsTable.$converterpreAlertOffsets);
  static const VerificationMeta _isEnabledMeta =
      const VerificationMeta('isEnabled');
  @override
  late final GeneratedColumn<bool> isEnabled = GeneratedColumn<bool>(
      'is_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_enabled" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _soundIdMeta =
      const VerificationMeta('soundId');
  @override
  late final GeneratedColumn<String> soundId = GeneratedColumn<String>(
      'sound_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('default'));
  static const VerificationMeta _snoozeDurationMeta =
      const VerificationMeta('snoozeDuration');
  @override
  late final GeneratedColumn<int> snoozeDuration = GeneratedColumn<int>(
      'snooze_duration', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(5));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        originalDate,
        scheduledHour,
        scheduledMinute,
        recurrenceType,
        customWeekdays,
        preAlertOffsets,
        isEnabled,
        soundId,
        snoozeDuration,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'alarms';
  @override
  VerificationContext validateIntegrity(Insertable<Alarm> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('original_date')) {
      context.handle(
          _originalDateMeta,
          originalDate.isAcceptableOrUnknown(
              data['original_date']!, _originalDateMeta));
    } else if (isInserting) {
      context.missing(_originalDateMeta);
    }
    if (data.containsKey('scheduled_hour')) {
      context.handle(
          _scheduledHourMeta,
          scheduledHour.isAcceptableOrUnknown(
              data['scheduled_hour']!, _scheduledHourMeta));
    } else if (isInserting) {
      context.missing(_scheduledHourMeta);
    }
    if (data.containsKey('scheduled_minute')) {
      context.handle(
          _scheduledMinuteMeta,
          scheduledMinute.isAcceptableOrUnknown(
              data['scheduled_minute']!, _scheduledMinuteMeta));
    } else if (isInserting) {
      context.missing(_scheduledMinuteMeta);
    }
    if (data.containsKey('is_enabled')) {
      context.handle(_isEnabledMeta,
          isEnabled.isAcceptableOrUnknown(data['is_enabled']!, _isEnabledMeta));
    }
    if (data.containsKey('sound_id')) {
      context.handle(_soundIdMeta,
          soundId.isAcceptableOrUnknown(data['sound_id']!, _soundIdMeta));
    }
    if (data.containsKey('snooze_duration')) {
      context.handle(
          _snoozeDurationMeta,
          snoozeDuration.isAcceptableOrUnknown(
              data['snooze_duration']!, _snoozeDurationMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Alarm map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Alarm(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      originalDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}original_date'])!,
      scheduledHour: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}scheduled_hour'])!,
      scheduledMinute: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}scheduled_minute'])!,
      recurrenceType: $AlarmsTable.$converterrecurrenceType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}recurrence_type'])!),
      customWeekdays: $AlarmsTable.$convertercustomWeekdaysn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}custom_weekdays'])),
      preAlertOffsets: $AlarmsTable.$converterpreAlertOffsets.fromSql(
          attachedDatabase.typeMapping.read(DriftSqlType.string,
              data['${effectivePrefix}pre_alert_offsets'])!),
      isEnabled: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_enabled'])!,
      soundId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sound_id'])!,
      snoozeDuration: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}snooze_duration'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $AlarmsTable createAlias(String alias) {
    return $AlarmsTable(attachedDatabase, alias);
  }

  static TypeConverter<RecurrenceType, String> $converterrecurrenceType =
      const RecurrenceTypeConverter();
  static TypeConverter<List<int>, String> $convertercustomWeekdays =
      const IntListConverter();
  static TypeConverter<List<int>?, String?> $convertercustomWeekdaysn =
      NullAwareTypeConverter.wrap($convertercustomWeekdays);
  static TypeConverter<List<int>, String> $converterpreAlertOffsets =
      const IntListConverter();
}

class Alarm extends DataClass implements Insertable<Alarm> {
  final int id;
  final String title;
  final DateTime originalDate;
  final int scheduledHour;
  final int scheduledMinute;
  final RecurrenceType recurrenceType;
  final List<int>? customWeekdays;
  final List<int> preAlertOffsets;
  final bool isEnabled;
  final String soundId;
  final int snoozeDuration;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Alarm(
      {required this.id,
      required this.title,
      required this.originalDate,
      required this.scheduledHour,
      required this.scheduledMinute,
      required this.recurrenceType,
      this.customWeekdays,
      required this.preAlertOffsets,
      required this.isEnabled,
      required this.soundId,
      required this.snoozeDuration,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['original_date'] = Variable<DateTime>(originalDate);
    map['scheduled_hour'] = Variable<int>(scheduledHour);
    map['scheduled_minute'] = Variable<int>(scheduledMinute);
    {
      map['recurrence_type'] = Variable<String>(
          $AlarmsTable.$converterrecurrenceType.toSql(recurrenceType));
    }
    if (!nullToAbsent || customWeekdays != null) {
      map['custom_weekdays'] = Variable<String>(
          $AlarmsTable.$convertercustomWeekdaysn.toSql(customWeekdays));
    }
    {
      map['pre_alert_offsets'] = Variable<String>(
          $AlarmsTable.$converterpreAlertOffsets.toSql(preAlertOffsets));
    }
    map['is_enabled'] = Variable<bool>(isEnabled);
    map['sound_id'] = Variable<String>(soundId);
    map['snooze_duration'] = Variable<int>(snoozeDuration);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AlarmsCompanion toCompanion(bool nullToAbsent) {
    return AlarmsCompanion(
      id: Value(id),
      title: Value(title),
      originalDate: Value(originalDate),
      scheduledHour: Value(scheduledHour),
      scheduledMinute: Value(scheduledMinute),
      recurrenceType: Value(recurrenceType),
      customWeekdays: customWeekdays == null && nullToAbsent
          ? const Value.absent()
          : Value(customWeekdays),
      preAlertOffsets: Value(preAlertOffsets),
      isEnabled: Value(isEnabled),
      soundId: Value(soundId),
      snoozeDuration: Value(snoozeDuration),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Alarm.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Alarm(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      originalDate: serializer.fromJson<DateTime>(json['originalDate']),
      scheduledHour: serializer.fromJson<int>(json['scheduledHour']),
      scheduledMinute: serializer.fromJson<int>(json['scheduledMinute']),
      recurrenceType:
          serializer.fromJson<RecurrenceType>(json['recurrenceType']),
      customWeekdays: serializer.fromJson<List<int>?>(json['customWeekdays']),
      preAlertOffsets: serializer.fromJson<List<int>>(json['preAlertOffsets']),
      isEnabled: serializer.fromJson<bool>(json['isEnabled']),
      soundId: serializer.fromJson<String>(json['soundId']),
      snoozeDuration: serializer.fromJson<int>(json['snoozeDuration']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'originalDate': serializer.toJson<DateTime>(originalDate),
      'scheduledHour': serializer.toJson<int>(scheduledHour),
      'scheduledMinute': serializer.toJson<int>(scheduledMinute),
      'recurrenceType': serializer.toJson<RecurrenceType>(recurrenceType),
      'customWeekdays': serializer.toJson<List<int>?>(customWeekdays),
      'preAlertOffsets': serializer.toJson<List<int>>(preAlertOffsets),
      'isEnabled': serializer.toJson<bool>(isEnabled),
      'soundId': serializer.toJson<String>(soundId),
      'snoozeDuration': serializer.toJson<int>(snoozeDuration),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Alarm copyWith(
          {int? id,
          String? title,
          DateTime? originalDate,
          int? scheduledHour,
          int? scheduledMinute,
          RecurrenceType? recurrenceType,
          Value<List<int>?> customWeekdays = const Value.absent(),
          List<int>? preAlertOffsets,
          bool? isEnabled,
          String? soundId,
          int? snoozeDuration,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      Alarm(
        id: id ?? this.id,
        title: title ?? this.title,
        originalDate: originalDate ?? this.originalDate,
        scheduledHour: scheduledHour ?? this.scheduledHour,
        scheduledMinute: scheduledMinute ?? this.scheduledMinute,
        recurrenceType: recurrenceType ?? this.recurrenceType,
        customWeekdays:
            customWeekdays.present ? customWeekdays.value : this.customWeekdays,
        preAlertOffsets: preAlertOffsets ?? this.preAlertOffsets,
        isEnabled: isEnabled ?? this.isEnabled,
        soundId: soundId ?? this.soundId,
        snoozeDuration: snoozeDuration ?? this.snoozeDuration,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  Alarm copyWithCompanion(AlarmsCompanion data) {
    return Alarm(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      originalDate: data.originalDate.present
          ? data.originalDate.value
          : this.originalDate,
      scheduledHour: data.scheduledHour.present
          ? data.scheduledHour.value
          : this.scheduledHour,
      scheduledMinute: data.scheduledMinute.present
          ? data.scheduledMinute.value
          : this.scheduledMinute,
      recurrenceType: data.recurrenceType.present
          ? data.recurrenceType.value
          : this.recurrenceType,
      customWeekdays: data.customWeekdays.present
          ? data.customWeekdays.value
          : this.customWeekdays,
      preAlertOffsets: data.preAlertOffsets.present
          ? data.preAlertOffsets.value
          : this.preAlertOffsets,
      isEnabled: data.isEnabled.present ? data.isEnabled.value : this.isEnabled,
      soundId: data.soundId.present ? data.soundId.value : this.soundId,
      snoozeDuration: data.snoozeDuration.present
          ? data.snoozeDuration.value
          : this.snoozeDuration,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Alarm(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('originalDate: $originalDate, ')
          ..write('scheduledHour: $scheduledHour, ')
          ..write('scheduledMinute: $scheduledMinute, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('customWeekdays: $customWeekdays, ')
          ..write('preAlertOffsets: $preAlertOffsets, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('soundId: $soundId, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      title,
      originalDate,
      scheduledHour,
      scheduledMinute,
      recurrenceType,
      customWeekdays,
      preAlertOffsets,
      isEnabled,
      soundId,
      snoozeDuration,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Alarm &&
          other.id == this.id &&
          other.title == this.title &&
          other.originalDate == this.originalDate &&
          other.scheduledHour == this.scheduledHour &&
          other.scheduledMinute == this.scheduledMinute &&
          other.recurrenceType == this.recurrenceType &&
          other.customWeekdays == this.customWeekdays &&
          other.preAlertOffsets == this.preAlertOffsets &&
          other.isEnabled == this.isEnabled &&
          other.soundId == this.soundId &&
          other.snoozeDuration == this.snoozeDuration &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AlarmsCompanion extends UpdateCompanion<Alarm> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> originalDate;
  final Value<int> scheduledHour;
  final Value<int> scheduledMinute;
  final Value<RecurrenceType> recurrenceType;
  final Value<List<int>?> customWeekdays;
  final Value<List<int>> preAlertOffsets;
  final Value<bool> isEnabled;
  final Value<String> soundId;
  final Value<int> snoozeDuration;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AlarmsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.originalDate = const Value.absent(),
    this.scheduledHour = const Value.absent(),
    this.scheduledMinute = const Value.absent(),
    this.recurrenceType = const Value.absent(),
    this.customWeekdays = const Value.absent(),
    this.preAlertOffsets = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.soundId = const Value.absent(),
    this.snoozeDuration = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AlarmsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required DateTime originalDate,
    required int scheduledHour,
    required int scheduledMinute,
    required RecurrenceType recurrenceType,
    this.customWeekdays = const Value.absent(),
    this.preAlertOffsets = const Value.absent(),
    this.isEnabled = const Value.absent(),
    this.soundId = const Value.absent(),
    this.snoozeDuration = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : title = Value(title),
        originalDate = Value(originalDate),
        scheduledHour = Value(scheduledHour),
        scheduledMinute = Value(scheduledMinute),
        recurrenceType = Value(recurrenceType);
  static Insertable<Alarm> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? originalDate,
    Expression<int>? scheduledHour,
    Expression<int>? scheduledMinute,
    Expression<String>? recurrenceType,
    Expression<String>? customWeekdays,
    Expression<String>? preAlertOffsets,
    Expression<bool>? isEnabled,
    Expression<String>? soundId,
    Expression<int>? snoozeDuration,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (originalDate != null) 'original_date': originalDate,
      if (scheduledHour != null) 'scheduled_hour': scheduledHour,
      if (scheduledMinute != null) 'scheduled_minute': scheduledMinute,
      if (recurrenceType != null) 'recurrence_type': recurrenceType,
      if (customWeekdays != null) 'custom_weekdays': customWeekdays,
      if (preAlertOffsets != null) 'pre_alert_offsets': preAlertOffsets,
      if (isEnabled != null) 'is_enabled': isEnabled,
      if (soundId != null) 'sound_id': soundId,
      if (snoozeDuration != null) 'snooze_duration': snoozeDuration,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AlarmsCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<DateTime>? originalDate,
      Value<int>? scheduledHour,
      Value<int>? scheduledMinute,
      Value<RecurrenceType>? recurrenceType,
      Value<List<int>?>? customWeekdays,
      Value<List<int>>? preAlertOffsets,
      Value<bool>? isEnabled,
      Value<String>? soundId,
      Value<int>? snoozeDuration,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt}) {
    return AlarmsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      originalDate: originalDate ?? this.originalDate,
      scheduledHour: scheduledHour ?? this.scheduledHour,
      scheduledMinute: scheduledMinute ?? this.scheduledMinute,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      customWeekdays: customWeekdays ?? this.customWeekdays,
      preAlertOffsets: preAlertOffsets ?? this.preAlertOffsets,
      isEnabled: isEnabled ?? this.isEnabled,
      soundId: soundId ?? this.soundId,
      snoozeDuration: snoozeDuration ?? this.snoozeDuration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (originalDate.present) {
      map['original_date'] = Variable<DateTime>(originalDate.value);
    }
    if (scheduledHour.present) {
      map['scheduled_hour'] = Variable<int>(scheduledHour.value);
    }
    if (scheduledMinute.present) {
      map['scheduled_minute'] = Variable<int>(scheduledMinute.value);
    }
    if (recurrenceType.present) {
      map['recurrence_type'] = Variable<String>(
          $AlarmsTable.$converterrecurrenceType.toSql(recurrenceType.value));
    }
    if (customWeekdays.present) {
      map['custom_weekdays'] = Variable<String>(
          $AlarmsTable.$convertercustomWeekdaysn.toSql(customWeekdays.value));
    }
    if (preAlertOffsets.present) {
      map['pre_alert_offsets'] = Variable<String>(
          $AlarmsTable.$converterpreAlertOffsets.toSql(preAlertOffsets.value));
    }
    if (isEnabled.present) {
      map['is_enabled'] = Variable<bool>(isEnabled.value);
    }
    if (soundId.present) {
      map['sound_id'] = Variable<String>(soundId.value);
    }
    if (snoozeDuration.present) {
      map['snooze_duration'] = Variable<int>(snoozeDuration.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AlarmsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('originalDate: $originalDate, ')
          ..write('scheduledHour: $scheduledHour, ')
          ..write('scheduledMinute: $scheduledMinute, ')
          ..write('recurrenceType: $recurrenceType, ')
          ..write('customWeekdays: $customWeekdays, ')
          ..write('preAlertOffsets: $preAlertOffsets, ')
          ..write('isEnabled: $isEnabled, ')
          ..write('soundId: $soundId, ')
          ..write('snoozeDuration: $snoozeDuration, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$DontForgetDatabase extends GeneratedDatabase {
  _$DontForgetDatabase(QueryExecutor e) : super(e);
  $DontForgetDatabaseManager get managers => $DontForgetDatabaseManager(this);
  late final $AlarmsTable alarms = $AlarmsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [alarms];
}

typedef $$AlarmsTableCreateCompanionBuilder = AlarmsCompanion Function({
  Value<int> id,
  required String title,
  required DateTime originalDate,
  required int scheduledHour,
  required int scheduledMinute,
  required RecurrenceType recurrenceType,
  Value<List<int>?> customWeekdays,
  Value<List<int>> preAlertOffsets,
  Value<bool> isEnabled,
  Value<String> soundId,
  Value<int> snoozeDuration,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$AlarmsTableUpdateCompanionBuilder = AlarmsCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<DateTime> originalDate,
  Value<int> scheduledHour,
  Value<int> scheduledMinute,
  Value<RecurrenceType> recurrenceType,
  Value<List<int>?> customWeekdays,
  Value<List<int>> preAlertOffsets,
  Value<bool> isEnabled,
  Value<String> soundId,
  Value<int> snoozeDuration,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

class $$AlarmsTableFilterComposer
    extends Composer<_$DontForgetDatabase, $AlarmsTable> {
  $$AlarmsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get originalDate => $composableBuilder(
      column: $table.originalDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scheduledHour => $composableBuilder(
      column: $table.scheduledHour, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get scheduledMinute => $composableBuilder(
      column: $table.scheduledMinute,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<RecurrenceType, RecurrenceType, String>
      get recurrenceType => $composableBuilder(
          column: $table.recurrenceType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<int>?, List<int>, String>
      get customWeekdays => $composableBuilder(
          column: $table.customWeekdays,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<int>, List<int>, String>
      get preAlertOffsets => $composableBuilder(
          column: $table.preAlertOffsets,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get soundId => $composableBuilder(
      column: $table.soundId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get snoozeDuration => $composableBuilder(
      column: $table.snoozeDuration,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$AlarmsTableOrderingComposer
    extends Composer<_$DontForgetDatabase, $AlarmsTable> {
  $$AlarmsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get originalDate => $composableBuilder(
      column: $table.originalDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scheduledHour => $composableBuilder(
      column: $table.scheduledHour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get scheduledMinute => $composableBuilder(
      column: $table.scheduledMinute,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get recurrenceType => $composableBuilder(
      column: $table.recurrenceType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customWeekdays => $composableBuilder(
      column: $table.customWeekdays,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get preAlertOffsets => $composableBuilder(
      column: $table.preAlertOffsets,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isEnabled => $composableBuilder(
      column: $table.isEnabled, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get soundId => $composableBuilder(
      column: $table.soundId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get snoozeDuration => $composableBuilder(
      column: $table.snoozeDuration,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$AlarmsTableAnnotationComposer
    extends Composer<_$DontForgetDatabase, $AlarmsTable> {
  $$AlarmsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get originalDate => $composableBuilder(
      column: $table.originalDate, builder: (column) => column);

  GeneratedColumn<int> get scheduledHour => $composableBuilder(
      column: $table.scheduledHour, builder: (column) => column);

  GeneratedColumn<int> get scheduledMinute => $composableBuilder(
      column: $table.scheduledMinute, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RecurrenceType, String> get recurrenceType =>
      $composableBuilder(
          column: $table.recurrenceType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<int>?, String> get customWeekdays =>
      $composableBuilder(
          column: $table.customWeekdays, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<int>, String> get preAlertOffsets =>
      $composableBuilder(
          column: $table.preAlertOffsets, builder: (column) => column);

  GeneratedColumn<bool> get isEnabled =>
      $composableBuilder(column: $table.isEnabled, builder: (column) => column);

  GeneratedColumn<String> get soundId =>
      $composableBuilder(column: $table.soundId, builder: (column) => column);

  GeneratedColumn<int> get snoozeDuration => $composableBuilder(
      column: $table.snoozeDuration, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AlarmsTableTableManager extends RootTableManager<
    _$DontForgetDatabase,
    $AlarmsTable,
    Alarm,
    $$AlarmsTableFilterComposer,
    $$AlarmsTableOrderingComposer,
    $$AlarmsTableAnnotationComposer,
    $$AlarmsTableCreateCompanionBuilder,
    $$AlarmsTableUpdateCompanionBuilder,
    (Alarm, BaseReferences<_$DontForgetDatabase, $AlarmsTable, Alarm>),
    Alarm,
    PrefetchHooks Function()> {
  $$AlarmsTableTableManager(_$DontForgetDatabase db, $AlarmsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AlarmsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AlarmsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AlarmsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<DateTime> originalDate = const Value.absent(),
            Value<int> scheduledHour = const Value.absent(),
            Value<int> scheduledMinute = const Value.absent(),
            Value<RecurrenceType> recurrenceType = const Value.absent(),
            Value<List<int>?> customWeekdays = const Value.absent(),
            Value<List<int>> preAlertOffsets = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<String> soundId = const Value.absent(),
            Value<int> snoozeDuration = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AlarmsCompanion(
            id: id,
            title: title,
            originalDate: originalDate,
            scheduledHour: scheduledHour,
            scheduledMinute: scheduledMinute,
            recurrenceType: recurrenceType,
            customWeekdays: customWeekdays,
            preAlertOffsets: preAlertOffsets,
            isEnabled: isEnabled,
            soundId: soundId,
            snoozeDuration: snoozeDuration,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required DateTime originalDate,
            required int scheduledHour,
            required int scheduledMinute,
            required RecurrenceType recurrenceType,
            Value<List<int>?> customWeekdays = const Value.absent(),
            Value<List<int>> preAlertOffsets = const Value.absent(),
            Value<bool> isEnabled = const Value.absent(),
            Value<String> soundId = const Value.absent(),
            Value<int> snoozeDuration = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
          }) =>
              AlarmsCompanion.insert(
            id: id,
            title: title,
            originalDate: originalDate,
            scheduledHour: scheduledHour,
            scheduledMinute: scheduledMinute,
            recurrenceType: recurrenceType,
            customWeekdays: customWeekdays,
            preAlertOffsets: preAlertOffsets,
            isEnabled: isEnabled,
            soundId: soundId,
            snoozeDuration: snoozeDuration,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$AlarmsTable, Alarm>(table),
                    BaseReferences<_$DontForgetDatabase, $AlarmsTable, Alarm>(
                        db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$AlarmsTableProcessedTableManager = ProcessedTableManager<
    _$DontForgetDatabase,
    $AlarmsTable,
    Alarm,
    $$AlarmsTableFilterComposer,
    $$AlarmsTableOrderingComposer,
    $$AlarmsTableAnnotationComposer,
    $$AlarmsTableCreateCompanionBuilder,
    $$AlarmsTableUpdateCompanionBuilder,
    (Alarm, BaseReferences<_$DontForgetDatabase, $AlarmsTable, Alarm>),
    Alarm,
    PrefetchHooks Function()>;

class $DontForgetDatabaseManager {
  final _$DontForgetDatabase _db;
  $DontForgetDatabaseManager(this._db);
  $$AlarmsTableTableManager get alarms =>
      $$AlarmsTableTableManager(_db, _db.alarms);
}

// Copyright 2020 Aleksandr Cegel'nikov

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at

//   http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Соответствует операции GetExtandedConfig
Функция ПолучитьРасширениеКонфигурации(ИмяРасширения, ХешСумма, Результат, ИсхДанные)

	УстановитьПривилегированныйРежим(Истина); // Пользователь вебсервиса не полноправный пользователь, компенсируем это
	
	Если ПустаяСтрока(ИмяРасширения) Тогда
		
		Результат = Ложь;
		Возврат "Не указано имя расширения!";
		
	КонецЕсли;
	
	Расширения = РасширенияКонфигурации.Получить(Новый Структура("Имя", ИмяРасширения)); // Ищем расширение по полученному имени
	
	Если Расширения.Количество() <= 0 Тогда
		
		Результат = Ложь;
		Возврат "Расширение по указанному имени не найдено!";
		
	КонецЕсли;
	
	ТребуемоеРасширение = Расширения[0];
	
	Если ПустаяСтрока(ХешСумма) или ХешСумма <> Base64Строка(ТребуемоеРасширение.ХешСумма) Тогда // Либо первое получение, либо расширение изменилось
		
		Результат = Истина;
		ИсхДанные = Новый ХранилищеЗначения(ТребуемоеРасширение.ПолучитьДанные()); // Сжимать смысла нет, только ресурсы тратить
		Возврат "Доступно обновление расширения";
		
	КонецЕсли;
	
	Результат = Истина;
	Возврат "Нет обновлений расширения";
	
КонецФункции // ПолучитьРасширениеКонфигурации()
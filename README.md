# Тестовое задание по SQL

Пять запросов к PostgreSQL и отчёт о проверке. Схема, данные и запросы лежат рядом, всё проверено на живой базе.

## Файлы

- `schema.sql` — таблицы categories, products, customers, orders, order_items с ключами и ограничениями;
- `data.sql` — тестовые данные: три категории, одиннадцать товаров, пять клиентов, шесть заказов;
- `queries.sql` — пять запросов из задания;
- `answer.txt` — ответ с результатами и отчётом.

## Как повторить

```
createdb shop_test
psql -d shop_test -f schema.sql
psql -d shop_test -f data.sql
psql -d shop_test -f queries.sql
```

Схема создаётся в отдельной схеме `shop`, поиск переключается через `search_path` в начале скриптов.

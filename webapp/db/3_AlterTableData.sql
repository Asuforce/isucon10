ALTER TABLE chair ADD INDEX index_price(price);
ALTER TABLE chair ADD INDEX index_kind_stock(kind, stock);
ALTER TABLE estate ADD INDEX index_rent(rent);

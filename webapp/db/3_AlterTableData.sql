ALTER TABLE chair ADD INDEX index_chair_on_price(price);
ALTER TABLE chair ADD INDEX index_chair_on_kind_on_stock(kind, stock);
ALTER TABLE estate ADD INDEX index_estate_on_rent(rent);

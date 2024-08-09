CREATE TABLE test_table
(
    id UInt32,
    name String,
    age UInt32
) ENGINE = MergeTree()
ORDER BY id;

INSERT INTO test_table (id, name, age) VALUES (1, 'John Doe', 30);



SELECT * FROM test_table;

SELECT * FROM test_table WHERE age > 25;
